import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
extension UserDataList on List<QueryDocumentSnapshot> {
  /// Helper method to make it easier to get data for the current user.
  // Figuring out how to do this manually was a pain, and also a lot of code.
  // It is pulled out into a method for simplicity.
  QueryDocumentSnapshot dataForCurrentUser() {
    var user = FirebaseAuth.instance.currentUser;
    return firstWhere((elem) => elem.id == user!.uid);
  }
}

class Database {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static DocumentReference<Map<String, dynamic>>? _currentUserDoc() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return db.collection('users').doc(user.uid);
  }

  static dynamic userDataByFieldName(String field) {
    throw UnimplementedError('need to do this');
  }

  static void establishBalance(int bal) {
    _currentUserDoc()?.set({"balance": bal});
  }

  static void addBalance(int bal) {
    _currentUserDoc()?.update({"balance": bal});
  }

  /// StreamBuilder that collects 'field' from the database and uses 'style' TextStyle.
  /// For example: databaseStreamBuilder(field: 'balance', isMoney: true, style: ...) will give the balance
  /// of the current user, formatted in the style provided.
  static StreamBuilder fieldFromUser({
    required String field,
    required bool isMoney,
    required TextStyle style,
  }) {
    return StreamBuilder(
      stream: Database.db.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || FirebaseAuth.instance.currentUser == null) {
          return Text('\$99,999.99', style: style);
        }

        List<QueryDocumentSnapshot> list = snapshot.data?.docs;

        var fieldValue = list.dataForCurrentUser()[field];

        // We need to handle the case where the field is money-related.
        // We have *some* trust in the user of this API as to whether or
        // not the field they ask for is actually related to money. Here,
        // we use the money representation only if the runtime type of the
        // field is an int, even if the caller specifies isMoney=true.
        if (isMoney && fieldValue.runtimeType == int) {
          return Text(Balance(fieldValue).toString(), style: style);
        } else {
          return Text("$fieldValue", style: style);
        }
      },
    );
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
  _transactions() async {
    var transactions = await _currentUserDoc()
        ?.collection('transactions')
        .get();

    return transactions?.docs;
  }

  static dynamic addTransaction(MoneyTransaction t) async {
    /*var transaction_doc = (await _transactions())!;
    transaction_doc.add(t.intoMap());*/
    throw UnimplementedError("Need to implement addTransaction()");
  }

  static Future<List<MoneyTransaction>?> getAllTransactions() async {
    Database._transactions();
    var transactions = await _transactions();
    List<MoneyTransaction>? t = transactions?.map((elem) {
      return MoneyTransaction.fromMap(elem.data());
    }).toList();
    return t;
  }

  static Future<MoneyTransaction> transactionWhere(
    bool Function(dynamic elem) cmpFunc,
  ) async {
    var transactions = await _transactions();
    return MoneyTransaction.fromMap(transactions?.firstWhere(cmpFunc).data());
  }
}

/// Transaction entry:
/// - description (String)
/// - price (cents -- int)
/// - category (String)
/// - date (String)
class MoneyTransaction {
  late String description;
  late int priceCents;
  late String category;
  late String date;

  MoneyTransaction();

  static MoneyTransaction fromValues({
    required String desc,
    required int amountCents,
    required String category,
    required String date,
  }) {
    MoneyTransaction mt = MoneyTransaction();
    mt.description = desc;
    mt.priceCents = amountCents;
    mt.category = category;
    mt.date = date;
    return mt;
  }

  static MoneyTransaction fromMap(Map<String, dynamic>? map) {
    MoneyTransaction dbt = MoneyTransaction();
    dbt.description = map?.entries
        .firstWhere((elem) => elem.key == 'description')
        .value;
    dbt.priceCents = map?.entries
        .firstWhere((elem) => elem.key == 'priceCents')
        .value;
    dbt.category = map?.entries
        .firstWhere((elem) => elem.key == 'category')
        .value;
    dbt.date = map?.entries.firstWhere((elem) => elem.key == 'date').value;
    return dbt;
  }

  Map<String, dynamic> intoMap() {
    Map<String, dynamic> ret = {};
    int priceCents = this.priceCents;
    String category = this.category;
    String description = this.description;
    String date = this.date;
    ret.addEntries(<String, int>{'priceCents': priceCents}.entries);
    ret.addEntries(<String, String>{'category': category}.entries);
    ret.addEntries(<String, String>{'description': description}.entries);
    ret.addEntries(<String, String>{'date': date}.entries);
    return ret;
  }
}

class Balance {
  int balanceCents;
  Balance(this.balanceCents);
  @override
  String toString() {
    int cents = balanceCents % 100;
    int dollars = balanceCents ~/ 100; // divide with integer truncation
    return "\$$dollars.${cents.toString().padLeft(2, "0")}";
  }
}

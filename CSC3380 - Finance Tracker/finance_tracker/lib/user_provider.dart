import 'package:flutter/material.dart';

class AccountData {
  String name;
  String last4;
  double balance;
  IconData icon;

  AccountData({
    required this.name,
    required this.last4,
    required this.balance,
    required this.icon,
  });
}

class UserProvider extends ChangeNotifier {
  String userName = "Landon Snow";
  String userEmail = "landon.snow@example.com";

  void updateProfile(String name, String email) {
    userName = name ;
    userEmail = email;
    notifyListeners();
}
//-----Default accounts-------
List<AccountData> accounts = [
  AccountData(
    name: "Chase Checking",
    last4: "1234",
    balance: 1250.00,
    icon: Icons.account_balance,
  ),
  AccountData(
    name: "Amex Gold",
    last4: "5678",
    balance: -365.32,
    icon: Icons.credit_card, 
  ),
];
//----- Update Profile Info
void addAccount(AccountData newAcc) {
accounts.add(newAcc);
notifyListeners();
}
//----- Remove Account
void removeAccount(int index) {
  accounts.removeAt(index);
  notifyListeners();
  }
}

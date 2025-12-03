import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:finance_tracker/user_provider.dart';


class AccountPage extends StatefulWidget {
  const AccountPage ({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

//based this off dashboard subject to change
class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(context),
            SizedBox(height: 20),

            _buildLinkedAccountsSection(context),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


// ------------ Account/Profile Section ----------------
Widget _buildProfileSection(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  return Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    /*---- Title -----
    //Text(
     // 'Account',
      //style: TextStyle(
       // fontSize: 20, //subject to change
        //fontWeight: FontWeight.bold,
        //color: Colors.black , //subject to change
        //)
    //),

    SizedBox(width: 20),

    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
*/
//--- Profile Avatar Circle
  CircleAvatar(
    radius: 32,
    backgroundColor: userProvider.userAvatarColor,
    child: Text(
      (userProvider.tempName.isNotEmpty
      ? userProvider.tempName[0]
      : userProvider.userName[0]
      ).toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
),

SizedBox(width: 20),

//--- Name/Email ----
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      userProvider.userName,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        ),
      ),
  SizedBox(height: 6),
  
  Text(
    userProvider.userEmail,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
                ),
              ),
            ],
          ),
    Spacer(),

    //Edit Profile 
    TextButton(
      onPressed: () => showEditProfileDialog(context),
      child:
      Row(
        children: [
          Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: 18,
            ),
          ],
        ),
      ),
    ],
  ); 
}

// ------------ Linked Account Section -------------
Widget _buildLinkedAccountsSection(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context);
  return Expanded(
    child:Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
//---- Title ----
    Text(
     'Linked Accounts',
      style: TextStyle(
        fontSize: 22, //all subject to change
        fontWeight: FontWeight.bold),
    ),

SizedBox(height: 16),
//------- Cash Wallet not removable)
_accountCard(
  acc: AccountData(
    name: "Cash Wallet",
    last4: "----",
    balance: 0.00,
    icon: Icons.account_balance_wallet,
  ),
  index: null,
),

const SizedBox(height: 12),

//----- User Accounts,
Expanded(
  child: ListView.builder(
    itemCount: userProvider.accounts.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          _accountCard(
          acc: userProvider.accounts[index],
          index : index,
          ),
          const SizedBox(height: 12),
        ],
      );  
    },
  ),
),

SizedBox(height: 8),

_addAccountButton(context),
      ],
    ),
  );
}

//---- UI Account Card
Widget _accountCard({
  required AccountData acc,
  required int? index,
}) {
  final balanceColor = 
  acc.balance < 0 ? Colors.red: (acc.balance == 0 ? Colors.grey : Colors.green);

return Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: Row(
    children: [
      Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(acc.icon, size: 28, color: Colors.grey),
      ),
      SizedBox(width: 12),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            acc.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "**** ${acc.last4}",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
      Spacer(),
      Text(
        "\$${acc.balance.toStringAsFixed(2)}",
        style: TextStyle(
        color: balanceColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        ),
      ),
      //---- To delete ----
      if (index != null)
      GestureDetector(
        onTap: () => _confirmDelete(context, index),
        child: const Icon(Icons.delete, color: Colors.red)
      ),
    ],
  ),
);
}

//--- Add Account Button ----
Widget _addAccountButton(BuildContext context) {
return GestureDetector(
  onTap: () => showAddAccountDialog(context),

/*
//----- View all ------
Row(
  children: [
  Text(
    'View All',
    style: TextStyle(
      fontSize: 14,
      color: Colors.green,
      fontWeight: FontWeight.w600,
      ),
    ),
    Icon(Icons.chevron_right, color: Colors.green, size: 20),
        ],
      ),

    ],
*/

  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.12),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add, color: Colors.green),


        SizedBox(width: 8),

        Text(
          'Add Account',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
                ),
              ),
            ],
          ),
       ),
    );
  }
}

void showEditProfileDialog(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  final nameCtrl = TextEditingController(text: userProvider.userName);
  
  // Like the category page
    final List<Color> avatarColors = [
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.teal,
    Colors.red,
    Colors.pink,
    Colors.yellow,
    Colors.indigo,
    Colors.brown,
  ];

  Color selectedColor = userProvider.userAvatarColor;


  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20),
            ),
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name"),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
            ],
            onChanged: (value) {
              userProvider.updateTempName(value);
            },
          ),

        SizedBox(height: 20),

        const Text(
          "Select Avatar Color",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height:10),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: avatarColors.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: color,
                child: (selectedColor == color)
                ? const Icon(Icons.check, color: Colors.white)
                : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            userProvider.updateProfile(nameCtrl.text);
            userProvider.updateAvatarColor(selectedColor);
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
      );
    },
  );
},
  );
}



void showAddAccountDialog(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  final nameCtrl = TextEditingController();
  final last4Ctrl = TextEditingController();
  final balanceCtrl = TextEditingController();

  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Add Account"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Account Name")),
            //----- Only allows number + last4
            TextField(
              controller: last4Ctrl,
              decoration: const InputDecoration(
                labelText: "Last 4 Digits",
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            //----- only Numbers and decimal
            TextField(
              controller: balanceCtrl,
              decoration: const InputDecoration(labelText : "Balance"),
              keyboardType: const TextInputType.numberWithOptions(decimal:true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),
          ],
        ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            //------ Validate
            if (last4Ctrl.text.length != 4) {
              return;
            }
            if (double.tryParse(balanceCtrl.text) == null) {
              return;
            }
          
          //Create account
            final acc = AccountData(
              name: nameCtrl.text,
              last4: last4Ctrl.text,
              balance: double.tryParse(balanceCtrl.text) ?? 0.0,
              icon: Icons.account_balance,
            );
            userProvider.addAccount(acc);
            
            Navigator.pop(context);
          },
          child: const Text("Add"),
          ),
        ],
      );
    },
  );
}

//----- DELETE LINKED ACCOUNT ----
void _confirmDelete(BuildContext context, int index) {
  showDialog(context: context,
  builder: (context) {
    return AlertDialog(
      title: const Text("Unlink Account?"),
      content:
        const Text("Are you sure you want to remove this Linked Account?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                .removeAccount(index);
              Navigator.pop(context);
            },
            child: const Text("Remove", style: TextStyle(color: Colors.red)),
          ),
        ],
    );
  },
  );
}
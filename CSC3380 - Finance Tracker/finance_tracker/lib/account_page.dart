import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            SizedBox(height: 20),

            _buildLinkedAccountsSection(),
            SizedBox(height: 20),

            _buildIncomeExpenseSection(),
            SizedBox(height: 20),

            _buildSupportSection(),
          ],

        ),
      ),
    );
  }
}

// ------------ Account/Profile Section ----------------
Widget _buildProfileSection() {
  return Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    //---- Title -----
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
  CircleAvatar(
    radius: 32,
    backgroundColor: Colors.green,
    child: Text(
      'L',
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
      'Landon Snow',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      ),
  SizedBox(height: 10),
  
  Text(
    'landon.snow@example.com',
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    SizedBox(width: 20),
    Spacer(),
    TextButton(
      onPressed: (){},
      child: Row(
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
            size: 20,
            ),
          ],
        ),
      ),
    ],
  ); 
}

// ------------ Linked Account Section -------------
Widget _buildLinkedAccountsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
//---- Title ----
Text(
  'Linked Accounts',
  style: TextStyle(
    fontSize: 20, //all subject to change
    fontWeight: FontWeight.bold,
    color: Colors.black,
),
),
SizedBox(height: 10),
// --- Card ----
Container(
padding: EdgeInsets.all(16),
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(
    color: Colors.white,
    width: 1,
  ),
),

child: Row(
  children: [
    // Bank icon
    Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
      Icons.account_balance,
      size: 28,
      color: Colors.grey,
      ),
    ),
    
    SizedBox(width:12 ),

    // Text Column
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chase Checking',
       style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,

       ),
       ),
       SizedBox(height: 4),

       Text(
        '**** 1234',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.grey,

        ),
       ),
      ],
    ),
    Spacer(),
    // ------- View All -------
    Text(
      'View All',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF2E7D32),
        fontWeight: FontWeight.w600,

              ),
            ),
          ],
        )
      )
    ]
  );
}

// ---------- Income/Expense Account ---------
Widget _buildIncomeExpenseSection(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

// ---- Title ----
Text(
  'Income / Expense Accounts',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
),

SizedBox(height: 12),

// ---- Default Income Account Row -----
Container(
padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(
    color: Color(0xFFE0E0E0),
    width: 1,
  ),
),
child: Row(
  children: [
    Text(
      'Default Income Account',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
   
    Spacer(),
    Icon(Icons.chevron_right, color: Colors.grey, size: 26),
          ],
        ),
      ),
      SizedBox(height: 10),

      // --- Default Expense Account Row -----
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFE0E0E0),
            width: 1,
            ),
          ),
          child: Row(
            children: [
              Text(
                'Default Expense Account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey, size: 26),
              ],
          ),
        ),
      
    ],
  );
}

// ------------- Support Section -------------
Widget _buildSupportSection() {
return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    // --- Title ---
    Text(
      'Support',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),

    SizedBox(height: 12),

    // --- Help Center Row ---
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            'Help Center',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(Icons.chevron_right, color: Colors.grey, size: 26),
        ],
      ),
    ),
    SizedBox(height: 10),

    // --- Report Issue Row ----
    Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            'Report an Issue',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Icon(Icons.chevron_right, color: Colors.grey, size: 26),
          ],
        ),
      ),

    ],
) ;
}

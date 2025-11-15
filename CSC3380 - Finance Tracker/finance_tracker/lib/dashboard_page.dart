import 'package:flutter/material.dart';
import 'transaction_page.dart';
import 'add_transaction_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0, vertical:8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              const SizedBox(height: 16),
              _buildBalanceCard(),
              const SizedBox(height: 16),
              _buildRecentTransactions(),
            ],
          ),
        ),
      ),
  
      // navigation bars
      bottomNavigationBar: _buildBottomNavBar(),

      // "+" button
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// --------------- Header Section ---------------
Widget _buildHeaderSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Finance Tracker', 
        style: TextStyle(
          fontSize: 20, //insert true font
          fontWeight: FontWeight.bold,
          color: Color(0xFF2E7D32),
        ),
      ),
      const SizedBox(height: 4),
      
      Text(
        'Welcome Landon!', // make dynamic (user name)
        style: TextStyle(
          fontSize: 14, //insert true font
          color: Colors.grey[600], //insert true color
        ),
      ),
    ],
  );
}

// --------------- Balance Card ---------------
Widget _buildBalanceCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20), // Match Figma Padding
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E7D32),
            Color(0xFF1B5E20),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    child: Column(
      children: [
        // Total Balance Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.trending_up,
                    color: Colors.white.withOpacity(0.8),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '\$99,999.99', //replace with true numbers
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '+15.3% this month',
                style: TextStyle(
                  color: Color(0xFF81C784),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Income and Expense Row
        Row(
          children: [
            // Income Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Income',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$1,234', // replace with true numbers
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Expense Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Expense',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$1,234', //replace with true numbers
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//--------------- Recent Transactions ---------------
Widget _buildRecentTransactions() {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(16), //Adjust Padding
      decoration:BoxDecoration(
        color:Colors.white, //insert card background color
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius:1,
            offset: const Offset(0,4),
          ),
        ],

        border: Border.all(color: Colors.grey[300]!), //Match true border color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: "Recent Transactions" + "See All"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // replace with true color
                ),
              ),
              TextButton(
                onPressed: () {}, // Add navigation to full transaction list
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFF2E7D32), // Use real color
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Scrollable list of transations
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Make dynamic
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200], // replace with true
                  ),
                  title: Text('Transaction Title'), // TODO: Transaction name
                  subtitle: Text('Date or category'), // TODO: subtitle text
                  trailing: Text(
                    '-\$123.45', // TODO: Bind actual transaction amount
                    style: TextStyle(
                      color: Colors.red, // TODO: Red for expenses, green for income
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

//--------------- Navigation Bar ---------------
// Contains navigations icons for Home, Account, Category, and Settings
Widget _buildBottomNavBar() {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(), // adds notch for FAB
    notchMargin: 8.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.home)), // Home tab
        IconButton(onPressed: () {}, icon: const Icon(Icons.account_balance)), //Account tab
        const SizedBox(width: 40), //Space for "+" button
        IconButton(onPressed: () {}, icon: const Icon(Icons.category)), // category tab
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)), // Settings tab
      ],
    ),
  );
}

//--------------- Floating Action Button ---------------
// The "+" button 
Widget _buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      // Navigate to Add Transaction Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTransactionPage(onSave: (String dateHeader, Transaction newTransaction) {  },)),
      );
    },
    backgroundColor: Color(0xFF2E7D32), // TODO: Replace with accent color
    foregroundColor: Colors.black,
    child: const Icon(Icons.add, size: 32),
  );
}
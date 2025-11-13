import 'package:flutter/material.dart';

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
      floatingActionButton: _buildFloatingActionButton(),
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
          color: Colors.green, //insert true color
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
    padding: const EdgeInsets.all(16.0), // Match Figma Padding
    decoration: BoxDecoration(
      color: Colors.green, // replace card background color from figma
      borderRadius: BorderRadius.circular(16), //replace with true corner radius

    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // "Total Balance" Label
        Text(
          'Total Balance',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8), //DEPRECATED !!!
            fontSize: 14, // insert true font size
          ),
        ),
        const SizedBox(height: 8),

        //Balance amount
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$12,345.67', //bind to actual data
              style: TextStyle(
                fontSize: 28, // insert true font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 4),
        
        // Expense and income summary side by side
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSummaryItem('Expense', '\$1,234'), // bind actual data
            _buildSummaryItem('Income', '\$1,234'), // bind actual data
          ],
        ),
      ],
    ),
  );
}

// helper widget to show "Expense" and "Income" blocks
Widget _buildSummaryItem(String label, String amount) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8), //DEPRECATED !!!
          fontSize: 12, //replace with true font size
        ),
      ),
      const SizedBox(height: 4),
      Text(
        amount,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16, //replace with true font size
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
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
                    color: Colors.green, // Use real color
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

//--------------- Recent Transactions ---------------
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
Widget _buildFloatingActionButton() {
  return FloatingActionButton(
    onPressed: () {}, // TODO: Define what this does
    backgroundColor: Colors.green, // TODO: Replace with accent color
    child: const Icon(Icons.add, size: 32),
  );
}
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

      bottomNavigationBar: _buildBottomNavBar(),

      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    )
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


import 'package:flutter/material.dart';
import 'package:finance_tracker/features/transactions/pages/transaction_page.dart';

/// Shared state provider for managing transactions across the app
class TransactionProvider extends ChangeNotifier {
  // Grouped transactions by date
  Map<String, List<Transaction>> _groupedTransactions = {};

  // Flat list of all transactions (for easy access)
  List<Transaction> _allTransactions = [];

  // Callback to notify category provider about changes
  Function(Map<String, double>, Map<String, int>)? onTransactionsChanged;

  TransactionProvider() {
    _initializeDefaultData();
  }

  /// Initialize with default transaction data spanning 2024-2025
  void _initializeDefaultData() {
    Map<String, List<Transaction>> initialData = {
      // December 2025
      "December 1, 2025": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // November 2025
      "November 30, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$89.45',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 29, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$156.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$7.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 28, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$45.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'M',
          title: 'Movie Theater',
          category: 'Entertainment',
          value: '- \$28.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 27, 2025": [
        Transaction(
          initial: 'C',
          title: 'Chipotle',
          category: 'Food & Drink',
          value: '- \$12.85',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 26, 2025": [
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$125.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 25, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gym Membership',
          category: 'Health',
          value: '- \$45.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$6.25',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 24, 2025": [
        Transaction(
          initial: 'U',
          title: 'Uber',
          category: 'Transport',
          value: '- \$22.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 23, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$67.30',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'P',
          title: 'Pharmacy',
          category: 'Health',
          value: '- \$28.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 22, 2025": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$78.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 21, 2025": [
        Transaction(
          initial: 'D',
          title: 'Dentist',
          category: 'Health',
          value: '- \$150.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 20, 2025": [
        Transaction(
          initial: 'S',
          title: 'Spotify',
          category: 'Subscriptions',
          value: '- \$10.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$5.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 19, 2025": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$45.80',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 18, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$52.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 17, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$95.20',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 16, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$35.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 15, 2025": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 14, 2025": [
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$6.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 13, 2025": [
        Transaction(
          initial: 'L',
          title: 'Lululemon',
          category: 'Shopping',
          value: '- \$98.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 12, 2025": [
        Transaction(
          initial: 'U',
          title: 'Uber Eats',
          category: 'Food & Drink',
          value: '- \$32.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 11, 2025": [
        Transaction(
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 10, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$73.45',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 9, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$48.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 8, 2025": [
        Transaction(
          initial: 'C',
          title: 'Coffee Shop',
          category: 'Food & Drink',
          value: '- \$4.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 7, 2025": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$42.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 6, 2025": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$58.20',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 5, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$67.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 4, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$82.15',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 3, 2025": [
        Transaction(
          initial: 'U',
          title: 'Uber',
          category: 'Transport',
          value: '- \$18.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 2, 2025": [
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$7.25',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 1, 2025": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // October 2025
      "October 31, 2025": [
        Transaction(
          initial: 'P',
          title: 'Party Supplies',
          category: 'Entertainment',
          value: '- \$65.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 30, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$91.30',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 29, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$44.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 28, 2025": [
        Transaction(
          initial: 'D',
          title: 'DoorDash',
          category: 'Food & Drink',
          value: '- \$28.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 27, 2025": [
        Transaction(
          initial: 'L',
          title: 'Lululemon',
          category: 'Shopping',
          value: '- \$128.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$6.25',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 26, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$45.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'U',
          title: 'Uber',
          category: 'Transport',
          value: '- \$15.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 25, 2025": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$56.25',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'P',
          title: 'Pharmacy',
          category: 'Health',
          value: '- \$35.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 24, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$105.80',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 23, 2025": [
        Transaction(
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$5.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 22, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$50.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 21, 2025": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$72.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 20, 2025": [
        Transaction(
          initial: 'S',
          title: 'Spotify',
          category: 'Subscriptions',
          value: '- \$10.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 19, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$68.90',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 18, 2025": [
        Transaction(
          initial: 'U',
          title: 'Uber Eats',
          category: 'Food & Drink',
          value: '- \$25.40',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 17, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$89.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 16, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gym Membership',
          category: 'Health',
          value: '- \$45.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 15, 2025": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$132.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 14, 2025": [
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$6.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 13, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$77.20',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 12, 2025": [
        Transaction(
          initial: 'M',
          title: 'Movie Theater',
          category: 'Entertainment',
          value: '- \$35.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 11, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$46.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 10, 2025": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$63.80',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 9, 2025": [
        Transaction(
          initial: 'D',
          title: 'DoorDash',
          category: 'Food & Drink',
          value: '- \$31.20',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 8, 2025": [
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 7, 2025": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$84.35',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 6, 2025": [
        Transaction(
          initial: 'U',
          title: 'Uber',
          category: 'Transport',
          value: '- \$20.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 5, 2025": [
        Transaction(
          initial: 'C',
          title: 'Chipotle',
          category: 'Food & Drink',
          value: '- \$11.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 4, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$52.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 3, 2025": [
        Transaction(
          initial: 'S',
          title: 'Starbucks',
          category: 'Food & Drink',
          value: '- \$7.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 2, 2025": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$48.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 1, 2025": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // 2024 Data - October through December
      "December 30, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$102.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "December 25, 2024": [
        Transaction(
          initial: 'P',
          title: 'Party Supplies',
          category: 'Entertainment',
          value: '- \$125.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "December 20, 2024": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$234.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "December 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "December 10, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$51.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "December 5, 2024": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$68.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "December 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // November 2024
      "November 28, 2024": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$87.45',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 22, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$156.30',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$142.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 10, 2024": [
        Transaction(
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 5, 2024": [
        Transaction(
          initial: 'U',
          title: 'Uber Eats',
          category: 'Food & Drink',
          value: '- \$34.20',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "November 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // October 2024
      "October 30, 2024": [
        Transaction(
          initial: 'P',
          title: 'Pharmacy',
          category: 'Health',
          value: '- \$42.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 25, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$49.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 20, 2024": [
        Transaction(
          initial: 'S',
          title: 'Spotify',
          category: 'Subscriptions',
          value: '- \$10.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 10, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$76.85',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 5, 2024": [
        Transaction(
          initial: 'M',
          title: 'Movie Theater',
          category: 'Entertainment',
          value: '- \$29.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // September 2024
      "September 30, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$78.90',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "September 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "September 10, 2024": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$92.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "September 5, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$42.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "September 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // August 2024
      "August 28, 2024": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$65.30',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "August 20, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$88.75',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "August 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$145.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "August 10, 2024": [
        Transaction(
          initial: 'M',
          title: 'Movie Theater',
          category: 'Entertainment',
          value: '- \$32.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "August 5, 2024": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$54.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "August 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // July 2024
      "July 25, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$50.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "July 18, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$95.40',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "July 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "July 8, 2024": [
        Transaction(
          initial: 'U',
          title: 'Uber Eats',
          category: 'Food & Drink',
          value: '- \$28.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "July 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // June 2024
      "June 28, 2024": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$115.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "June 20, 2024": [
        Transaction(
          initial: 'S',
          title: 'Spotify',
          category: 'Subscriptions',
          value: '- \$10.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "June 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$128.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "June 10, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$72.35',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "June 5, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gym Membership',
          category: 'Health',
          value: '- \$45.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "June 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // May 2024
      "May 25, 2024": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$58.20',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "May 18, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$48.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "May 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "May 10, 2024": [
        Transaction(
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "May 5, 2024": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$67.89',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "May 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // April 2024
      "April 28, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$81.25',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "April 20, 2024": [
        Transaction(
          initial: 'D',
          title: 'Dentist',
          category: 'Health',
          value: '- \$150.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "April 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$118.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "April 10, 2024": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$78.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "April 5, 2024": [
        Transaction(
          initial: 'U',
          title: 'Uber',
          category: 'Transport',
          value: '- \$19.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "April 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // March 2024
      "March 28, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$52.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "March 22, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$94.60',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "March 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "March 10, 2024": [
        Transaction(
          initial: 'S',
          title: 'Spotify',
          category: 'Subscriptions',
          value: '- \$10.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "March 5, 2024": [
        Transaction(
          initial: 'L',
          title: 'Lululemon',
          category: 'Shopping',
          value: '- \$112.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "March 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // February 2024
      "February 25, 2024": [
        Transaction(
          initial: 'R',
          title: 'Restaurant',
          category: 'Food & Drink',
          value: '- \$71.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "February 20, 2024": [
        Transaction(
          initial: 'M',
          title: 'Movie Theater',
          category: 'Entertainment',
          value: '- \$38.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "February 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'E',
          title: 'Electric Bill',
          category: 'Housing',
          value: '- \$135.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "February 10, 2024": [
        Transaction(
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "February 5, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gym Membership',
          category: 'Health',
          value: '- \$45.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "February 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],

      // January 2024
      "January 28, 2024": [
        Transaction(
          initial: 'G',
          title: 'Grocery Store',
          category: 'Food & Drink',
          value: '- \$86.45',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "January 22, 2024": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$91.30',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "January 15, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'I',
          title: 'Internet Bill',
          category: 'Housing',
          value: '- \$75.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "January 10, 2024": [
        Transaction(
          initial: 'G',
          title: 'Gas Station',
          category: 'Transport',
          value: '- \$46.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "January 5, 2024": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$105.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "January 1, 2024": [
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,400.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
        Transaction(
          initial: 'R',
          title: 'Rent Payment',
          category: 'Housing',
          value: '- \$1,200.00',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
    };

    // Convert to growable lists
    _groupedTransactions = initialData.map(
      (key, value) => MapEntry(key, value.toList()),
    );

    // Flatten the list
    _allTransactions = _groupedTransactions.values
        .expand((list) => list)
        .toList();
  }

  /// Get all grouped transactions
  Map<String, List<Transaction>> get groupedTransactions => _groupedTransactions;

  /// Get all transactions as a flat list
  List<Transaction> get allTransactions => _allTransactions;

  /// Get the most recent N transactions
  List<Transaction> getRecentTransactions(int count) {
    return _allTransactions.take(count).toList();
  }

  /// Add a new transaction
  void addTransaction(String dateHeader, Transaction newTransaction) {
    String key = dateHeader.trim();

    if (_groupedTransactions.containsKey(key)) {
      // Date exists: Add to the beginning of the list
      _groupedTransactions[key]!.insert(0, newTransaction);
    } else {
      // New date: Create new entry and re-sort
      _groupedTransactions[key] = [newTransaction];
      _groupedTransactions = Map.fromEntries(
        _groupedTransactions.entries.toList()
          ..sort((a, b) => b.key.compareTo(a.key)),
      );
    }

    // Re-flatten the list
    _allTransactions = _groupedTransactions.values
        .expand((list) => list)
        .toList();

    // Calculate and notify category spending
    _notifyCategoryChanges();

    // Notify all listeners (Dashboard, TransactionPage, etc.)
    notifyListeners();
  }

  /// Calculate category spending from all transactions
  Map<String, double> calculateCategorySpending() {
    Map<String, double> spending = {};

    for (var transaction in _allTransactions) {
      // Parse the value to get the amount (remove "- $" or "+ $" and ".00")
      final valueStr = transaction.value.replaceAll(RegExp(r'[+\-\s\$]'), '');
      final amount = double.tryParse(valueStr) ?? 0.0;

      // Only count expenses (values that start with "-")
      if (transaction.value.startsWith('-')) {
        spending[transaction.category] = (spending[transaction.category] ?? 0.0) + amount;
      }
    }

    return spending;
  }

  /// Calculate transaction counts per category
  Map<String, int> calculateCategoryTransactionCounts() {
    Map<String, int> counts = {};

    for (var transaction in _allTransactions) {
      // Only count expenses
      if (transaction.value.startsWith('-')) {
        counts[transaction.category] = (counts[transaction.category] ?? 0) + 1;
      }
    }

    return counts;
  }

  /// Notify category provider about changes
  void _notifyCategoryChanges() {
    if (onTransactionsChanged != null) {
      final spending = calculateCategorySpending();
      final counts = calculateCategoryTransactionCounts();
      onTransactionsChanged!(spending, counts);
    }
  }

  /// Remove a transaction
  void removeTransaction(String dateHeader, Transaction transaction) {
    if (_groupedTransactions.containsKey(dateHeader)) {
      _groupedTransactions[dateHeader]!.remove(transaction);

      // Remove date header if no transactions left
      if (_groupedTransactions[dateHeader]!.isEmpty) {
        _groupedTransactions.remove(dateHeader);
      }

      // Re-flatten the list
      _allTransactions = _groupedTransactions.values
          .expand((list) => list)
          .toList();

      // Calculate and notify category spending
      _notifyCategoryChanges();

      notifyListeners();
    }
  }

  /// Set up the callback to notify category provider
  void setupCategoryCallback(Function(Map<String, double>, Map<String, int>) callback) {
    onTransactionsChanged = callback;
    // Initial calculation
    _notifyCategoryChanges();
  }

  /// Get transactions within a specific time period
  List<Transaction> getTransactionsByPeriod(String period) {
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case 'week':
        // Last 7 days
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'month':
        // Last 30 days
        startDate = now.subtract(const Duration(days: 30));
        break;
      case 'year':
        // Last 365 days
        startDate = now.subtract(const Duration(days: 365));
        break;
      default:
        // Return all transactions if period is not recognized
        return _allTransactions;
    }

    // Filter transactions by date
    List<Transaction> filteredTransactions = [];

    for (var entry in _groupedTransactions.entries) {
      final dateStr = entry.key;
      try {
        // Parse the date string (format: "December 1, 2025")
        final parsedDate = _parseDateHeader(dateStr);

        if (parsedDate.isAfter(startDate) || parsedDate.isAtSameMomentAs(startDate)) {
          filteredTransactions.addAll(entry.value);
        }
      } catch (e) {
        // If parsing fails, skip this entry
        continue;
      }
    }

    return filteredTransactions;
  }

  /// Parse date header string to DateTime
  DateTime _parseDateHeader(String dateHeader) {
    // Parse format like "December 1, 2025" or "October 15, 2024"
    final parts = dateHeader.split(' ');
    if (parts.length != 3) {
      throw FormatException('Invalid date format: $dateHeader');
    }

    final monthStr = parts[0].trim().replaceAll(',', '');
    final dayStr = parts[1].trim().replaceAll(',', '');
    final yearStr = parts[2].trim();

    final monthMap = {
      'January': 1, 'February': 2, 'March': 3, 'April': 4,
      'May': 5, 'June': 6, 'July': 7, 'August': 8,
      'September': 9, 'October': 10, 'November': 11, 'December': 12,
    };

    final month = monthMap[monthStr];
    if (month == null) {
      throw FormatException('Invalid month: $monthStr');
    }

    final day = int.tryParse(dayStr);
    final year = int.tryParse(yearStr);

    if (day == null || year == null) {
      throw FormatException('Invalid day or year: $dateHeader');
    }

    return DateTime(year, month, day);
  }

  /// Calculate category spending for a specific period
  Map<String, double> calculateCategorySpendingByPeriod(String period) {
    Map<String, double> spending = {};
    final transactions = getTransactionsByPeriod(period);

    for (var transaction in transactions) {
      // Parse the value to get the amount (remove "- $" or "+ $" and ".00")
      final valueStr = transaction.value.replaceAll(RegExp(r'[+\-\s\$]'), '');
      final amount = double.tryParse(valueStr) ?? 0.0;

      // Only count expenses (values that start with "-")
      if (transaction.value.startsWith('-')) {
        spending[transaction.category] = (spending[transaction.category] ?? 0.0) + amount;
      }
    }

    return spending;
  }

  /// Calculate transaction counts per category for a specific period
  Map<String, int> calculateCategoryTransactionCountsByPeriod(String period) {
    Map<String, int> counts = {};
    final transactions = getTransactionsByPeriod(period);

    for (var transaction in transactions) {
      // Only count expenses
      if (transaction.value.startsWith('-')) {
        counts[transaction.category] = (counts[transaction.category] ?? 0) + 1;
      }
    }

    return counts;
  }
}

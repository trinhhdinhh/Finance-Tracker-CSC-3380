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

  /// Initialize with default transaction data
  void _initializeDefaultData() {
    Map<String, List<Transaction>> initialData = {
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
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
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
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
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
          value: '- \$6.25',
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
        Transaction(
          initial: 'L',
          title: 'Lululemon',
          category: 'Shopping',
          value: '- \$155.50',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
      ],
      "October 24, 2025": [
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
        Transaction(
          initial: 'W',
          title: 'Work Salary',
          category: 'Income',
          value: '+ \$2,500.00',
          valueColor: const Color(0xFF15803d),
          avatarColor: const Color(0xFF388E3C),
        ),
      ],
      "October 23, 2025": [
        Transaction(
          initial: 'A',
          title: 'Amazon',
          category: 'Shopping',
          value: '- \$45.99',
          valueColor: const Color(0xFF000000),
          avatarColor: const Color(0xFFE61919),
        ),
        Transaction(
          initial: 'N',
          title: 'Netflix',
          category: 'Subscriptions',
          value: '- \$15.49',
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
      "October 22, 2025": [
        Transaction(
          initial: 'T',
          title: 'Target',
          category: 'Shopping',
          value: '- \$6.25',
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
        Transaction(
          initial: 'L',
          title: 'Lululemon',
          category: 'Shopping',
          value: '- \$155.50',
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

  List<Transaction> getRecentTransactionsAtMost(int count) {
     return getRecentTransactions(_allTransactions.length >= count ? count : _allTransactions.length);
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
}

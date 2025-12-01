import 'package:flutter/material.dart';

/// Data class for category information
class CategoryData {
  final String name;
  final IconData icon;
  final Color color;
  final Color lightColor;
  final double budget;
  double spent; // Made mutable to update spending
  int transactions;

  CategoryData({
    required this.name,
    required this.icon,
    required this.color,
    required this.lightColor,
    required this.budget,
    this.spent = 0.0,
    this.transactions = 0,
  });

  /// Create a copy of this category with updated values
  CategoryData copyWith({
    String? name,
    IconData? icon,
    Color? color,
    Color? lightColor,
    double? budget,
    double? spent,
    int? transactions,
  }) {
    return CategoryData(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      lightColor: lightColor ?? this.lightColor,
      budget: budget ?? this.budget,
      spent: spent ?? this.spent,
      transactions: transactions ?? this.transactions,
    );
  }
}

/// Provider for managing categories
class CategoryProvider extends ChangeNotifier {
  // List of all categories
  List<CategoryData> _categories = [];

  // Track if we're in filtered mode (to prevent auto-recalculation from overriding)
  bool _isFiltered = false;

  CategoryProvider() {
    _initializeDefaultCategories();
  }

  /// Initialize with default categories
  void _initializeDefaultCategories() {
    _categories = [
      CategoryData(
        name: 'Food & Drink',
        icon: Icons.restaurant,
        color: const Color(0xFFF97316),
        lightColor: const Color(0xFFFED7AA),
        budget: 1000,
      ),
      CategoryData(
        name: 'Shopping',
        icon: Icons.shopping_bag,
        color: const Color(0xFF3B82F6),
        lightColor: const Color(0xFFBFDBFE),
        budget: 800,
      ),
      CategoryData(
        name: 'Transport',
        icon: Icons.directions_car,
        color: const Color(0xFF8B5CF6),
        lightColor: const Color(0xFFDDD6FE),
        budget: 500,
      ),
      CategoryData(
        name: 'Subscriptions',
        icon: Icons.subscriptions,
        color: const Color(0xFFEAB308),
        lightColor: const Color(0xFFFEF08A),
        budget: 300,
      ),
      CategoryData(
        name: 'Income',
        icon: Icons.account_balance_wallet,
        color: const Color(0xFF10B981),
        lightColor: const Color(0xFFA7F3D0),
        budget: 5000,
      ),
      CategoryData(
        name: 'Health',
        icon: Icons.favorite,
        color: const Color(0xFFEF4444),
        lightColor: const Color(0xFFFECACA),
        budget: 300,
      ),
      CategoryData(
        name: 'Housing',
        icon: Icons.home,
        color: const Color(0xFF6366F1),
        lightColor: const Color(0xFFC7D2FE),
        budget: 1500,
      ),
      CategoryData(
        name: 'Entertainment',
        icon: Icons.movie,
        color: const Color(0xFFEC4899),
        lightColor: const Color(0xFFFBCFE8),
        budget: 200,
      ),
    ];
  }

  /// Get all categories
  List<CategoryData> get categories => _categories;

  /// Get category by name
  CategoryData? getCategoryByName(String name) {
    try {
      return _categories.firstWhere((cat) => cat.name == name);
    } catch (e) {
      return null;
    }
  }

  /// Add a new category
  void addCategory(CategoryData category) {
    _categories.add(category);
    notifyListeners();
  }

  /// Update category spending (called when transactions are added/removed)
  void updateCategorySpending(String categoryName, double amount, bool isIncome) {
    final category = getCategoryByName(categoryName);
    if (category != null) {
      if (isIncome) {
        // For income, we might want to track it differently
        // For now, we'll just count transactions
        category.transactions++;
      } else {
        // For expenses, add to spent amount
        category.spent += amount;
        category.transactions++;
      }
      notifyListeners();
    }
  }

  /// Recalculate all category spending from transactions
  void recalculateSpending(Map<String, double> categoryTotals, Map<String, int> categoryTransactionCounts) {
    // Don't override if we're in filtered mode
    if (_isFiltered) {
      return;
    }

    // Reset all spending
    for (var category in _categories) {
      category.spent = categoryTotals[category.name] ?? 0.0;
      category.transactions = categoryTransactionCounts[category.name] ?? 0;
    }
    notifyListeners();
  }

  /// Remove a category
  void removeCategory(String categoryName) {
    _categories.removeWhere((cat) => cat.name == categoryName);
    notifyListeners();
  }

  /// Update category budget
  void updateCategoryBudget(String categoryName, double newBudget) {
    final category = getCategoryByName(categoryName);
    if (category != null) {
      final index = _categories.indexOf(category);
      _categories[index] = category.copyWith(budget: newBudget);
      notifyListeners();
    }
  }

  /// Get category names for dropdown
  List<String> get categoryNames => _categories.map((cat) => cat.name).toList();

  /// Get expense categories (exclude income)
  List<CategoryData> get expenseCategories =>
      _categories.where((cat) => cat.name != 'Income').toList();

  /// Get total budget
  double get totalBudget {
    return expenseCategories.fold(0.0, (sum, cat) => sum + cat.budget);
  }

  /// Get total spent
  double get totalSpent {
    return expenseCategories.fold(0.0, (sum, cat) => sum + cat.spent);
  }

  /// Recalculate spending for a specific time period
  void recalculateSpendingForPeriod(Map<String, double> categoryTotals, Map<String, int> categoryTransactionCounts) {
    // Set filtered mode to prevent auto-recalculation from overriding
    _isFiltered = true;

    // Reset all spending
    for (var category in _categories) {
      category.spent = categoryTotals[category.name] ?? 0.0;
      category.transactions = categoryTransactionCounts[category.name] ?? 0;
    }
    notifyListeners();
  }

  /// Clear filter and return to showing all transactions
  void clearFilter() {
    _isFiltered = false;
    notifyListeners();
  }
}

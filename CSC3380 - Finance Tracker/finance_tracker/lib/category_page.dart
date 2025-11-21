import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'category_provider.dart';
import 'category_detail_page.dart';

/// Categories and Analytics page displaying spending breakdown with ring chart.
///
/// Features:
/// - Period selector (Week/Month/Year)
/// - Expandable overview card with ring chart
/// - Detailed spending distribution when expanded
/// - List of all categories with progress bars
/// - Budget tracking and status indicators
///
/// TODO: Connect to Firebase/backend for real data
/// TODO: Add navigation to category detail pages
/// TODO: Implement add/edit category functionality
class CategoriesAnalyticsPage extends StatefulWidget {
  const CategoriesAnalyticsPage({Key? key}) : super(key: key);

  @override
  State<CategoriesAnalyticsPage> createState() => _CategoriesAnalyticsPageState();
}

class _CategoriesAnalyticsPageState extends State<CategoriesAnalyticsPage> {
  // Currently selected time period
  String _selectedPeriod = 'month'; // 'week', 'month', or 'year'

  // Controls whether chart details are shown
  bool _showChartDetails = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        final categories = categoryProvider.expenseCategories;
        final totalSpent = categoryProvider.totalSpent;
        final totalBudget = categoryProvider.totalBudget;
        final budgetPercentage = totalBudget == 0 ? 0.0 : (totalSpent / totalBudget) * 100;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            child: Column(
              children: [
                // Header with back button and period selector
                _buildHeader(),

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Expandable overview card with ring chart
                        _buildExpandableOverviewCard(
                          categories,
                          totalSpent,
                          totalBudget,
                          budgetPercentage,
                        ),

                        const SizedBox(height: 24),

                        // Categories list header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'All Categories',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Navigate to manage categories page
                              },
                              child: const Text(
                                'Manage',
                                style: TextStyle(
                                  color: Color(0xFF15803d),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // List of categories
                        ...categories.map((category) => _buildCategoryCard(category)),

                        const SizedBox(height: 16),

                        // Add category button
                        _buildAddCategoryButton(categoryProvider),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds header with back button, title, and period selector
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Back button and title
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF15803d),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Period selector
          Row(
            children: [
              _buildPeriodButton('Week', 'week'),
              const SizedBox(width: 12),
              _buildPeriodButton('Month', 'month'),
              const SizedBox(width: 12),
              _buildPeriodButton('Year', 'year'),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds individual period selector button
  Widget _buildPeriodButton(String label, String value) {
    final isSelected = _selectedPeriod == value;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPeriod = value;
          });
          // TODO: Fetch data for selected period
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF15803d) : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds expandable overview card with ring chart
  Widget _buildExpandableOverviewCard(
    List<CategoryData> categories,
    double totalSpent,
    double totalBudget,
    double budgetPercentage,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _showChartDetails = !_showChartDetails;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF15803d),
              Color(0xFF166534),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Compact view
            Row(
              children: [
                // Mini ring chart
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomPaint(
                    painter: RingChartPainter(
                      categories: categories,
                      totalSpent: totalSpent,
                    ),
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // Spending info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Spending',
                                style: TextStyle(
                                  color: Color(0xFFDCFCE7),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${totalSpent.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${budgetPercentage.toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Color(0xFFDCFCE7),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Progress bar
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Budget Progress',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '\$${totalBudget.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: budgetPercentage / 100,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Expand/collapse icon
                Icon(
                  _showChartDetails 
                    ? Icons.keyboard_arrow_up 
                    : Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            
            // Expanded details
            if (_showChartDetails) ...[
              const SizedBox(height: 24),
              Container(
                height: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              const SizedBox(height: 24),
              
              const Text(
                'Spending Distribution',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Larger ring chart
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: const Size(180, 180),
                          painter: RingChartPainter(
                            categories: categories,
                            totalSpent: totalSpent,
                            outerRadius: 80,
                            innerRadius: 55,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${categories.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 24),
                  
                  // Legend
                  Expanded(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: categories.map((cat) {
                        final percentage = totalSpent > 0 ? (cat.spent / totalSpent) * 100 : 0;
                        return Container(
                          width: (MediaQuery.of(context).size.width - 300) / 2,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: cat.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cat.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${percentage.toStringAsFixed(1)}% · \$${cat.spent.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds individual category card with progress bar
  Widget _buildCategoryCard(CategoryData category) {
    final percentage = (category.spent / category.budget) * 100;
    final remaining = category.budget - category.spent;
    final isOverBudget = remaining < 0;

    Color statusColor;
    if (isOverBudget) {
      statusColor = const Color(0xFFEF4444); // Red
    } else if (percentage >= 75) {
      statusColor = const Color(0xFFEAB308); // Yellow
    } else {
      statusColor = const Color(0xFF10B981); // Green
    }

    return InkWell(
      onTap: () {
        // Navigate to category detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailPage(category: category),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
        children: [
          Row(
            children: [
              // Category icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.lightColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category.icon,
                  color: category.color,
                  size: 24,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Category info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${category.transactions} transactions',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${category.spent.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              isOverBudget
                                ? '\$${remaining.abs().toStringAsFixed(2)} over'
                                : '\$${remaining.toStringAsFixed(2)} left',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${percentage.clamp(0, 100).toStringAsFixed(0)}% of \$${category.budget}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (percentage / 100).clamp(0.0, 1.0),
                  backgroundColor: const Color(0xFFF5F5F5),
                  valueColor: AlwaysStoppedAnimation<Color>(category.color),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  /// Builds add category button
  Widget _buildAddCategoryButton(CategoryProvider categoryProvider) {
    return InkWell(
      onTap: () => _showAddCategoryDialog(categoryProvider),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: const Center(
          child: Text(
            '+ Add New Category',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  /// Shows dialog to add a new category
  void _showAddCategoryDialog(CategoryProvider categoryProvider) {
    final nameController = TextEditingController();
    final budgetController = TextEditingController();
    IconData selectedIcon = Icons.category;
    Color selectedColor = const Color(0xFF15803d);
    Color selectedLightColor = const Color(0xFFDCFCE7);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Add New Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category name field
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        hintText: 'e.g., Entertainment',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.label),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Budget field
                    TextField(
                      controller: budgetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Monthly Budget',
                        hintText: 'e.g., 500',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.attach_money),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Icon selector
                    const Text(
                      'Select Icon',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Icons.restaurant,
                          Icons.shopping_bag,
                          Icons.directions_car,
                          Icons.home,
                          Icons.favorite,
                          Icons.bolt,
                          Icons.smartphone,
                          Icons.movie,
                          Icons.fitness_center,
                          Icons.school,
                          Icons.flight,
                          Icons.pets,
                          Icons.gamepad,
                          Icons.local_cafe,
                          Icons.music_note,
                          Icons.category,
                        ].map((icon) {
                          final isSelected = selectedIcon == icon;
                          return InkWell(
                            onTap: () {
                              setDialogState(() {
                                selectedIcon = icon;
                              });
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? selectedColor.withOpacity(0.2)
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? selectedColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                icon,
                                color: isSelected ? selectedColor : Colors.black54,
                                size: 24,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Color selector
                    const Text(
                      'Select Color',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          {'dark': const Color(0xFFF97316), 'light': const Color(0xFFFED7AA)},
                          {'dark': const Color(0xFF3B82F6), 'light': const Color(0xFFBFDBFE)},
                          {'dark': const Color(0xFF8B5CF6), 'light': const Color(0xFFDDD6FE)},
                          {'dark': const Color(0xFFEAB308), 'light': const Color(0xFFFEF08A)},
                          {'dark': const Color(0xFF10B981), 'light': const Color(0xFFA7F3D0)},
                          {'dark': const Color(0xFFEF4444), 'light': const Color(0xFFFECACA)},
                          {'dark': const Color(0xFF6366F1), 'light': const Color(0xFFC7D2FE)},
                          {'dark': const Color(0xFFEC4899), 'light': const Color(0xFFFBCFE8)},
                          {'dark': const Color(0xFF15803d), 'light': const Color(0xFFDCFCE7)},
                          {'dark': const Color(0xFF0891B2), 'light': const Color(0xFFA5F3FC)},
                          {'dark': const Color(0xFFD97706), 'light': const Color(0xFFFDE68A)},
                          {'dark': const Color(0xFF7C3AED), 'light': const Color(0xFFE9D5FF)},
                        ].map((colorPair) {
                          final darkColor = colorPair['dark'] as Color;
                          final lightColor = colorPair['light'] as Color;
                          final isSelected = selectedColor == darkColor;
                          return InkWell(
                            onTap: () {
                              setDialogState(() {
                                selectedColor = darkColor;
                                selectedLightColor = lightColor;
                              });
                            },
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: darkColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate inputs
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a category name'),
                          backgroundColor: Color(0xFFEF4444),
                        ),
                      );
                      return;
                    }

                    final budget = double.tryParse(budgetController.text);
                    if (budget == null || budget <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid budget amount'),
                          backgroundColor: Color(0xFFEF4444),
                        ),
                      );
                      return;
                    }

                    // Add new category to the provider
                    categoryProvider.addCategory(
                      CategoryData(
                        name: nameController.text.trim(),
                        icon: selectedIcon,
                        color: selectedColor,
                        lightColor: selectedLightColor,
                        spent: 0.0,
                        budget: budget,
                        transactions: 0,
                      ),
                    );

                    Navigator.pop(context);

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${nameController.text} category added!'),
                        backgroundColor: const Color(0xFF10B981),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF15803d),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Add Category',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// Custom painter for drawing the ring chart
class RingChartPainter extends CustomPainter {
  final List<CategoryData> categories;
  final double totalSpent;
  final double outerRadius;
  final double innerRadius;

  RingChartPainter({
    required this.categories,
    required this.totalSpent,
    this.outerRadius = 45,
    this.innerRadius = 30,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double startAngle = -math.pi / 2; // Start from top

    for (var category in categories) {
      final percentage = totalSpent > 0 ? category.spent / totalSpent : 0;
      final sweepAngle = 2 * math.pi * percentage;

      final paint = Paint()
        ..color = category.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = outerRadius - innerRadius
        ..strokeCap = StrokeCap.butt;

      final rect = Rect.fromCircle(
        center: center,
        radius: (outerRadius + innerRadius) / 2,
      );

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
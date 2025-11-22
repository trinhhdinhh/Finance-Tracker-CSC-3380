import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finance_tracker/features/transactions/pages/transaction_page.dart'; // Using Transaction class and Colors from this file
import 'package:finance_tracker/features/categories/providers/category_provider.dart';

class AddTransactionPage extends StatefulWidget {
  final Function(String dateHeader, Transaction newTransaction) onSave;
  const AddTransactionPage({super.key, required this.onSave});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  // Define controllers and selected category state
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedCategory; // Use String? for the dropdown value

  // Reset controllers when the widget is disposed
  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  // Used to save confirmed transaction into "allGroupedTransactions" map on transaction_page.dart
  void saveTransaction() {
    final title = titleController.text.trim();
    final amountText = amountController.text.trim();
    final date = dateController.text.trim();
    
    // Validates every category is filled out before being able to press confirm
    if (title.isEmpty || amountText.isEmpty || date.isEmpty || selectedCategory == null) {
      return; 
    }

    // Determine if income or not
    final isIncome = selectedCategory == 'Income';
    final value = isIncome ? "+ \$$amountText.00" : "- \$$amountText.00";
    final valueColor = isIncome ? primaryGreen : Colors.black87;
    final avatarColor = isIncome ? headerGreen : expense;

    // Create the new transaction object
    final newTx = Transaction(
      initial: title.isNotEmpty ? title[0].toUpperCase() : '?',
      title: title,
      category: selectedCategory!,
      value: value,
      valueColor: valueColor,
      avatarColor: avatarColor,
    );
    
    // Call the external onSave callback function
    widget.onSave(date, newTx); 

    // Close the current page
    Navigator.of(context).pop();
  }
  // ------------------------------

  /*
  * Style / Design of transaction page
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], 
      
      // Toolbar (AppBar from your base code)
      appBar: AppBar(
        backgroundColor: Colors.grey[50], 
        elevation: 0,
        leading: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: primaryGreen), 
          label: const Text("Back", style: TextStyle(color: primaryGreen, fontSize: 16)),
        ),
        leadingWidth: 100,
        // Title centered in the AppBar
        title: const Text(
          'New Transaction', 
          style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(24.0), 
        children: [
          // Input fields
          textField(titleController, 'Enter Title', TextInputType.text),
          const SizedBox(height: 16), // Spacing
          textField(amountController, 'Enter Amount', TextInputType.number),
          const SizedBox(height: 16), // Spacing
          categoryDropdown(),
          const SizedBox(height: 16), // Spacing         
          TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: outline),
              ),
              // Border when on page
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: outline),
              ),
              // Shifts to green border when searchBar is clicked
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: headerGreen, width: 2),
              ),
              labelText: 'Select Date',
              floatingLabelStyle: TextStyle(color: primaryGreen),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                // Sets color scheme of showDatePicker
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: primaryGreen
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (pickedDate != null) {
                final formattedDate = DateFormat('MMMM d, y').format(pickedDate);
                dateController.text = formattedDate;
              }
            },
          ),
          const SizedBox(height: 40), // Spacing
          // Buttons
          buttons(context),
        ],
      ),
    ); 
  }

  /*
  * The code below are the widgets used in build widget
  */

  Widget textField(TextEditingController controller, String hint, TextInputType keyboardType) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGreen, width: 2),
        ),
      ),
    );
  }

  Widget categoryDropdown() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        final categories = categoryProvider.categoryNames;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: const Text('Select Category'),
              value: selectedCategory,
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              icon: const Icon(Icons.keyboard_arrow_down, color: primaryGreen),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget buttons(BuildContext context) {
    return Row(
      children: [
        // Cancel Button
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.grey,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
          ),
        ),
        const SizedBox(width: 16), // Spacing
        // Confirm Button
        Expanded(
          child: ElevatedButton(
            onPressed: saveTransaction,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              foregroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
          ),
        ),
      ],
    );
  }

}
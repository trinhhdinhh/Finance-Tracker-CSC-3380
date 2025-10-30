import 'package:flutter/material.dart';
import 'add_transaction_page.dart';

const Color primaryGreen = Color.fromARGB(255, 23, 128, 61); //Color is #17803d from Figma
const Color headerGreen = Color.fromARGB(255, 56, 142, 60); //Color is #12AF4B from Figma
const Color headerIconGreen = Color.fromARGB(255, 18, 175, 75); //Color is from Figma
const Color outline = Color.fromARGB(255, 224, 224, 224);
const Color hintText = Color.fromARGB(255, 158, 158, 158);
const Color expense = Color.fromARGB(255, 230, 25, 25);

// Transaction data type model
class Transaction {
  final String initial;
  final String title;
  final String category;
  final String value;
  final Color valueColor;
  final Color avatarColor;

  const Transaction({
    required this.initial,
    required this.title,
    required this.category,
    required this.value,
    required this.valueColor,
    required this.avatarColor,
  });
}

class TransactionPage extends StatefulWidget { // StatefulWidget state allows transactions to be updated
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {
  /*
  * Filtering ability setup
  */

  // Initializations
  late Map<String, List<Transaction>> allGroupedTransactions;
  late List<Transaction> allTransactionsFlat;
  List<Transaction> filteredTransactions = [];
  String searchText = '';

  @override
  void initState() {
    // Initial immutable data structure
    Map<String, List<Transaction>> initialData = {
      "October 27, 2025": [
        Transaction(initial: 'L', title: 'Lululemon', category: 'Shopping', value: '- \$128.50', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'S', title: 'Starbucks', category: 'Food & Drink', value: '- \$6.25', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'W', title: 'Work Salary', category: 'Income', value: '+ \$2,500.00', valueColor: primaryGreen, avatarColor: headerGreen),
      ],
      "October 26, 2025": [
        Transaction(initial: 'A', title: 'Amazon', category: 'Shopping', value: '- \$45.99', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'N', title: 'Netflix', category: 'Subscriptions', value: '- \$15.49', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'U', title: 'Uber', category: 'Transport', value: '- \$15.00', valueColor: Colors.black87, avatarColor: expense),
      ],
      "October 25, 2025": [
        Transaction(initial: 'T', title: 'Target', category: 'Shopping', value: '- \$6.25', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'P', title: 'Pharmacy', category: 'Health', value: '- \$35.00', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'L', title: 'Lululemon', category: 'Shopping', value: '- \$155.50', valueColor: Colors.black87, avatarColor: expense),
      ],
      "October 24, 2025": [
        Transaction(initial: 'L', title: 'Lululemon', category: 'Shopping', value: '- \$128.50', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'S', title: 'Starbucks', category: 'Food & Drink', value: '- \$6.25', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'W', title: 'Work Salary', category: 'Income', value: '+ \$2,500.00', valueColor: primaryGreen, avatarColor: headerGreen),
      ],
      "October 23, 2025": [
        Transaction(initial: 'A', title: 'Amazon', category: 'Shopping', value: '- \$45.99', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'N', title: 'Netflix', category: 'Subscriptions', value: '- \$15.49', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'U', title: 'Uber', category: 'Transport', value: '- \$15.00', valueColor: Colors.black87, avatarColor: expense),
      ],
      "October 22, 2025": [
        Transaction(initial: 'T', title: 'Target', category: 'Shopping', value: '- \$6.25', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'P', title: 'Pharmacy', category: 'Health', value: '- \$35.00', valueColor: Colors.black87, avatarColor: expense),
        Transaction(initial: 'L', title: 'Lululemon', category: 'Shopping', value: '- \$155.50', valueColor: Colors.black87, avatarColor: expense),
      ],
    };

    // Convert all internal lists to GROWABLE lists using .toList()
    allGroupedTransactions = initialData.map((key, value) => MapEntry(key, value.toList()));

    // Flatten and initialize filtered list
    allTransactionsFlat = allGroupedTransactions.values.expand((list) => list).toList();
    filteredTransactions = allTransactionsFlat;
    super.initState();
  }

  // --- Searching Logic ---
  void runFilter(String enteredKeyword) {
    searchText = enteredKeyword;
    List<Transaction> results = [];
    String keywordLower = enteredKeyword.toLowerCase();

    if (enteredKeyword.isEmpty) {
      results = allTransactionsFlat;
    } else {
      // 1. Filter by TRANSACTION TITLE
      results = allTransactionsFlat
          .where((transaction) =>
              transaction.title.toLowerCase().contains(keywordLower))
          .toList();
      // 2. Filter by DATE HEADER
      allGroupedTransactions.forEach((dateHeader, transactions) { // Iterate through the grouped map to find date matches
        if (dateHeader.toLowerCase().contains(keywordLower)) {
          // If the date header matches the keyword, add ALL transactions from that date to the results
          for (var tx in transactions) {
            if (!results.contains(tx)) {
              results.add(tx);
            }
          }
        }
      });
    }
    // 3. Sort the final results and update UI
    setState(() {
      filteredTransactions = results;
    });
  }
  
  // Use to build a section and filter its tiles
  List<Widget> buildFilteredSection(String dateHeader, List<Transaction> sourceList) {
    // 1. Filter the source list to find which transactions match the search results
    final sectionTiles = sourceList
        .where((tx) => filteredTransactions.contains(tx))
        .toList();
    // 2. If no matching transactions for this date, return an empty list of widgets.
    if (sectionTiles.isEmpty) {
      return [];
    }
    // 3. Otherwise, return the Date Header and the list of filtered tiles
    return [
      const SizedBox(height: 24),
      sectionHeader(dateHeader), 
      const SizedBox(height: 12),
      // Map the filtered tiles to the transactionTile widget
      ...sectionTiles.map((tx) {
        return transactionTile(
          initial: tx.initial,
          title: tx.title,
          category: tx.category,
          value: tx.value,
          valueColor: tx.valueColor,
          avatarColor: tx.avatarColor,
        );
      }),
    ];
  }
  /*
  Filtering setup complete
  */

  // Method to add a transaction and update the state
  void addTransaction(String dateHeader, Transaction newTransaction) {
    String key = dateHeader.trim(); 

    if (allGroupedTransactions.containsKey(key)) {
      // 1. DATE EXISTS: Add the transaction to the front of existing list.
      allGroupedTransactions[key]!.insert(0, newTransaction);
    } else {
      // 2. NEW DATE: Create a new map with the new entry FIRST, followed by all the old entries.
      allGroupedTransactions[key] = [newTransaction];
      allGroupedTransactions = Map.fromEntries(
        allGroupedTransactions.entries.toList()
          ..sort((a,b) => b.key.compareTo(a.key)),
      );
    }
    // Re-flatten the list for search filtering
    allTransactionsFlat = allGroupedTransactions.values.expand((list) => list).toList();
    // UI refresh and clear filter
    setState(() {
      runFilter(''); 
    });
  }
  
  /*
  * Style / Design of transaction page
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // White background color

      // Toolbar (The back button, and handles the "scrolling down look"properly)
      appBar: AppBar(
        backgroundColor: Colors.grey[50], 
        elevation: 0,
        // "< Back" button
        leading: TextButton.icon(
          onPressed: () {
            // Goes to the previous page
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, size: 18, color: primaryGreen), 
          label: Text("Back", style: TextStyle(color: primaryGreen, fontSize: 16), ),
        ),
        leadingWidth: 100, // Make space for the icon and text
      ),

      body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                
                buttons(), // Top row of buttons
                const SizedBox(height: 24), // Spacing

                searchBar(), // Search Bar
                const SizedBox(height: 24), // Spacing

                // Iterates over the keys (dates) of the map
                ...allGroupedTransactions.keys.map((dateHeader) {
                  // Get the list of transactions for this date
                  List<Transaction> transactions = allGroupedTransactions[dateHeader]!;
                  // Use buildFilteredSection to conditionally display the header and tiles
                  return Column(
                    children: buildFilteredSection(dateHeader, transactions),
                  );
                }),
                // No transactions found message
                if (filteredTransactions.isEmpty && searchText.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: Text(
                        'No transactions found matching your search.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  /*
  * The code below are the widgets used in build widget
  */

  // Builds the top row of buttons ("Add Transaction" and "View Statements")
  Widget buttons() {
    // Style for the buttons
    ButtonStyle buttonStyle() {
      return ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryGreen, // Text color
        textStyle: const TextStyle(fontWeight: FontWeight.w700), //Bold
        elevation: 2,
        shadowColor: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[300]!),
        ),
      );
    }
    // Code for both buttons
    return Row(
      children: [
        // Add Transaction button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddTransactionPage(
                    // Add saved transaction from add_transaction_page.dart to the map on this .dart page
                    onSave: addTransaction,
                  ),
                ),
              );
            },
            style: buttonStyle(),
            child: const Text("Add Transaction"),
          ),
        ),
        // Spacing in between the two buttons
        const SizedBox(width: 16),
        // View Statements button
        Expanded(
          child: ElevatedButton(
            onPressed: () {}, // Need to fill in the code for it to go to appropriate page
            style: buttonStyle(),
            child: const Text("View Statements"),
          ),
        ),
      ],
    );
  }
                   
  // Builds the search bar
  Widget searchBar() {
    return TextField(
      onChanged: runFilter, // enables the filtering process to work
      decoration: InputDecoration(
        // Hint text inside searchBar
        hintText: "Search for transaction",
        hintStyle: TextStyle(color: hintText),
        prefixIcon: Icon(Icons.search, color: primaryGreen),
        // Fills inside of TextField white
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        // Default border - when not on page
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
      ),
    );
  }

  /// Builds the green section headers ("Date of Transactions")
  Widget sectionHeader(String title) {
    return Row(
      children: [
        // Icon to the left
        Container(
          width: 5,
          height: 20,
          decoration: BoxDecoration(
            color: headerIconGreen,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Spacing
        const SizedBox(width: 10),
        // Text
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: headerGreen,
          ),
        ),
      ],
    );
  }

  /// Builds a single transaction list item
  Widget transactionTile({
    required String initial,
    required String title,
    required String category,
    required String value,
    required Color valueColor,
    required Color avatarColor,
  }) {
    return Card(
      // Outline
      elevation: 1.5,
      shadowColor: Colors.grey[100],
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // Components
      child: ListTile(
        leading: CircleAvatar( // Icon
          backgroundColor: avatarColor,
          child: Text(
            initial,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text( // Title
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text( // Category
          category,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Text( //Amount of money
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

}

/*Place this code onto button that is supposed to go to the transaction page*/

//import 'transaction_page.dart'; (Has to be imported on the correct page, to make use of onPressed: () {})

// child: ElevatedButton(
//   onPressed: () {
//     // Navigate to create account
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => TransactionPage()),
//     );
//   },


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:finance_tracker/core/config/firebase_options.dart';
import 'package:finance_tracker/features/welcome/pages/welcome_page.dart';
import 'package:finance_tracker/features/transactions/providers/transaction_provider.dart';
import 'package:finance_tracker/features/categories/providers/category_provider.dart';
import 'package:finance_tracker/user_provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Disable persistence on web platforms. Must be called on initialization:
  final auth = FirebaseAuth.instanceFor(app: Firebase.app());
  // To change it after initialization, use `setPersistence()`:
  await auth.setPersistence(Persistence.LOCAL);

  runApp(const FinanceTrackerApp());
}

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProxyProvider<CategoryProvider, TransactionProvider>(
          create: (context) => TransactionProvider(),
          update: (context, categoryProvider, transactionProvider) {
            if (transactionProvider != null) {
              // Set up the callback to update category spending when transactions change
              transactionProvider.setupCategoryCallback(
                (spending, counts) => categoryProvider.recalculateSpending(spending, counts),
              );
            }
            return transactionProvider ?? TransactionProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Finance Tracker',
        theme: ThemeData(
          primaryColor: const Color(0xFF15803d),
          scaffoldBackgroundColor: const Color(0xFFE8F5E9),
          fontFamily: 'SF Pro',
        ),
        home: const WelcomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  void toLoginPage() async {
    notifyListeners();
  }
}

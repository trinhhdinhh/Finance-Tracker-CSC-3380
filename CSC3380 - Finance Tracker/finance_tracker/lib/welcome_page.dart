import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const FinanceTrackerApp());
}

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
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

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  bool showLoginBox = false;

  // Saved credentials.
  // TODO: how should we obscure the password when we send it over the network?
  String savedEmail = "";
  String savedPassword = "";

  @override
  Widget build(BuildContext context) {
    if (showLoginBox) {
      return _buildLoginBox(context);
    } else {
      return _buildWelcomeContent(context);
    }
  }

  Widget _buildWelcomeContent(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light mint green background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Finance Tracker Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.account_balance_wallet,
                        color: Color(0xFF15803d),
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Finance Tracker',
                        style: TextStyle(
                          color: Color(0xFF15803d),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                const Text(
                  'Your Money,',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
                const Text(
                  'Simplified',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF15803d),
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Take control of your financial future with smart tracking and personalized insights',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Balance Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
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
                              '\$99,999.99',
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
                                    '\$1,234',
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
                                    '\$1,234',
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
                ),

                const SizedBox(height: 40),

                // Get Started Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to create account
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15803d),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // I Already Have an Account Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      // When the button is pressed, we need to advertise that the state changed.
                      setState(() {
                        showLoginBox = true;
                      });

                      // Navigate to login
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF15803d),
                      side: const BorderSide(
                        color: Color(0xFF15803d),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'I Already Have an Account',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBox(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Needed in order for the other boxes to not be left-aligned.
                Container(width: double.infinity),
                // Gap.
                const SizedBox(height: 10),
                // Draw the squircle for the wallet icon.
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF15803d),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white.withOpacity(0.8),
                    size: 32,
                  ),
                ),
                // Another gap.
                const SizedBox(height: 10),
                // Make the size relative to the screen.
                // In this case, 50%.
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: SafeArea(
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF15803d),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: "email@example.com",
                      ),
                      onChanged: (value) {
                        print("saved email $value");
                        savedEmail = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: SafeArea(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18,
                        // w600 is way too heavy for this, but left here to show that you can do it.
                        //fontWeight: FontWeight.w600,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF15803d),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                      onChanged: (value) {
                        print("saved password: $value");
                        savedPassword = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // TODO: we should move these into their own
                // encapsulated unit and set size based on max(screenWidth * 0.4, X amount of pixels).
                FractionallySizedBox(
                  widthFactor: 0.4,
                  child: ElevatedButton(
                    onPressed: () {
                      _validateCredentials();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF15803d),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // In Dart, you don't annotate functions with the fact that they throw, unfortunately.
  // https://dart.dev/language/error-handling
  void _validateCredentials() {
    // TODO: validate credentials based on what is stored in the FireStore DB.
    throw UnimplementedError("Credential validation unimplemented!");
  }
}

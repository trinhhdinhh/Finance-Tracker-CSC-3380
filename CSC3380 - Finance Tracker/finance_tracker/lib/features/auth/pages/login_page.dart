import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_tracker/features/auth/pages/create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for managing text input state
  // Also reused for saved credentials.

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controls whether password is visible or obscured
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // Clean up controllers when widget is disposed to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light mint green background matching the design
      backgroundColor: const Color(0xFFE8F5E9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top spacing
                  const SizedBox(height: 16),

                  // Back button aligned to the left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildBackButton(context),
                  ),

                  const SizedBox(height: 40),

                  // Logo/Icon
                  _buildLogo(),

                  const SizedBox(height: 24),

                  // Title and subtitle
                  _buildTitleSection(),

                  const SizedBox(height: 40),

                  // Email input field
                  _buildEmailField(),

                  const SizedBox(height: 16),

                  // Password input field with visibility toggle
                  _buildPasswordField(),

                  const SizedBox(height: 32),

                  // Login button
                  _buildLoginButton(),

                  const SizedBox(height: 24),

                  // "Or continue with" divider
                  _buildDivider(),

                  const SizedBox(height: 24),

                  // Social login buttons (Google and Apple)
                  _buildSocialLoginButtons(),

                  const SizedBox(height: 24),

                  // Sign up link
                  _buildSignUpLink(),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the back button that navigates to the previous screen
  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate back to previous screen (likely the welcome page)
        Navigator.pop(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.arrow_back, color: Color(0xFF15803d), size: 20),
          SizedBox(width: 4),
          Text(
            'Back',
            style: TextStyle(
              color: Color(0xFF15803d),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the app logo (wallet icon in a rounded square)
  Widget _buildLogo() {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: const Color(0xFF15803d),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        color: Colors.white,
        size: 48,
      ),
    );
  }

  /// Builds the title section with app name and subtitle
  Widget _buildTitleSection() {
    return Column(
      children: const [
        Text(
          'Finance Tracker',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF15803d),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Manage your money with ease',
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ],
    );
  }

  /// Builds the email input field with validation
  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          // Email icon on the left
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Color(0xFF15803d),
            size: 20,
          ),
          hintText: 'Email',
          hintStyle: TextStyle(color: Colors.black38),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        // Validation logic for email field
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          // Basic email format validation
          if (!value.contains('@') || !value.contains('.')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  /// Builds the password input field with visibility toggle and validation
  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: TextFormField(
        controller: _passwordController,
        // Toggle password visibility based on state
        obscureText: !_isPasswordVisible,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          // Lock icon on the left
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Color(0xFF15803d),
            size: 20,
          ),
          // Eye icon on the right to toggle visibility
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF15803d),
              size: 20,
            ),
            onPressed: () {
              // Toggle password visibility state
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          hintText: 'Password',
          hintStyle: const TextStyle(color: Colors.black38),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        // Validation logic for password field
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }

  /// Builds the primary login button
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF15803d),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Builds the "Or continue with" divider between login methods
  Widget _buildDivider() {
    return Row(
      children: [
        // Left line
        Expanded(child: Container(height: 1, color: const Color(0xFFE0E0E0))),
        // Text in the middle
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: TextStyle(color: Colors.black38, fontSize: 13),
          ),
        ),
        // Right line
        Expanded(child: Container(height: 1, color: const Color(0xFFE0E0E0))),
      ],
    );
  }

  /// Builds social login buttons for Google and Apple
  Widget _buildSocialLoginButtons() {
    return Row(
      children: [
        // Google login button
        Expanded(
          child: _buildSocialButton(
            label: 'Google',
            onTap: _handleGoogleLogin,
            // Google logo SVG
            icon: SvgPicture.asset(
              'assets/images/google_logo.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Apple login button
        Expanded(
          child: _buildSocialButton(
            label: 'Apple',
            onTap: _handleAppleLogin,
            // Apple icon
            icon: const Icon(Icons.apple, size: 24, color: Colors.black),
          ),
        ),
      ],
    );
  }

  /// Helper method to build individual social login buttons
  Widget _buildSocialButton({
    required String label,
    required VoidCallback onTap,
    required Widget icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the sign up link for new users
  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        InkWell(
          onTap: _navigateToSignUp,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Color(0xFF15803d),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// Handles the login button press
  /// Validates form and authenticates user
  void _handleLogin() {
    // Validate all form fields
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with authentication
      _validateCredentials();
    }
  }

  /// Validates user credentials against backend/FirebaseAuth
  void _validateCredentials() async {

    print('Attempting login with email: ${_emailController.text}');

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Welcome the user if everything succeeded.
      _welcomeSignedInUser(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print("Cannot log in: ${e.code}");
      }
    }
  }

  /// Handles Google sign-in authentication
  void _handleGoogleLogin() async {
    UserCredential user = await _signInWithProvider(GoogleAuthProvider());

    _welcomeSignedInUser(user);
  }
    /// Handles Apple sign-in authentication
  void _handleAppleLogin() async {
    // Uncomment when we get the apple thing situated.
    //UserCredential user = await _signInWithProvider(AppleAuthProvider());

    //_welcomeSignedInUser(user);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sorry, Apple account integration is not implemented yet!'),
          backgroundColor: Colors.red,
        ),
      );
      // Go to the /home page
      // TODO: how shall we implement pages?
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _welcomeSignedInUser(UserCredential user) {
    print("User is signed in: ${user.user?.displayName}");

    // Reason for "context.mounted":
    // https://dart.dev/tools/diagnostics/use_build_context_synchronously
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome, ${user.user?.displayName}!'),
          backgroundColor: const Color(0xFF15803d),
        ),
      );
      // Go to the /home page
      // TODO: how shall we implement pages?
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  /// This will open a pop-up in a new window.
  /// This always succeeds, but note that user.user can be null,
  /// as it is of type "String?".
  Future<UserCredential> _signInWithProvider(AuthProvider provider) async {
    UserCredential user = await FirebaseAuth.instance.signInWithPopup(provider);

    return user;
  }

  /// Navigates to the sign up page for new users
  void _navigateToSignUp() {
    // Navigate to create account page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateAccountPage()),
    );
  }
}

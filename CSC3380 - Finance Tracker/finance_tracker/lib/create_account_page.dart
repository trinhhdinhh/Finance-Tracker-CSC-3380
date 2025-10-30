import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Create Account page widget that allows new users to register for the app.
///
/// This page includes:
/// - Back navigation button
/// - Full name, email, password, and confirm password input fields with validation
/// - Password visibility toggles for both password fields
/// - Primary create account button
/// - Link to login page for existing users

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateAccountPageState();
  }
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  // Controllers for managing text input state
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controls whether passwords are visible or obscured
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Terms and conditions acceptance state
  // Note: You may want to add a checkbox for this
  bool _hasAcceptedTerms = true; // Set to true for now, add checkbox later

  @override
  void dispose() {
    // Clean up controllers when widget is disposed to prevent memory leaks
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

                  // Full Name input field
                  _buildFullNameField(),

                  const SizedBox(height: 16),

                  // Email input field
                  _buildEmailField(),

                  const SizedBox(height: 16),

                  // Password input field with visibility toggle
                  _buildPasswordField(),

                  const SizedBox(height: 16),

                  // Confirm Password input field with visibility toggle
                  _buildConfirmPasswordField(),

                  const SizedBox(height: 32),

                  // Create Account button
                  _buildCreateAccountButton(),

                  const SizedBox(height: 24),

                  // "Or continue with" divider
                  _buildDivider(),

                  const SizedBox(height: 24),

                  // Social login buttons (Google and Apple)
                  _buildSocialLoginButtons(),

                  const SizedBox(height: 24),

                  // Login link for existing users
                  _buildLoginLink(),

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

  /// Builds the title section with page title and subtitle
  Widget _buildTitleSection() {
    return Column(
      children: const [
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF15803d),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Start your financial journey today',
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ],
    );
  }

  /// Builds the full name input field with validation
  Widget _buildFullNameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: TextFormField(
        controller: _fullNameController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.words,
        style: const TextStyle(fontSize: 16),
        decoration: const InputDecoration(
          // User icon on the left
          prefixIcon: Icon(
            Icons.person_outline,
            color: Color(0xFF15803d),
            size: 20,
          ),
          hintText: 'Full Name',
          hintStyle: TextStyle(color: Colors.black38),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        // Validation logic for full name field
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your full name';
          }
          if (value.trim().length < 2) {
            return 'Name must be at least 2 characters';
          }
          return null;
        },
      ),
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
          // Basic email format validation using regex
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
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
            return 'Please enter a password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          // TODO: We should consider adding this better password security
          // if (!value.contains(RegExp(r'[A-Z]'))) {
          //   return 'Password must contain at least one uppercase letter';
          // }
          // if (!value.contains(RegExp(r'[0-9]'))) {
          //   return 'Password must contain at least one number';
          // }
          return null;
        },
      ),
    );
  }

  /// Builds the confirm password input field with visibility toggle and matching validation
  Widget _buildConfirmPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        // Toggle password visibility based on state
        obscureText: !_isConfirmPasswordVisible,
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
              _isConfirmPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: const Color(0xFF15803d),
              size: 20,
            ),
            onPressed: () {
              // Toggle confirm password visibility state
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            },
          ),
          hintText: 'Confirm Password',
          hintStyle: const TextStyle(color: Colors.black38),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        // Validation logic to ensure passwords match
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          }
          if (value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  /// Builds the primary create account button
  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _handleCreateAccount,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF15803d),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Create Account',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /// Builds the "Or continue with" divider between registration methods
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

  /// Builds social registration buttons for Google and Apple
  Widget _buildSocialLoginButtons() {
    return Row(
      children: [
        // Google registration button
        Expanded(
          child: _buildSocialButton(
            label: 'Google',
            onTap: _handleGoogleSignUp,
            // Google logo SVG
            icon: SvgPicture.asset(
              'assets/images/google_logo.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Apple registration button
        Expanded(
          child: _buildSocialButton(
            label: 'Apple',
            onTap: _handleAppleSignUp,
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

  /// Builds the login link for existing users
  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        InkWell(
          onTap: _navigateToLogin,
          child: const Text(
            'Login',
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

  /// Handles the create account button press
  /// Validates form and creates new user account
  void _handleCreateAccount() {
    // Validate all form fields
    if (_formKey.currentState?.validate() ?? false) {
      // Check if terms are accepted (if you add a checkbox)
      if (!_hasAcceptedTerms) {
        _showErrorMessage('Please accept the terms and conditions');
        return;
      }

      // Form is valid, proceed with account creation
      _createAccount();
    }
  }

  /// Creates a new user account with email and password
  void _createAccount() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

      credential.user?.updateDisplayName(_fullNameController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('This email is being used for another account!');
      } else {
        print("Cannot log in: ${e.code}");
      }
    }
    // Logging that should be removed later.
    print('Creating account for: ${_emailController.text}');
    print('Full name: ${_fullNameController.text}');

    // TODO: we should redirect to the login screen.
    _showSuccessMessage('Account created! Please go to the sign-in screen.');
  }

  /// Handles Google sign-up authentication
  void _handleGoogleSignUp() async {
    _showErrorMessage("These buttons do nothing and should be removed!");
  }

  /// Handles Apple sign-up authentication
  void _handleAppleSignUp() async {
    _showErrorMessage("These buttons do nothing and should be removed!");
  }

  /// Navigates to the login page
  void _navigateToLogin() {
    // Navigate back or to login page
    Navigator.pop(context);
    // Or if you need to navigate to a specific login route:
    // Navigator.pushReplacementNamed(context, '/login');
  }

  /// Shows an error message to the user
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Shows a success message to the user
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF15803d),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

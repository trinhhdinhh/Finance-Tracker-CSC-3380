import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for managing text input state
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controls whether password is visible or obscured
  bool _isPasswordVisible = false;

  // Saved credentials for authentication
  // TODO: Integrate with Firebase Authentication
  // TODO: Never store passwords in plain text - use secure storage/Firebase Auth
  String savedEmail = "";
  String savedPassword = "";

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
          Icon(
            Icons.arrow_back,
            color: Color(0xFF15803d),
            size: 20,
          ),
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
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
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
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
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
        onChanged: (value) {
          savedEmail = value;
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
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1,
        ),
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
        onChanged: (value) {
          savedPassword = value;
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
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Builds the "Or continue with" divider between login methods
  Widget _buildDivider() {
    return Row(
      children: [
        // Left line
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E0E0),
          ),
        ),
        // Text in the middle
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: Colors.black38,
              fontSize: 13,
            ),
          ),
        ),
        // Right line
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE0E0E0),
          ),
        ),
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
            icon: const Icon(
              Icons.apple,
              size: 24,
              color: Colors.black,
            ),
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
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
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
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
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

  /// Validates user credentials against backend/Firebase
  /// TODO: Implement actual authentication logic
  void _validateCredentials() {
    // TODO: Integrate with Firebase Authentication
    // Example implementation:
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: savedEmail,
    //     password: savedPassword,
    //   );
    //   // Navigate to home page on success
    //   Navigator.pushReplacementNamed(context, '/home');
    // } catch (e) {
    //   // Show error message
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Login failed: ${e.toString()}')),
    //   );
    // }

    print('Attempting login with email: $savedEmail');
    // For now, just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login functionality not yet implemented'),
        backgroundColor: Color(0xFF15803d),
      ),
    );
  }

  /// Handles Google sign-in authentication
  /// TODO: Implement Google Sign-In with Firebase
  void _handleGoogleLogin() {
    // TODO: Implement Google Sign-In
    // Example implementation:
    // try {
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth?.accessToken,
    //     idToken: googleAuth?.idToken,
    //   );
    //   await FirebaseAuth.instance.signInWithCredential(credential);
    //   Navigator.pushReplacementNamed(context, '/home');
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Google sign-in failed: ${e.toString()}')),
    //   );
    // }

    print('Google login tapped');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google Sign-In not yet implemented'),
        backgroundColor: Color(0xFF15803d),
      ),
    );
  }

  /// Handles Apple sign-in authentication
  /// TODO: Implement Apple Sign-In with Firebase
  void _handleAppleLogin() {
    // TODO: Implement Apple Sign-In
    // Note: Apple Sign-In requires proper configuration in Xcode and Firebase
    // Example implementation:
    // try {
    //   final appleProvider = AppleAuthProvider();
    //   await FirebaseAuth.instance.signInWithProvider(appleProvider);
    //   Navigator.pushReplacementNamed(context, '/home');
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Apple sign-in failed: ${e.toString()}')),
    //   );
    // }

    print('Apple login tapped');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Apple Sign-In not yet implemented'),
        backgroundColor: Color(0xFF15803d),
      ),
    );
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
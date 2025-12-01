import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/features/welcome/pages/welcome_page.dart';

/// Settings Page - Displays user profile and account settings
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section with Profile
              _buildProfileHeader(user),

              const SizedBox(height: 24),

              // Account Options
              _buildAccountOptions(context, user),
            ],
          ),
        ),
      ),
    );
  }

  /// Build profile header section
  Widget _buildProfileHeader(User? user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E7D32),
            Color(0xFF1B5E20),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
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
          // Profile Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          // User Name
          Text(
            user?.displayName ?? 'User',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          // User Email
          Text(
            user?.email ?? 'No email',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 16),

          // Account Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  user != null ? Icons.check_circle : Icons.error,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  user != null ? 'Account Active' : 'Not Logged In',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build account options list
  Widget _buildAccountOptions(BuildContext context, User? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Profile Section
          _buildSectionTitle('Profile'),
          _buildOptionCard(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your name and information',
            onTap: () {
              // TODO: Navigate to edit profile page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit profile coming soon!'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
          ),
          _buildOptionCard(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: user?.email ?? 'Not set',
            onTap: () {
              // TODO: Navigate to change email
            },
          ),

          const SizedBox(height: 24),

          // Security Section
          _buildSectionTitle('Security'),
          _buildOptionCard(
            icon: Icons.lock_outline,
            title: 'Change Password',
            subtitle: 'Update your account password',
            onTap: () {
              // TODO: Navigate to change password
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Change password coming soon!'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
          ),
          _buildOptionCard(
            icon: Icons.security,
            title: 'Two-Factor Authentication',
            subtitle: 'Add extra security to your account',
            onTap: () {
              // TODO: Navigate to 2FA settings
            },
          ),

          const SizedBox(height: 24),

          // Preferences Section
          _buildSectionTitle('Preferences'),
          _buildOptionCard(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage your notification settings',
            onTap: () {
              // TODO: Navigate to notification settings
            },
          ),
          _buildOptionCard(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'Theme and display settings',
            onTap: () {
              // TODO: Navigate to appearance settings
            },
          ),

          const SizedBox(height: 24),

          // Logout Button
          _buildLogoutButton(context, user),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// Build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  /// Build individual option card
  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.black38,
        ),
        onTap: onTap,
      ),
    );
  }

  /// Build logout button
  Widget _buildLogoutButton(BuildContext context, User? user) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () async {
          if (user != null) {
            // Show confirmation dialog
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );

            if (shouldLogout == true && context.mounted) {
              // Sign out from Firebase
              await FirebaseAuth.instance.signOut();

              // Navigate to welcome page
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                  (route) => false,
                );
              }
            }
          } else {
            // Navigate to login if not logged in
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const WelcomePage()),
              (route) => false,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, size: 20),
            const SizedBox(width: 8),
            Text(
              user != null ? 'Logout' : 'Go to Login',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

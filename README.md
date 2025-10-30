This is where the CSC3380 project resides.

===================================
Firebase authentication setup guide
===================================

1. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```

2. Configure Firebase for your project:
   ```bash
   flutterfire configure
   ```
   - Select "lsu-csc3380-project-fall-2025"
   - Choose _at least_ the Web platform

==========
How to run
==========
# 1. Configure Firebase (as seen above)

# 2a. Run from VSCode

Follow this guide: https://docs.flutter.dev/install/with-vs-code

# 2b. Run from the terminal (including the VSCode terminal)
1. ```bash
    # notice: you may already be in the finance_tracker directory
    # if so, this is not needed.
    cd ./CSC3380 - Finance Tracker/finance_tracker
    ```
2. ```bash
    # "lib/welcome_page.dart" is subject to change as the program evolves.
    flutter run -t lib/welcome_page.dart
    ```

===========
Small TODOs
===========

1. Email Verification:
   ```dart
   await user.sendEmailVerification();
   ```

2. Password Reset:
   ```dart
   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
   ```

3. User Profile Picture (Visible User Info):
   ```dart
   await user.updatePhotoURL(photoUrl);
   ```
4. Add Apple Sign-in Authentication:
    https://firebase.google.com/docs/auth/web/apple?authuser=0

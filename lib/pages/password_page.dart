import 'package:bicrouge/pages/course_available_page.dart';
import 'package:bicrouge/pages/signup_page_student.dart';
import 'package:bicrouge/auth.dart'; // Import AuthService
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  final String email; // Add email field to receive from LoginPage

  const PasswordPage({super.key, required this.email});

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final AuthService _authService = AuthService(); // Initialize AuthService
  String selectedRole = 'Student';
  bool isPasswordVisible = false;
  String password = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your password',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Join Bic Rouge for free as a',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Student / Teacher Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleButton('Student'),
                const SizedBox(width: 10),
                _buildRoleButton('Teacher'),
              ],
            ),
            const SizedBox(height: 20),

            // Email display and edit button
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.email, // Display the passed email
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to LoginPage for email edit
                  },
                  child: const Text('Edit', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Password input field
            TextField(
              onChanged: (value) => setState(() => password = value),
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password*',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Forgot password link
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Add logic for password reset here
                },
                child: const Text(
                  'Forgot your password?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Continue button for password authentication
            ElevatedButton(
              onPressed: () async {
                User? user = await _authService.signInWithEmailPassword(widget.email, password);
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursesPage(),
                    ),
                  );
                } else {
                  setState(() {
                    errorMessage = 'Incorrect password. Please try again.';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 10),

            // Display error message
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 10),

            // Sign up link
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for role selection buttons
  Widget _buildRoleButton(String role) {
    bool isSelected = role == selectedRole;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedRole = role;
        });
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.black,
        backgroundColor: isSelected ? Colors.red : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: Colors.red),
        minimumSize: const Size(150, 50),
      ),
      child: Text(role),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'GoogleSignUp.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController1 = TextEditingController(); // Changed from TextEditingController1
  bool _isSigningUp = false; // Track sign-up state

  Future<void> _signUp() async {
    setState(() {
      _isSigningUp = true; // Start the sign-up process
    });

    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim(); // Changed from passwordController1
      final String confirmPassword = _passwordController1.text.trim(); // Changed from passwordController1
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid email and password.')),
        );
        return;
      }

      if (password != confirmPassword) { // Check if passwords match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match.')),
        );
        return;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final User? user = userCredential.user;
        // Send email verification if the user is not null
        await user?.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration successful! A verification email has been sent to your email address. Please verify your email before logging in.',
            ),
          ),
        );
      }
    } catch (e) {
      // Handle registration errors (e.g., email already in use)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isSigningUp = false; // End the sign-up process
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content container
          Container(
            color: Colors.transparent, // Make this container transparent
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(labelText: 'Email'),
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Password'),
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _passwordController1,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Re-Enter Password'),
                                validator: (String? value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: _isSigningUp ? null : _signUp,
                                child: _isSigningUp
                                    ? CircularProgressIndicator()
                                    : Text('Sign In'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF000000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen_G()),
                                  );
                                },
                                child: const Text('Sign In using Google'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
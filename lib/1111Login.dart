// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sihapp/1111ForgotPassword.dart';
// import 'package:sihapp/1111GoogleSignUp.dart';
// import 'package:sihapp/1111HomeScreen.dart';
// import 'package:sihapp/1111SignUp.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _login() async {
//     try {
//       final String email = _emailController.text.trim();
//       final String password = _passwordController.text.trim();
//
//       if (email.isEmpty || password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please enter valid email and password.')),
//         );
//         return;
//       }
//
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (userCredential.user != null) {
//         User? user = userCredential.user;
//
//         if (user!.emailVerified) {
//           // Email is verified, proceed with login
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Login successful!')),
//           );
//
//           // Store user's login state
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.setBool('isLoggedIn', true);
//
//           // Navigate to the HomeScreen
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) => HomeScreen(),
//             ),
//           );
//         } else {
//           // Email is not verified, display a message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Please verify your email before logging in.'),
//               action: SnackBarAction(
//                 label: 'Resend Verification Email',
//                 onPressed: () async {
//                   // Resend the verification email
//                   await user.sendEmailVerification();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Verification email has been resent.'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         }
//       } else {
//         // Handle login failure here (e.g., incorrect credentials)
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed. Please check your credentials.')),
//         );
//       }
//     } catch (e) {
//       // Handle other login errors (e.g., network issues)
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty || !value.contains('@')) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 validator: (String? value) {
//                   if (value == null || value.isEmpty || value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _login,
//                 child: Text('Login'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUpScreen()),
//                   );
//                 },
//                 child: const Text('Sign Up'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                   );
//                 },
//                 child: const Text('Forgot password'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignInScreen_G()),
//                   );
//                 },
//                 child: const Text('Sign In using Google'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

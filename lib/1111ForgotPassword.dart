// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   @override
//   _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//
//   // Function to handle password reset
//   Future<void> _resetPassword() async {
//     try {
//       final String email = _emailController.text.trim();
//
//       if (email.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please enter a valid email address.')),
//         );
//         return;
//       }
//
//       await _auth.sendPasswordResetEmail(email: email);
//
//       // Password reset email sent successfully
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Password reset email sent. Check your inbox.')),
//       );
//     } catch (e) {
//       // Handle password reset errors (e.g., invalid email)
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
//         title: Text('Forgot Password'),
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
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _resetPassword,
//                 child: Text('Reset Password'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

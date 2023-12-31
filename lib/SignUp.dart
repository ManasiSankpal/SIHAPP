// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'GoogleSignUp.dart';
//
// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _passwordController1 = TextEditingController();
//   bool _isSigningUp = false;
//
//   Future<void> _signUp() async {
//     setState(() {
//       _isSigningUp = true;
//     });
//
//     try {
//       final String name = _nameController.text.trim();
//       final String email = _emailController.text.trim();
//       final String password = _passwordController.text.trim();
//       final String confirmPassword = _passwordController1.text.trim();
//
//       if (email.isEmpty || password.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please enter a valid name, email, and password.')),
//         );
//         return;
//       }
//
//       if (password != confirmPassword) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Passwords do not match.')),
//         );
//         return;
//       }
//
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (userCredential.user != null) {
//         final User? user = userCredential.user;
//
//         await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
//           'email': email,
//           'password': password,
//         });
//
//         await user?.sendEmailVerification();
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Registration successful! A verification email has been sent to your email address. Please verify your email before logging in.',
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() {
//         _isSigningUp = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/img_1.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Container(
//             color: Colors.transparent,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 60.0),
//                       child: Text(
//                         "SIGN UP",
//                         style: TextStyle(color: Colors.white, fontSize: 40),
//                       ),
//                     ),
//                     SizedBox(height: 16.0),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         padding: EdgeInsets.all(16.0),
//                         child: SingleChildScrollView(
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SizedBox(height: 16.0),
//                                 TextFormField(
//                                   controller: _emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(labelText: 'Email'),
//                                   validator: (String? value) {
//                                     if (value == null ||
//                                         value.isEmpty ||
//                                         !value.contains('@')) {
//                                       return 'Please enter a valid email address';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 16.0),
//                                 TextFormField(
//                                   controller: _passwordController,
//                                   obscureText: true,
//                                   decoration: InputDecoration(labelText: 'Password'),
//                                   validator: (String? value) {
//                                     if (value == null ||
//                                         value.isEmpty ||
//                                         value.length < 6) {
//                                       return 'Password must be at least 6 characters long';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 16.0),
//                                 TextFormField(
//                                   controller: _passwordController1,
//                                   obscureText: true,
//                                   decoration: InputDecoration(labelText: 'Re-Enter Password'),
//                                   validator: (String? value) {
//                                     if (value == null ||
//                                         value.isEmpty ||
//                                         value != _passwordController.text) {
//                                       return 'Passwords do not match';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 16.0),
//                                 ElevatedButton(
//                                   onPressed: _isSigningUp ? null : _signUp,
//                                   child: _isSigningUp
//                                       ? CircularProgressIndicator()
//                                       : Text('Sign Up'),
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Color(0xFF000000),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                   ),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => SignInScreen_G()),
//                                     );
//                                   },
//                                   child: const Text('Sign In using Google'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sihapp/GoogleSignUp.dart';
import 'package:sihapp/Password_Screen.dart';
import 'package:sihapp/SetPin.dart';
import 'package:sihapp/bg.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSigningUp = false;
  bool _isPasswordVisible = false;

  Future<void> _signUp() async {
    setState(() {
      _isSigningUp = true;
    });

    try {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid email and password.'),
          ),
        );
        return;
      }

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final User? user = userCredential.user;

        await user?.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registration successful! A verification email has been sent to your email address. Please verify your email before logging in.',
            ),
          ),
        );

        // Navigate to the Set PIN screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetPinScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isSigningUp = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BG(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registration",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                      ),
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
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
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
                    ElevatedButton(
                      onPressed: _isSigningUp ? null : _signUp,
                      child:
                      _isSigningUp ? CircularProgressIndicator() : Text('Sign Up'),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Already Have Account",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up Using",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen_G(),
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/google.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
  ));
}


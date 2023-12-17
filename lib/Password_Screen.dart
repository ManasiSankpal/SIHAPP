import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sihapp/HomeScreen.dart';
import 'package:sihapp/bg.dart';
import 'package:sihapp/SignUp.dart'; // Import Firestore

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String enteredPin = "";
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BG(),
          Align(
            alignment: Alignment(10, 0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.0),
                  Text(
                    "Enter PIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  PinCodeTextField(
                    appContext: context,
                    obscureText: true,
                    length: 4,
                    onChanged: (pin) {
                      setState(() {
                        enteredPin = pin;
                      });
                    },
                    onCompleted: (pin) {
                      validatePin(pin);
                    },
                    keyboardType:
                    TextInputType.number,
                    // Set keyboard type to number
                    backgroundColor: Colors.transparent,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeColor: Colors.black,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  isLoading
                      ? CircularProgressIndicator() // Show loader when loading
                      : SizedBox(), // Hide loader when not loading
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // Handle 'Forgot PIN' button press
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  AlertDialog(
                                    title: Text("Forgot PIN"),
                                    content: Text(
                                        "Reset your PIN through email."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: Text(
                            "Forgot PIN?",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validatePin(String pin) async {
    try {
      final User? user = _auth.currentUser;
      final uid = user?.uid;

      print('User UID: $uid');

      if (uid != null) {
        String? storedPin = await getStoredPin(uid);

        print('Stored PIN: $storedPin');

        if (storedPin != null && storedPin == pin) {
          // Display success message
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Success"),
              content: Text("Login successful!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text("Error"),
                  content: Text("Incorrect PIN. Try again."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
          );
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<String?> getStoredPin(String uid) async {
    try {
      DocumentSnapshot pinSnapshot = await FirebaseFirestore.instance
          .collection('PIN').doc(uid).get();

      print('Document Snapshot Data: ${pinSnapshot.data()}');

      if (pinSnapshot.exists) {
        return pinSnapshot['pin'] ?? null;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting stored PIN: $e');
      return null;
    }
  }

}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

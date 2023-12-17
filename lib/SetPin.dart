import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sihapp/Password_Screen.dart';

class SetPinScreen extends StatefulWidget {
  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  TextEditingController _pinController = TextEditingController();
  TextEditingController _confirmPinController = TextEditingController();
  bool _isPinVisible = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _savePinToDatabase(String uid, String pin, String email) async {
    try {
      // Replace 'your_collection' with the name of your Firestore collection
      await FirebaseFirestore.instance.collection('PIN').doc(uid).set({
        'pin': pin,
        'uid': uid,
        'email': email,
        // Add other fields if needed
      });
    } catch (e) {
      print('Error saving PIN to database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _pinController,
              obscureText: !_isPinVisible,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set PIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPinVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPinVisible = !_isPinVisible;
                    });
                  },
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty || value.length < 4) {
                  return 'PIN must be at least 4 digits long';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _confirmPinController,
              obscureText: !_isPinVisible,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Confirm PIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPinVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPinVisible = !_isPinVisible;
                    });
                  },
                ),
              ),
              validator: (String? value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _pinController.text) {
                  return 'PINs do not match';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Perform actions with the set PIN, e.g., save it to the database
                // You can add your logic here
                final pin = _pinController.text;

                // Get the current user's UID and email
                final User? user = FirebaseAuth.instance.currentUser;
                final uid = user?.uid ?? '';
                final email = user?.email ?? '';

                // Save PIN, UID, and email to the database
                await _savePinToDatabase(uid, pin, email);

                // Show success message
                _showSnackBar('PIN set successfully');

                // Navigate to the login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Save PIN'),
            ),
          ],
        ),
      ),
    );
  }
}

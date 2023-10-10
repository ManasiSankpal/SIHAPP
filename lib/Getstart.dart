import 'package:flutter/material.dart';
import 'package:sihapp/ChatBoat.dart';
import 'package:sihapp/Login.dart';
import 'package:sihapp/SignUp.dart';

void main() {
  runApp(GetStartApp());
}

class GetStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Railway Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStartPage(),
    );
  }
}

class GetStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add the image here
            Image.asset('assets/logo.jpg'),

            // Add a space between the image and the text
            SizedBox(height: 16.0),

            // Add the text
            Text(
              'Welcome to ARRIVA!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Add a space between the text and the button
            SizedBox(height: 16.0),

            // Add the button with navigation to ChatbotScreen
            ElevatedButton(
              onPressed: () {
                // Navigate to the ChatScreen when this button is pressed.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: Text('Get Started'),
            ),

            SizedBox(height: 10.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
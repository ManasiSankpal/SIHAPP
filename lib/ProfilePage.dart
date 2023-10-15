import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sihapp/ProfileInputPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Access the user information within the build method
    User? user = _auth.currentUser;
    String email = user?.email ?? 'N/A'; // User email
    String name = user?.displayName ?? 'N/A'; // User phone number

    return WillPopScope(
      onWillPop: () async {
        return true; // Return true to allow the back button press
      },
      child: Scaffold(
        backgroundColor:
            Colors.white, // Change the background color of the Scaffold
        appBar: AppBar(
          title: Text('My Profile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/bot.png'),
                    ),
                    Text(
                      user?.displayName ?? 'N/A',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        email
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.red),
                      title: Text(email),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.blue),
                      title: Text('+1 123-456-7890'),
                    ),
                    SizedBox(height: 26.0),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.green),
                      title: Text('Home Station: ABC Station'),
                    ),
                    ListTile(
                      leading: Icon(Icons.train, color: Colors.black),
                      title: Text('Favorite Train: XYZ Express'),
                    ),
                    SizedBox(height: 26.0),
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.purple),
                      title: Text('Member Since: January 2020'),
                    ),
                    SizedBox(height: 26.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileInputPage()),
                        );
                      },
                      child: Text('Edit Profile'),
                    ),
                    SizedBox(height: 36.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


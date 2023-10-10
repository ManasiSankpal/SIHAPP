import 'package:flutter/material.dart';
import 'package:sihapp/HomeScreen.dart'; // Import your HomeScreen if it's in a different file.



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle the back button press
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
          return true; // Return true to allow the back button press
        },
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      title: Text('My Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
            ),
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Frequent Railway Traveler',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('john.doe@example.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+1 123-456-7890'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Home Station: ABC Station'),
            ),
            ListTile(
              leading: Icon(Icons.train),
              title: Text('Favorite Train: XYZ Express'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Member Since: January 2020'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement a feature to manage and view booking history
              },
              child: Text('View Booking History'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
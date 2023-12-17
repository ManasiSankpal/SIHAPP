import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Add this line for FirebaseStorage

class ProfileInputPage extends StatefulWidget {
  @override
  _ProfileInputPageState createState() => _ProfileInputPageState();
}

class _ProfileInputPageState extends State<ProfileInputPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController trainController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dateController.text = picked.toString().split(' ')[0];
    }
  }

  Future<void> _selectLocation(BuildContext context) async {
    final selectedLocation = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select a Location'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // You can list your predefined locations here
                ListTile(
                  title: Text('Location 1'),
                  onTap: () {
                    Navigator.pop(context, 'Location 1');
                  },
                ),
                ListTile(
                  title: Text('Location 2'),
                  onTap: () {
                    Navigator.pop(context, 'Location 2');
                  },
                ),
                // Add more locations as needed
              ],
            ),
          ),
        );
      },
    );

    if (selectedLocation != null) {
      locationController.text = selectedLocation;
    }
  }

  // Future<void> _selectImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     }
  //   });
  // }
  //
  // Future<void> _uploadImage(String userId) async {
  //   try {
  //     if (_image != null) {
  //       Reference storageReference = FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');
  //
  //       // Check if the file exists
  //       if (!await _image!.exists()) {
  //         // If the file does not exist, upload it
  //         await storageReference.putFile(_image!);
  //       } else {
  //         print('File does not exist at the specified location.');
  //       }
  //     } else {
  //       print('No image selected.');
  //     }
  //   } catch (error) {
  //     print('Error uploading image: $error');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Text(
                'Edit Your Information',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                children: <Widget>[
                  _image != null
                      ? CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_image!),
                  )
                      : ElevatedButton(
                    onPressed: () {
                     // _selectImage();
                    },
                    child: Text('Select Profile Image'),
                  ),
                  SizedBox(height: 20.0),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //     prefixIcon: Icon(Icons.email, color: Colors.red),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(20.0),
                  //     ),
                  //     contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  //     labelStyle: TextStyle(fontSize: 16.0),
                  //   ),
                  //   style: TextStyle(fontSize: 16.0),
                  // ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone, // Set the keyboard type to phone
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),

                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: locationController,
                    onTap: () {
                      _selectLocation(context); // Show the location picker when tapped
                    },
                    decoration: InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(Icons.location_on, color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: trainController,
                    decoration: InputDecoration(
                      labelText: 'Favorite Train',
                      prefixIcon: Icon(Icons.train, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: dateController,
                    onTap: () {
                      _selectDate(context); // Show the date picker when tapped
                    },
                    decoration: InputDecoration(
                      labelText: 'Member Since',
                      prefixIcon: Icon(Icons.calendar_today, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      labelStyle: TextStyle(fontSize: 16.0),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Save user input and navigate back to ProfilePage
                      // You can save the values to your preferred storage or state management solution.
                      try {
                        User? user = FirebaseAuth.instance.currentUser;
                        String userId = user?.uid ?? '';

                        // Save profile information to Firestore
                        await FirebaseFirestore.instance.collection('users').doc(userId).set({
                          'phone': phoneController.text,
                          'location': locationController.text,
                          'favoriteTrain': trainController.text,
                          'memberSince': dateController.text,
                          'userId': user?.uid,
                        });

                        // Upload profile image to Firebase Storage
                      //  await _uploadImage(userId);

                        // Navigate back to the previous screen
                        Navigator.pop(context);
                      } catch (error) {
                        print('Error saving profile: $error');
                        // Handle error, e.g., show an error message
                      }
                    },
                    child: Text('Save Profile'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

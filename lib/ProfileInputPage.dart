import 'package:flutter/material.dart';

class ProfileInputPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController trainController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

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
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.red),
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
                    controller: phoneController,
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
                    onPressed: () {
                      // Save user input and navigate back to ProfilePage
                      // You can save the values to your preferred storage or state management solution.
                      Navigator.pop(context);
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
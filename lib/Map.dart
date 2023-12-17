import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String stationName = '';
  String state = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/map_back.png', // Replace with the actual path to your image
              fit: BoxFit.cover,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Get Station Map",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 300.0, // Adjust the width as needed
                height: 300.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: Colors.green[50], // Adjust the opacity as needed
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextField(
                      labelText: 'Station Name',
                      onChanged: (value) {
                        setState(() {
                          stationName = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    _buildTextField(
                      labelText: 'State',
                      onChanged: (value) {
                        setState(() {
                          state = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle the button press, for example, navigate to a new page with the map
                        // You can use the stationName and state variables for further processing
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MapDisplayPage()));
                      },
                      child: Text('Get Map'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapPage(),
  ));
}

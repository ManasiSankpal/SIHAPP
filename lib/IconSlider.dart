import 'package:flutter/material.dart';

class IconSlider extends StatelessWidget {
  final List<IconData> icons = [
    Icons.hotel_rounded,
    Icons.roofing,
    Icons.music_note,
    Icons.cabin,
    Icons.local_offer,
    Icons.home,
  ];

  final List<String> iconNames = [
    'Hotel',
    'Rooms',
    'Music',
    'Cabins',
    'Local Offer',
    'Home',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 20.0,top: 15.0), // Add top padding
            child: Container(
              width: 85, // Adjust the width of the square background as needed
              height: 85, // Adjust the height of the square background as needed
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                shape: BoxShape.rectangle, // Square shape
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(12.0), // Adjust the border radius as needed
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icons[index],
                    size: 36, // Adjust the icon size as needed
                    color: Colors.grey, // Customize the icon color
                  ),
                  SizedBox(height: 4), // Add some spacing between the icon and its name
                  Text(
                    iconNames[index],
                    style: TextStyle(
                      fontSize: 12, // Adjust the font size as needed
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

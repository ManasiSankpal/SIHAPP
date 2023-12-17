import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerWithIcons extends StatelessWidget {
  final List<List<String>> imagePathsList = [
    [
      'assets/name2.png.webp',
      'assets/mobaile.png',
      'assets/name3.png',
      'assets/name1.png',
    ],
    [
      'assets/facebook.png',
      'assets/offers.png',
      'assets/card.png',
      'assets/upi.png',
    ],
    [
      'assets/message.png',
      'assets/game.png',
      'assets/education.png',
      'assets/more.png',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container With Icons'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30.0), // Add top padding
        child: Container(
          height: 310.0, // Adjust the height for multiple rows
          padding: EdgeInsets.symmetric(
              horizontal: 10.0), // Add padding to the left and right ends
          child: Column(
            children: imagePathsList.map((imagePaths) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20.0), // Add vertical padding between rows
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Align icons horizontally
                  children: imagePaths.map((imagePath) {
                    return Flexible(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Align icons vertically in the center
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (imagePath == 'assets/message.png') {
                                _openCalculatorApp();
                              }
                              // Add more conditions for other images if needed
                            },
                            child: ClipOval(
                              child: Image.asset(
                                imagePath,
                                width: 51.0, // Set a fixed width for the image
                                height: 51.0, // Set a fixed height for the image
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to scale the image to fill the container
                                cacheWidth:
                                400, // Adjust the cacheWidth based on your needs
                                cacheHeight:
                                400, // Adjust the cacheHeight based on your needs
                              ),
                            ),
                          ),
                          SizedBox(height: 7.0), // Adjust spacing
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _openCalculatorApp() async {
    // The package name for the calculator app may vary on different devices
    const String calculatorPackage = 'com.android.calculator2';

    if (await canLaunch('package:$calculatorPackage')) {
      await launch('package:$calculatorPackage');
    } else {
      // If the calculator app is not found, you can handle it accordingly
      print('Calculator app not found on the device.');
    }
  }
}



import 'package:flutter/material.dart';
import 'package:sihapp/AnnouncementPage.dart';
import 'package:sihapp/LostFound.dart';
import 'package:sihapp/Map.dart';
import 'package:sihapp/Translator.dart';
import 'package:url_launcher/url_launcher.dart';

class IconSlider extends StatelessWidget {
  final List<String> iconAssetPaths = [
    'assets/announce.png',
    'assets/translator.png',
    'assets/help_icon.png',
    'assets/map.png',
    'assets/hotel_icon.png',
    'assets/food_bank_icon.png',
    'assets/music_icon.png',
  ];

  final List<String> iconNames = [
    'Announcements',
    'Translator',
    'lost and found',
    'Map',
    'Hotel',
    'Food',
    'Music',

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: iconAssetPaths.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 20.0, top: 15.0),
            child: GestureDetector(
              onTap: () {
                if (iconNames[index] == 'Announcements') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnnouncementPage()),
                  );
                } else if (iconNames[index] == 'Traslator') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TranslatorPage()),
                 );
                } else if (iconNames[index] == 'Help for lost and found') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LostAndFoundPage()),
                  );
                }
                else if (iconNames[index] == 'Station Map') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                }
                else {
                  launchWebsite(index);
                }
              },
              child: Container(
                width: 95,
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      iconAssetPaths[index],
                      width: 45,
                      height: 45,

                    ),
                    SizedBox(height: 4),
                    Text(
                      iconNames[index],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void launchWebsite(int index) {
    String url;
    switch (iconNames[index]) {
      case 'Hotel':
        url = 'https://www.trivago.in/';
        break;
      case 'Food':
        url = 'https://www.swiggy.com/';
        break;
      case 'Music':
        url = 'https://www.spotify.com/';
        break;
      default:
        return;
    }
    launch(url);
  }
}

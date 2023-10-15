import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sihapp/IconSlider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sihapp/lineWithCircles.dart';
import 'package:sihapp/TrainSummary Section.dart';
import 'package:sihapp/myBottomNavigation.dart';

int _selectedIndex = 0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

PageTransition customPageTransition(Widget page) {
  return PageTransition(
    type: PageTransitionType.rightToLeft,
    child: page,
  );
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to light black

      body: Stack(
        children: [
          // Background Image (if needed)
          // Content
          ListView(
            padding: EdgeInsets.all(0), // Remove top padding
            children: [
              SizedBox(
                height: 350.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFB2819E), // Start color
                        Color(0xFFD78182), // Middle color
                        Color(0xFFCE637F), // End color
                        Color(0xFFFFFFFF), // End color
                        Color(0xFFFFFFFF), // End color
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 25, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome, Users", // Your first text here
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        // fontWeight: FontWeight.w500, // Medium text weight
                                      ),
                                    ),
                                    Text(
                                      "Your Questions Our Answers!", // Your second text here
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            20, // Adjust the font size as needed
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons
                                      .account_circle, // Replace with your user icon
                                  color: Color(0xFFDADDEE),
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 60.0),
                          HeaderOveright(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SliderIconSection(),

              IconSlider(),

              ImageSection(),

              // First section:
              AccountSummarySection(),

              // Second section:
              ContainerWithIcons(),

              // Third section:
              TrainSummarySection(),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors
                      .lightBlue[100], // Set the background color to light blue
                  elevation: 5, // Add elevation for a card-like effect
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Set circular radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Add inner padding for space within the Card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upcoming Trip',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('HK789KOG'),
                            Text('Malabar (119) Economy (CA)'),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Yogyakarta (YK)'),
                            Text('Bandung (BD)'),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('19:30 WIB'),
                            Text('06:30 WIS'),
                          ],
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        // Use the imported class
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class AccountSummarySection extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/img_4.jpg',
    'assets/img_5.jpg',
    'assets/img_6.jpg',
    'assets/img_4.1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 150.0,
                      aspectRatio: 16 / 18,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        // Handle page change here if needed
                      },
                      // Add dots indicator below the slider
                      scrollDirection: Axis.horizontal,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      disableCenter: true,
                      pauseAutoPlayOnManualNavigate: true,
                      scrollPhysics: BouncingScrollPhysics(),
                    ),
                    items: imagePaths.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              imagePath,
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                              cacheWidth:
                                  2000, // Adjust the cacheWidth based on your needs
                              cacheHeight:
                                  2000, // Adjust the cacheHeight based on your needs
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10.0), // Add spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imagePaths.map((imagePath) {
                      int index = imagePaths.indexOf(imagePath);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue, // Adjust indicator color
                        ),
                        // Highlight the current image's indicator
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Padding(
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
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Align icons vertically in the center
                      children: [
                        ClipOval(
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
    );
  }
}

class HeaderOveright extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: ClipPath(
            child: Container(
              width: 355.0,
              height: 200.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE19297), // Custom color 1
                    Color(0xFFE7AEB7), // Custom color 2
                    Color(0xFFEEEDF5), // Custom color 3
                  ],
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          left: 225.0,
          child: Stack(
            children: [
              Container(
                width: 160.0,
                height: 51.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFCA6A7D),
                      Color(0xFFCC7289),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              Center(
                child: Container(
                  height: 45.0,
                  width: 125.0, // Adjust the width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        20.0), // Circular corners for the Container
                    gradient: LinearGradient(
                      colors: [Color(0xFFD07C7F), Color(0xFFD6727E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10.0,
                        // bottom: 5.0,
                        // right: 5.0,
                        top: 0.0), // Adjust the left and top padding as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Circular corners for the Button
                        ),
                      ),
                      onPressed: () {
                        // Add your button's action here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Button ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down, // Downward arrow icon
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset(
          'assets/p1.png', // Replace with your image URL
          // width: 200, // Adjust the width as needed
          height: 170, // Adjust the height as needed
          fit: BoxFit.cover, // Adjust the fit as needed
        ),
      ),
    );
  }
}


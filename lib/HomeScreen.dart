import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sihapp/ChatBoat2.dart';
import 'package:sihapp/IconSlider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sihapp/UpcomingTripCard.dart';
import 'package:sihapp/announcements_strip.dart';
import 'package:sihapp/chatbot3.dart';
import 'package:sihapp/lineWithCircles.dart';
import 'package:sihapp/TrainSummary Section.dart';
import 'package:sihapp/menu.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
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
    return Scaffold(
      backgroundColor: Colors.white,
      // Remove the appBar
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          // Background Image (if needed)
          Container(
            height: 350.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF6415EA),
                  Color(0xFF2A62EE),
                  Color(0xFF63B1CE),
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
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
                        top: 50,
                        left: 15,
                        right: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Welcome To IRCTC",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "      Your journey begins here..",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 60.0),
                    Center(
                      child: Column(
                        children: [
                          AnimatedRippleIcon(),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //SizedBox(height: 16.0),
          // Other widgets in the ListView...
          AnnouncementStrip(), // Insert the announcement strip here
          IconSlider(),
          TrainSummarySection(),
          UpcomingTripCard(),
          ImageSection(),
          ContainerWithIcons(),
          Text("*For Your Advertisement, Contact Us.",style: (TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.redAccent)),),
          AccountSummarySection(),

        ],
      ),
      // Add a menu icon at the top right
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 46.0),
        child: Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(customPageTransition(MenuScreen()));
            },
            child: Icon(Icons.menu, color: Colors.black),
          ),
        ),
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
      padding: EdgeInsets.only(top: 20.0), // Add top padding
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

class AnimatedRippleIcon extends StatefulWidget {
  @override
  _AnimatedRippleIconState createState() => _AnimatedRippleIconState();
}

class _AnimatedRippleIconState extends State<AnimatedRippleIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  void _goToMenuPage() {
    // Use Navigator to navigate to the chatbot page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatbotScreen1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _goToMenuPage,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Colors.blue, Colors.transparent],
                    stops: [5.5, 4.0],
                  ),
                ),
                child: Image.asset(
                  'assets/chat.png',
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

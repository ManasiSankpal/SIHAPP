import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sihapp/AnnouncementPage.dart';
import 'package:sihapp/ChatBoat2.dart';
import 'package:sihapp/FeedBack.dart';
import 'package:sihapp/LostFound.dart';
import 'package:sihapp/ProfilePage.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import cached_network_image package

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> _signOut(BuildContext context) async {
  try {
    await _auth.signOut();

    // Clear user's login state
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false); // Set isLoggedIn to false

    // Navigate to the LoginScreen
    Navigator.of(context).pushReplacementNamed('/login');
  } catch (e) {
    print('Error during sign out: $e');
  }
}

Future<void> _showSignOutConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sign Out Confirmation'),
        content: Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _signOut(context); // Sign out when confirmed
            },
            child: Text('Sign Out'),
          ),
        ],
      );
    },
  );
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSearchBarActive = true;

  void toggleSearchBar() {
    setState(() {
      isSearchBarActive = !isSearchBarActive;
    });
  }

  void _signOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Set the background color to light black
      appBar: AppBar(
        title: Text('EVA'),
        actions: [
          IconButton(
            icon: Icon(isSearchBarActive ? Icons.close : Icons.search),
            onPressed: toggleSearchBar,
          ),
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ChatScreen2(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Add your drawer content here
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('john.doe@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('FeedBack'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => FeedbackForm(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _showSignOutConfirmationDialog(context); // Show confirmation dialog
                child: Text('Sign Out');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image (if needed)

          // Content
          Scrollbar(
            child: ListView(
              children: [
                // First section:
                ContainerWithIcons(),
                // Second section:
                AccountSummarySection(),
                // Third section:
                TrainSummarySection(),



                // Upcoming trip
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.lightBlue[100], // Set the background color to light blue
                    elevation: 5, // Add elevation for a card-like effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Set circular radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Add inner padding for space within the Card
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AnnouncementPage(),
              ),
            );
          }
          if (index == 2) {
            final shareableLink = 'https://flutter.dev/';
            Share.share(
              shareableLink,
              subject: 'Share this link',
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
          else if (index == 4) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LostAndFoundPage(),
              ),
            );
          }
        },


        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'help',
          ),
        ],
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
      padding: const EdgeInsets.all(16.0),
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
                              cacheWidth: 2000, // Adjust the cacheWidth based on your needs
                              cacheHeight: 2000, // Adjust the cacheHeight based on your needs
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







class TrainSummarySection extends StatelessWidget {
  String from = '';
  String to = '';
  String departure = '';
  String date = '';
  String trainType = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'search for train',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'From'),
                onChanged: (value) {
                  from = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'To'),
                onChanged: (value) {
                  to = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Departure'),
                onChanged: (value) {
                  departure = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Date'),
                onChanged: (value) {
                  date = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Train Type'),
                onChanged: (value) {
                  trainType = value;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  print('Searching for trains:');
                  print('From: $from');
                  print('To: $to');
                  print('Departure: $departure');
                  print('Date: $date');
                  print('Train Type: $trainType');
                },
                child: Text('Search Train'),
              ),
            ],
          ),
        ),
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
        padding: EdgeInsets.symmetric(horizontal: 10.0), // Add padding to the left and right ends
        child: Column(
          children: imagePathsList.map((imagePaths) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0), // Add vertical padding between rows
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align icons horizontally
                children: imagePaths.map((imagePath) {
                  return Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Align icons vertically in the center
                      children: [
                        ClipOval(
                          child: Image.asset(
                            imagePath,
                            width: 51.0, // Set a fixed width for the image
                            height: 51.0, // Set a fixed height for the image
                            fit: BoxFit.cover, // Use BoxFit.cover to scale the image to fill the container
                            cacheWidth: 400, // Adjust the cacheWidth based on your needs
                            cacheHeight: 400, // Adjust the cacheHeight based on your needs
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

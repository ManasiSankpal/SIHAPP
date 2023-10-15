import 'package:flutter/material.dart';
import 'package:sihapp/HomeScreen.dart';
import 'package:page_transition/page_transition.dart';


PageTransition customPageTransition(Widget page) {
  return PageTransition(
    type: PageTransitionType.rightToLeft,
    child: page,
  );
}
class LostAndFoundPage extends StatefulWidget {
  @override
  _LostAndFoundPageState createState() => _LostAndFoundPageState();
}



class _LostAndFoundPageState extends State<LostAndFoundPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Handle the back button press
          Navigator.of(context).pop(customPageTransition(HomeScreen()));
          return true; // Return true to allow the back button press
    },
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Find My Thing'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img_7.png'),
            Text(
              'Lost something? Find it here!',
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Make it bold
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the report a lost item page
              },
              child: Text('Report a lost item'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the claim a found item page
              },
              child: Text('Claim a found item'),
            ),
          ],
        ),
      ),
    ),);
  }
}
void main() {
  runApp(MaterialApp(
    home: LostAndFoundPage(),
  ));
}





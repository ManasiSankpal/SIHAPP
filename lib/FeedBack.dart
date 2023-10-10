import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sihapp/HomeScreen.dart';

class FeedbackForm extends StatelessWidget {
  double rating = 0.0;
  String feedback = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Handle the back button press
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      return true; // Return true to allow the back button press
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form'),
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
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/img_1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Feedback form text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Feedback Form',
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the text color
                  ),
                ),
              ),
              // Form content
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Scrollbar( // Wrap with Scrollbar
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter your Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 26.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter your email address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address.';
                              }
                              return null;
                            },
                          ),
                          Text(
                            'Please rate your experience:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 40.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (newRating) {
                              rating = newRating;
                            },
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Please share your feedback:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Enter your feedback here...',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              feedback = value;
                            },
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              // Handle form submission here (e.g., send feedback to a server)
                              print('Rating: $rating');
                              print('Feedback: $feedback');
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),);
  }
}

void main() {
  runApp(MaterialApp(
    home: FeedbackForm(),
  ));
}

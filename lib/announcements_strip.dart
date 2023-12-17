import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';

class AnnouncementStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0, // Adjust the height as needed
      child: Shimmer.fromColors(
        baseColor: Colors.red[500]!, // Base color of the shimmering effect
        highlightColor: Colors.yellow[200]!, // Highlight color of the shimmering effect
        child: Marquee(
          text: "Your announcement goes here. Customize as needed.",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0, // Adjust the space between repetitions
          velocity: 50.0, // Adjust the scroll speed
          pauseAfterRound: Duration(seconds: 1), // Pause duration after each repetition
          startPadding: 10.0, // Padding at the beginning of the text
          accelerationDuration: Duration(seconds: 1), // Duration for acceleration
          accelerationCurve: Curves.linear, // Acceleration curve
          decelerationDuration: Duration(milliseconds: 500), // Duration for deceleration
          decelerationCurve: Curves.easeOut, // Deceleration curve
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text("Bold Announcement Strip Example")),
      body: AnnouncementStrip(),
    ),
  ));
}

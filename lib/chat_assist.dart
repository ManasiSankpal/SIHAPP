// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:sihapp/FeedBack.dart';

//
// Widget chat_assist() {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/chat.png',
//               width: 120,
//               height: 120,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 20.0),
//             Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: Text(
//                 "Rail adventure ahead! How can I assist?",
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//                    Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.train,
//                         size: 30,
//                         color: Color(0xFF001F3F),
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Search Train',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.video_library,
//                         size: 30,
//                         color: Colors.red,
//
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'Demo',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//
//               ],
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.question_answer,
//                         size: 30,
//                         color: Colors.blue,
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'People Always Ask',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.feedback,
//                           size: 30,
//                           color: Colors.green,
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'Feedback',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
//
// void main() {
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         body: chat_assist(),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:sihapp/FeedBack.dart';
import 'package:sihapp/TrainSummary Section.dart';

class ChatAssist extends StatelessWidget {
  final List<IconData> icons = [
    Icons.train,
    Icons.video_library,
    Icons.question_answer,
  ];

  final List<String> iconNames = [
    'Search Train',
    'Demo',
    'People Always Ask',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image above the containers
        Image.asset(
          'assets/chat.png',
          width: 100,
          height: 100,
        ),
        Container(
          height: 110, // Adjust the height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: icons.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0, top: 15.0),
                child: GestureDetector(
                  onTap: () {
                    if (iconNames[index] == 'Search Train') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrainSummarySection()),
                      );
                    } else if (iconNames[index] == 'Demo') {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ),
                      // );
                    } else if (iconNames[index] == 'People Always Ask') {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ),
                      // );
                    }
                  },
                  child: Container(
                    width: 95,
                    height: 70,
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
                        Icon(
                          icons[index],
                          size: 25,
                          color: Colors.grey,
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
        ),
      ],
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: ChatAssist(),
      ),
    ),
  );
}






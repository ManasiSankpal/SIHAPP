// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sihapp/Login.dart';
//
// class ForgotPinScreen extends StatefulWidget {
//   @override
//   _ForgotPinScreenState createState() => _ForgotPinScreenState();
// }
//
// class _ForgotPinScreenState extends State<ForgotPinScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//
//   Future<void> _resetPin() async {
//     try {
//       await _auth.sendPinResetEmail(email: _emailController.text);
//       // Pin reset email sent successfully
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Pin reset email sent.'),
//         ),
//       );
//     } catch (e) {
//       // Handle errors, e.g., if the email doesn't exist in the database
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//         ),
//       );
//     }
//   }
//
//   // Scroll controller for the ListView
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF2F5FC),
//       appBar: AppBar(
//         elevation: 0.0, // Set the elevation to 0.0 (removes the shadow)
//         backgroundColor: Colors.transparent, // Set the background color to transparent
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () async {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => LoginScreen(),
//               ),
//             );
//           },
//         ),
//         iconTheme: IconThemeData(color: Colors.black), // Set the icon color to blue
//       ),
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           if (notification.metrics.axis == Axis.vertical &&
//               notification.metrics.pixels > 0 &&
//               MediaQuery.of(context).viewInsets.bottom > 0) {
//             // Scroll up when the keyboard appears
//             _scrollController.animateTo(
//               _scrollController.position.maxScrollExtent,
//               duration: Duration(milliseconds: 300),
//               curve: Curves.easeOut,
//             );
//           }
//
//           return false;
//         },
//         child: Stack(
//           children: [
//             // Positioned(
//             //   top: 30.0,
//             //   left: 16.0,
//             //   child: IconButton(
//             //     icon: Icon(Icons.arrow_back_ios_new),
//             //     onPressed: () {
//             //       // Handle the back button press with a custom transition
//             //       Navigator.of(context).pop(
//             //         MaterialPageRoute(
//             //           builder: (context) => LoginScreen(),
//             //         ),
//             //       );
//             //     },
//             //   ),
//             // ),
//             ListView.builder(
//               controller: _scrollController,
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Dismiss the keyboard when tapping outside the input field
//                     FocusScope.of(context).unfocus();
//                   },
//                   child: Column(
//                     children: [
//                       // SizedBox(height: 0.0),
//                       Image.asset(
//                         'assets/Forgot password image.png',
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         height: MediaQuery.of(context).size.width * 0.7,
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             'Forgot Pin?',
//                             style: TextStyle(
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Roboto',
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text(
//                             'Enter the email address associated',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'Roboto',
//                               color: Colors.grey,
//                             ),
//                           ),
//                           SizedBox(height: 5.0),
//                           Text(
//                             'with your account.',
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontFamily: 'Roboto',
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16.0),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 17.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(25.0),
//                           child: Container(
//                             color: Colors.white,
//                             padding: EdgeInsets.all(25.0),
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     controller: _emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     decoration: InputDecoration(labelText: 'Email'),
//                                     validator: (String? value) {
//                                       if (value == null || value.isEmpty || !value.contains('@')) {
//                                         return 'Please enter a valid email address';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   SizedBox(height: 30.0),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ElevatedButton.icon(
//                                         onPressed: () {
//                                           _resetPin();
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           padding: EdgeInsets.all(15),
//                                           elevation: 0,
//                                           primary: Colors.transparent,
//                                         ),
//                                         icon: Container(
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Color(0xFF5B9FCC),
//                                                 Color(0xFF187EC3),
//                                               ],
//                                               begin: Alignment.centerLeft,
//                                               end: Alignment.centerRight,
//                                             ),
//                                             borderRadius: BorderRadius.circular(20),
//                                           ),
//                                           width: 270.0,
//                                           height: 40.0,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Text(
//                                                 'Reset Pin',
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white,
//                                                 ),
//                                               ),
//                                               SizedBox(width: 10), // Add some spacing between text and icon
//                                               Icon(
//                                                 Icons.arrow_forward,
//                                                 size: 30,
//                                                 color: Colors.white,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         label: Text(''),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LostAndFoundPage extends StatefulWidget {
  @override
  _LostAndFoundPageState createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  String itemName = '';
  String location = '';
  DateTime? foundDate;
  String itemType = '';
  String contactInfo = '';
  String selectedTab = 'Lost';

  final List<String> itemTypes = ['Electronics', 'Clothing', 'Accessories'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lost and Found'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Lost'),
                    Tab(text: 'Found'),
                  ],
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50.0),

                  ),
                  onTap: (index) {
                    setState(() {
                      selectedTab = index == 0 ? 'Lost' : 'Found';
                    });
                  },
                ),
                SizedBox(height: 16.0), // Add space between TabBar and Container
                Container(

                  // Add a Container for additional content below TabBar
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Set the background color for the Container
                    border: Border.all(color: Colors.black,width: 2.0), // Set border color for the Container
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Report ${selectedTab == 'Lost' ? 'Lost' : 'Found'} Item',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildIconTextField(
                        labelText: 'Item Name',
                        onChanged: (value) {
                          setState(() {
                            itemName = value;
                          });
                        },
                        icon: Icons.edit,
                      ),
                      SizedBox(height: 16.0),
                      _buildIconTextField(
                        labelText: 'Location',
                        onChanged: (value) {
                          setState(() {
                            location = value;
                          });
                        },
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? foundDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (foundDate != null) {
                            setState(() {
                              this.foundDate = foundDate;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: _buildIconTextField(
                            labelText: 'Date',
                            controller: TextEditingController(
                              text: foundDate != null
                                  ? "${foundDate!.day}/${foundDate!.month}/${foundDate!.year}"
                                  : '',
                            ),
                            icon: Icons.calendar_today,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildIconTextField(
                        labelText: 'Item Type',
                        onTap: () {
                          _showItemTypesDialog();
                        },
                        controller: TextEditingController(text: itemType),
                        readOnly: true,
                        icon: Icons.category,
                      ),
                      SizedBox(height: 16.0),
                      _buildIconTextField(
                        labelText: 'Contact Information',
                        onChanged: (value) {
                          setState(() {
                            contactInfo = value;
                          });
                        },
                        icon: Icons.contact_mail,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          _submitReport();
                        },
                        child: Text('${selectedTab == 'Lost' ? 'Lost' : 'Found'} Item'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIconTextButton(
                      onPressed: () {
                        // Add logic for 'See Found Item List'
                        print('See Found Item List');
                      },
                      label: 'Found Item List',
                      icon: Icons.list, // Add the desired icon
                      //color: Colors.grey,
                    ),
                    _buildIconTextButton(
                      onPressed: () async {
                        // Add logic for 'Talk to Us'
                        // final Uri url = Uri(scheme: 'tel', path: "182");
                        // if (await canLaunchUrl(url.toString())) {
                        //   await launch(url.toString());
                        // } else {
                        //   print('Could not launch $url');
                        // }
                      },

                      label: 'Helpline',
                      icon: Icons.phone, // Add the desired icon
                      //color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconTextField({
    required String labelText,
    TextEditingController? controller,
    bool readOnly = false,

    Function()? onTap,
    Function(String)? onChanged,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
        ),
        prefixIcon: icon != null ? Icon(icon, color: Colors.orange) : null,
      ),
    );
  }

  Widget _buildIconTextButton({
    required Function() onPressed,
    required String label,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }

  void _submitReport() async {
    try {
      // Get current user
      User? user = FirebaseAuth.instance.currentUser;

      // Create a reference to the Firebase collection
      String collectionName = selectedTab.toLowerCase(); // 'lost' or 'found'
      CollectionReference lostAndFoundCollection =
      FirebaseFirestore.instance.collection(collectionName);

      // Add the data to the collection
      await lostAndFoundCollection.add({
        'itemName': itemName,
        'location': location,
        'foundDate': foundDate,
        'itemType': itemType,
        'contactInfo': contactInfo,
        'userId': user?.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Optionally, you can navigate to a different screen or show a success message
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => SuccessScreen(),
      // ));
    } catch (error) {
      print('Error submitting report: $error');
      // Handle error, e.g., show an error message
    }
  }



  void _showItemTypesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Item Type'),
        content: Column(
          children: itemTypes.map((type) {
            return ListTile(
              title: Text(type),
              onTap: () {
                setState(() {
                  itemType = type;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}




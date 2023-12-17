import 'package:flutter/material.dart';

class TrainSummarySection extends StatefulWidget {
  @override
  _TrainSummarySectionState createState() => _TrainSummarySectionState();
}

class _TrainSummarySectionState extends State<TrainSummarySection> {
  String from = '';
  String to = '';
  TimeOfDay? departureTime;
  DateTime? selectedDate;
  String trainType = '';
  String selectedTab = 'Search by Station';

  final List<String> trainTypes = ['Express', 'Superfast', 'Local'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.orange, width: 2.0),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),

                ),
                child: TabBar(
                  tabs: [
                    Tab(text: 'Search by Station'),
                    Tab(text: 'Search by Train No'),
                  ],
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onTap: (index) {
                    setState(() {
                      selectedTab = index == 0 ? 'Search by Station' : 'Search by Train No';
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Search for Train',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //SizedBox(height: 16.0),
                    // Other common fields
                    if (selectedTab == 'Search by Station') ...[
                      _buildIconTextField(
                        labelText: 'From',
                        onChanged: (value) {
                          setState(() {
                            from = value;
                          });
                        },
                        icon: Icons.location_on,
                      ),
                      SizedBox(height: 10.0),
                      _buildIconTextField(
                        labelText: 'To',
                        onChanged: (value) {
                          setState(() {
                            to = value;
                          });
                        },
                        icon: Icons.location_on,
                      ),
                    ],
                    SizedBox(height: 16.0),
                    if (selectedTab == 'Search by Station') ...[
                      // Fields specific to 'Search by Station'
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              departureTime = pickedTime;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: _buildIconTextField(
                            labelText: 'Departure',
                            controller: TextEditingController(
                              text: departureTime != null
                                  ? "${departureTime!.hour}:${departureTime!.minute}"
                                  : '',
                            ),
                            icon: Icons.access_time,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: AbsorbPointer(
                          child: _buildIconTextField(
                            labelText: 'Date',
                            controller: TextEditingController(
                              text: selectedDate != null
                                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                  : '',
                            ),
                            icon: Icons.calendar_today,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _buildIconTextField(
                        labelText: 'Train Type',
                        onTap: () {
                          _showTrainTypesDialog();
                        },
                        controller: TextEditingController(text: trainType),
                        readOnly: true,
                        icon: Icons.train,
                      ),
                    ],
                    if (selectedTab == 'Search by Train No') ...[
                      _buildIconTextField(
                        labelText: 'Enter Train Number',
                        onChanged: (value) {
                          // Handle the train number input
                          // You can store it in a variable if needed
                        },
                        icon: Icons.train,
                      ),
                    ],
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        print('Searching for trains:');
                        print('From: $from');
                        print('To: $to');
                        print('Departure: ${departureTime?.format(context)}');
                        print('Date: ${selectedDate?.toLocal()}');
                        print('Train Type: $trainType');
                      },
                      child: Text('Search Train'),
                    ),
                  ],
                ),
              ),
            ],
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
          borderRadius: BorderRadius.circular(20.0), // Set the circular radius
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
        prefixIcon: icon != null ? Icon(icon, color: Colors.orange) : null,
      ),
    );
  }

  void _showTrainTypesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Train Type'),
        content: Column(
          children: trainTypes.map((type) {
            return ListTile(
              title: Text(type),
              onTap: () {
                setState(() {
                  trainType = type;
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

import 'package:flutter/material.dart';


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
        color: Colors.lightBlue[100],
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
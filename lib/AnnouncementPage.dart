import 'package:flutter/material.dart';
import 'package:sihapp/HomeScreen.dart';

class AnnouncementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        return false; // Return false to prevent default back button behavior
      },
      child: MaterialApp(
        home: NotificationPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[900],
          primaryColor: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)), // Set app bar text color
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
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white), // Set search icon color
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildButtons(),
          Divider(color: Colors.white), // Add a divider with white color
          _buildTabContent(_selectedTabIndex),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement a new notification action
        },
        child: Icon(Icons.add, color: Colors.white), // Set the FAB icon color to blue
        backgroundColor: Colors.lightBlue, // Set the FAB's background color to white
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          _buildRoundButton('All', 0),
          _buildRoundButton('Alerts', 1),
          _buildRoundButton('Promotions', 2),
        ],
      ),
    );
  }

  Widget _buildRoundButton(String label, int index) {
    final isSelected = index == _selectedTabIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedTabIndex = index; // Update the selected tab index
          });
        },
        style: ElevatedButton.styleFrom(
          primary: isSelected ? Colors.blue : Colors.white, // Set button color based on selection
          onPrimary: isSelected ? Colors.white : Colors.black, // Set button text color based on selection
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.black, // Set button border color based on selection
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return AllNotifications();
      case 1:
        return AlertNotifications();
      case 2:
        return PromotionNotifications();
      default:
        return AllNotifications();
    }
  }
}

class AllNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          // Add your All notifications here
          NotificationItem(
            title: 'Train Delay',
            subtitle: 'Today | 10:30 AM',
            message: 'Train ABC is delayed by 30 minutes.',
            isNew: true,
          ),

          NotificationItem(
            title: 'Platform Change',
            subtitle: 'Yesterday | 3:45 PM',
            message: 'Train XYZ now departs from Platform 2.',
            isNew: true,
          ),

          NotificationItem(
            title: 'Ticket Booking',
            subtitle: 'Yesterday | 5:00 PM',
            message: 'Your ticket for Train DEF has been confirmed.',
            isNew: false,
          ),
          NotificationItem(
            title: 'Ticket Cancellation',
            subtitle: 'Yesterday | 2:15 PM',
            message: 'Your ticket for Train GHI has been canceled successfully.',
            isNew: false,
          ),

          NotificationItem(
            title: 'Special Discount',
            subtitle: 'Today | 11:45 AM',
            message: 'Get a 20% discount on first-class tickets this weekend.',
            isNew: false,
          ),
        ],
      ),
    );
  }
}

class AlertNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          // Add your Alert notifications here
          NotificationItem(
            title: 'Emergency Alert',
            subtitle: 'Today | 1:30 PM',
            message: 'Emergency evacuation drill scheduled for tomorrow at Station PQR.',
            isNew: true,
          ),NotificationItem(
            title: 'Weather Advisory',
            subtitle: 'Tomorrow | 7:00 AM',
            message: 'Severe weather conditions expected. Check for service updates.',
            isNew: true,
          ),

          NotificationItem(
            title: 'Platform Closure',
            subtitle: 'Next Week | 9:15 AM',
            message: 'Platform QRS will be closed for maintenance next week.',
            isNew: true,
          ),


          NotificationItem(
            title: 'Service Disruption',
            subtitle: 'Yesterday | 4:45 PM',
            message: 'Train services temporarily disrupted due to technical issues.',
            isNew: false,
          ),

          NotificationItem(
            title: 'Weather Advisory',
            subtitle: 'Tomorrow | 7:00 AM',
            message: 'Severe weather conditions expected. Check for service updates.',
            isNew: false,
          ),

          NotificationItem(
            title: 'Platform Closure',
            subtitle: 'Next Week | 9:15 AM',
            message: 'Platform QRS will be closed for maintenance next week.',
            isNew: false,
          ),
        ],
      ),
    );
  }
}

class PromotionNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          // Add your Promotion notifications here
          NotificationItem(
            title: 'Weekend Getaway Offer',
            subtitle: 'Today | 8:00 AM',
            message: 'Book your train tickets this weekend and get 30% off on hotel bookings.',
            isNew: true,
          ),
          NotificationItem(
            title: 'Travel Rewards Program',
            subtitle: 'Yesterday | 11:30 AM',
            message: 'Join our travel rewards program and earn points for every journey.',
            isNew: true,
          ),

          NotificationItem(
            title: 'Discounted Fares',
            subtitle: 'Tomorrow | 2:45 PM',
            message: 'Special discounted fares for students traveling during the holidays.',
            isNew: true,
          ),

          NotificationItem(
            title: 'Summer Vacation Offer',
            subtitle: 'Next Week | 9:00 AM',
            message: 'Plan your summer vacation with us and enjoy exclusive discounts on train tickets.',
            isNew: false,
          ),

          NotificationItem(
            title: 'Travel Rewards Program',
            subtitle: 'Yesterday | 11:30 AM',
            message: 'Join our travel rewards program and earn points for every journey.',
            isNew: false,
          ),

          NotificationItem(
            title: 'Discounted Fares',
            subtitle: 'Tomorrow | 2:45 PM',
            message: 'Special discounted fares for students traveling during the holidays.',
            isNew: false,
          ),

          NotificationItem(
            title: 'Summer Vacation Offer',
            subtitle: 'Next Week | 9:00 AM',
            message: 'Plan your summer vacation with us and enjoy exclusive discounts on train tickets.',
            isNew: false,
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final String title;
  final String subtitle;
  final String message;
  final bool isNew;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.message,
    required this.isNew,
  }) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(16.0), // Add padding to the ListTile
          leading: Container( // Display the circular icon for all notifications
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Set the desired background color to white
            ),
            child: Center(
              child: Icon(
                Icons.notifications, // You can change the icon to your preference
                color: Colors.black, // Set the icon color to black
              ),
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set text color to white
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.0),
              Text(widget.subtitle, style: TextStyle(color: Colors.white)), // Set subtitle text color to white
              SizedBox(height: 4.0),
              Text(
                widget.message,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          trailing: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: widget.isNew ? Colors.green : Colors.transparent, // Change colors
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              widget.isNew ? 'New' : '', // Show 'New' based on isNew
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 0.0), // No gap between notifications
      ],
    );
  }
}
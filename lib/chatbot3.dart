import 'package:flutter/material.dart';
import 'package:sihapp/FeedBack.dart';
import 'package:sihapp/HomeScreen.dart';
import 'AnnouncementPage.dart';
import 'package:sihapp/chat_assist.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: ChatbotScreen1(),
  ));
}

class ChatbotScreen1 extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen1> {
  List<List<ChatMessage>> _conversations = [];
  List<ChatMessage> _currentConversation = [];
  TextEditingController _textController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChatAssistVisible = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Eva'),
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(customPageTransition(HomeScreen()));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(customPageTransition(FeedbackForm()));
              },
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('New Chat'),
                onTap: () {
                  Navigator.pop(context);
                  _handleNewChat();
                },
              ),
              ListTile(
                title: Text('PNR Status'),
                onTap: () {
                  Navigator.pop(context);
                  _askPNRInformation();
                },
              ),
              ListTile(
                title: Text('Live Train Information'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Chat History'),
                onTap: () {
                  _showHistoryDialog(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _getGreetingMessage(),
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AnnouncementPage()),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/announce.png',
                            width: 30,
                            height: 30,
                          ),
                          // Adjust the spacing between the image and text
                          Text(
                            'Announcements',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ], // Closing bracket for Stack children
            ), // Closing bracket for Stack
            // Wrap your Column with Flexible
            SizedBox(height: 20.0),
            Flexible(
              child: Column(
                children: [
                  if (isChatAssistVisible) ChatAssist(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _currentConversation.length,
                      itemBuilder: (context, index) => _currentConversation[index],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1.0),
            _buildTextComposer(),
          ],
        ),
      ),
    );
  }


  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        height: 70,
        color: Colors.white12,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isChatAssistVisible = false; // Hide chat_assist()
                  });
                },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),

                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Enter your text....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),


            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: () {
                // First, handle the _handleSubmitted function
                _handleSubmitted(_textController.text);

                // Then, set the state to hide chat_assist()
                setState(() {
                  isChatAssistVisible = false;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.mic, color: Colors.blue),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.blue),
              onPressed: () {
                _handleNewChat();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage userMessage = ChatMessage(
      text: text,
      isUserMessage: true,
    );

    setState(() {
      _currentConversation.add(userMessage);
    });
    _callMainAPI(text);

    _simulateChatbotResponse(text);
  }
  // Function to call the main API
  // Function to call the main API with a GET request
  void _callMainAPI(String userInput) async {
    // URL of the main API (assuming it's a POST request to "/model")
    String mainApiUrl = 'http://169.254.205.135:5000/model';

    try {
      // Make a POST request to the main API
      final http.Response response = await http.post(
        Uri.parse(mainApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'message': 'givem= me station names'}),
      );

      if (response.statusCode == 200) {
        // If the main API call is successful, you can process the response
        Map<String, dynamic> mainApiResponse = jsonDecode(response.body);

        // Handle the response (customize based on your API)
        String botResponse = mainApiResponse['response'];

        // Create a chatbot response
        ChatMessage botMessage = ChatMessage(
          text: botResponse,
          isUserMessage: false,
        );
        print(botMessage);
        setState(() {
          _currentConversation.add(botMessage);
        });
      } else {
        // Handle errors from the main API
        print('Error calling Main API: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception calling Main API: $e');
    }
  }



  void _simulateChatbotResponse(String userMessage) {
    // Simulate chatbot response after a brief delay (you can replace this with actual chatbot logic)
    Future.delayed(const Duration(seconds: 1), () {
      String response = 'Hello, I am Eva. How can I assist you gwgwg?';

      // Create a chatbot response
      ChatMessage botMessage = ChatMessage(
        text: response,
        isUserMessage: false,
      );

      setState(() {
        _currentConversation.add(botMessage);
      });

      // Simulate another response from the chatbot (you can add more logic here)
      Future.delayed(const Duration(seconds: 1), () {
        String anotherResponse = 'I can help you with various tasks. Just ask!';

        ChatMessage anotherBotMessage = ChatMessage(
          text: anotherResponse,
          isUserMessage: false,
        );

        setState(() {
          _currentConversation.add(anotherBotMessage);
        });
      });
    });
  }

  void _askPNRInformation() {
    String question = 'Sure, I can help you with PNR Status. Please enter your 10-digit PNR number.';

    ChatMessage message = ChatMessage(
      text: question,
      isUserMessage: false,
    );

    setState(() {
      _currentConversation.add(message);
    });
  }

  void _handleNewChat() {
    setState(() {
      _conversations.add(List<ChatMessage>.from(_currentConversation));
      _currentConversation.clear();
    });
  }

  void _handleChatHistory(int index) {
    setState(() {
      _currentConversation = List<ChatMessage>.from(_conversations[index]);
    });
  }

  String _getGreetingMessage() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  void _showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Chat History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildChatHistory(),
                  SizedBox(height: 16),
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatHistory() {
    return Column(
      children: List.generate(_conversations.length, (index) {
        return ListTile(
          title: Text('Chat $index'),
          onTap: () {
            Navigator.pop(context);
            _handleChatHistory(index);
          },
        );
      }),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isUserMessage ? SizedBox() : CircleAvatar(child: Icon(Icons.bubble_chart_sharp)),
          SizedBox(width: 5.0),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.lightBlueAccent : Colors.greenAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}

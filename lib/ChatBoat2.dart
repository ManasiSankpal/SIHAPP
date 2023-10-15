import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ChatbotScreen(),
  ));
}

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<List<ChatMessage>> _conversations = [];
  List<ChatMessage> _currentConversation = [];
  TextEditingController _textController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleSubmitted(String text) {
    _textController.clear();

    ChatMessage userMessage = ChatMessage(
      text: text,
      isUserMessage: true,
    );

    setState(() {
      _currentConversation.add(userMessage);
    });

    _simulateChatbotResponse(text);
  }

  void _simulateChatbotResponse(String userMessage) {
    // Simulate chatbot response after a brief delay (you can replace this with actual chatbot logic)
    Future.delayed(const Duration(seconds: 1), () {
      String response = 'Hello, I am Eva. How can I assist you?';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // Handle the back button press
          Navigator.of(context).pop();
          return true; // Return true to allow the back button press
    },

    child: Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Eva: Your Guide to Infinite Possibilities'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
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
                //Navigator.pop(context);
                // _showHistoryDialog(context);
                AppDrawer();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: false,
              itemCount: _currentConversation.length,
              itemBuilder: (context, index) => _currentConversation[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            color: Colors.grey[300],
            child: _buildTextComposer(),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        color: Colors.white38,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
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
            IconButton(
              icon: Icon(Icons.send, color: Colors.blue),
              onPressed: () => _handleSubmitted(_textController.text),
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

class AppDrawer extends StatelessWidget {
  //final VoidCallback handleNewChat;
  //final VoidCallback askPNRInformation;

  //AppDrawer({required this.handleNewChat, required this.askPNRInformation});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('New Chat11111'),
            onTap: () {
              // Navigator.pop(context);
              // handleNewChat();
            },
          ),
          ListTile(
            title: Text('PNR Status11111'),
            onTap: () {
              // Navigator.pop(context);
              // askPNRInformation();
            },
          ),
          ListTile(
            title: Text('Live Train Information1111'),
            onTap: () {
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Chat History'),
            onTap: () {
              //Navigator.pop(context);
              // Implement your logic for chat history here
            },
          ),
        ],
      ),
    );
  }
}
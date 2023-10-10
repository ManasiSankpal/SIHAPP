import 'package:flutter/material.dart';
import 'package:sihapp/HomeScreen.dart';

class ChatbotApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen2(),
    );
  }
}

class ChatScreen2 extends StatefulWidget {
  @override
  _ChatScreenState2 createState() => _ChatScreenState2();
}

class _ChatScreenState2 extends State<ChatScreen2> {
  List<ChatMessage> messages = [];

  void _handleUserMessage(String text) {
    // Process the user's message and generate a bot response.
    // For simplicity, let's echo the user's message.
    final userMessage = ChatMessage(
      text: text,
      sender: Sender.user,
    );

    setState(() {
      messages.add(userMessage);
    });

    // Simulate a bot response after a delay.
    Future.delayed(Duration(seconds: 1), () {
      final botMessage = ChatMessage(
        text: 'Hello, I am your chatbot!',
        sender: Sender.bot,
      );

      setState(() {
        messages.add(botMessage);
      });
    });
  }

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chatbot'),
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: messages[index]);
              },
            ),
          ),
          TextInputField(
            onMessageSubmitted: _handleUserMessage,
          ),
        ],
      ),
    ),);
  }
}

enum Sender { user, bot }

class ChatMessage {
  final Sender sender;
  final String text;

  ChatMessage({
    required this.sender,
    required this.text,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == Sender.user
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.sender == Sender.user ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class TextInputField extends StatefulWidget {
  final Function(String) onMessageSubmitted;

  TextInputField({required this.onMessageSubmitted});

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmit(String text) {
    if (text.isNotEmpty) {
      widget.onMessageSubmitted(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSubmit,
              decoration: InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _handleSubmit(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}

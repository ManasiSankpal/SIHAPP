import 'package:flutter/material.dart';
//import 'package:translator/translator.dart';

class TranslatorPage extends StatefulWidget {
  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _translatedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
                maxLines: null, // Set maxLines to null for multiline
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Enter text to translate',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _translateText();
                },
                child: Text('Translate'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Translated Text:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                _translatedText,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _translateText() async {
    //final translator = GoogleTranslator();
    // Translation translation = await translator.translate(_textEditingController.text, from: 'en', to: 'es');

    setState(() {
      // _translatedText = translation.text;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: TranslatorPage(),
  ));
}

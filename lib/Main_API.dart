import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> callMainAPI(String userInput) async {
  // URL of the main API
  String mainApiUrl = 'http://127.0.0.1:5000/';

  // Prepare the request body
  Map<String, String> requestBody = {'message': userInput};

  try {
    // Make a POST request to the main API
    final http.Response response = await http.post(
      Uri.parse(mainApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // If the main API call is successful, you can process the response
      Map<String, dynamic> mainApiResponse = jsonDecode(response.body);

      // Check if the main API triggered an additional API
      if (mainApiResponse['prediction_type'] == 'API Triggered') {
        // Extract additional information from the response
        String additionalApiUrl = 'http://your-additional-api-url';
        String additionalApiResponse =
        await callAdditionalAPI(mainApiResponse['user_input'], additionalApiUrl);

        // Process the additional API response
        print('Additional API Response: $additionalApiResponse');
      } else {
        // Handle the general-purpose response
        print('General Purpose Response: ${mainApiResponse['response']}');
      }
    } else {
      // Handle errors from the main API
      print('Error calling Main API: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception calling Main API: $e');
  }
}

Future<String> callAdditionalAPI(String user_input, String additionalApiUrl) async {
  // Prepare the request body
  Map<String, String> requestBody = {'message': user_input};

  try {
    // Make a POST request to the additional API
    final http.Response response = await http.post(
      Uri.parse(additionalApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // If the additional API call is successful, return the response
      return response.body;
    } else {
      // Handle errors from the additional API
      print('Error calling Additional API: ${response.statusCode}');
      return 'Additional API Error';
    }
  } catch (e) {
    // Handle exceptions
    print('Exception calling Additional API: $e');
    return 'Additional API Exception';
  }
}

void main() {
  callMainAPI('User Input from Flutter');
}

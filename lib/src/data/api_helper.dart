import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiHelper {
  Future<List<Map<String, dynamic>>> callAPI({
    required String apiUrl,
  }) async {
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var rawData =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        if (rawData.isEmpty) {
          throw Exception('No country found. Specify a valid field');
        }
        return rawData;
      } else if (response.statusCode == 400) {
        throw Exception(
            'Bad Request: You may have specified an unsupported field or invalid country data.');
      } else if (response.statusCode == 404) {
        throw Exception('Country not found');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error: ${response.statusCode}');
      } else {
        throw Exception('API error: ${response.statusCode} - ${response.body}');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on FormatException {
      throw Exception('Invalid response format');
    }
  }
}

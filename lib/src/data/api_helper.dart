import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiHelper {

static Future<List<Map<String, dynamic>>> callAPI({required String apiUrl})async {

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    else if (response.statusCode == 404) {
     throw Exception('Country not found');
    }
    throw Exception(response.body);
  }

}
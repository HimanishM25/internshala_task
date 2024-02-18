import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider {
  static Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://internshala.com/flutter_hiring/search'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

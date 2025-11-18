import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inspireme/api_service/Quote.dart';

class QuoteService {
  String baseurl = "https://api.api-ninjas.com/v1/quotes";

  getQuote() async {
    try {
      final response = await http.get(
        Uri.parse(baseurl),
        headers: {'X-Api-Key': '0Y08Df7ZmLbsK9MFLgQpWA==sSaiwxtaqGADHlY2'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data.map((item) => Quote.fromJson(item)).toList();
      }
      else{
        print("Error: ${response.statusCode}");
        return[];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart';
import 'package:quotes_app/model/quotes_model.dart';

class APICall {
  static fetchQuote() async {
    Quote res = Quote();
    var response = await get(Uri.parse("https://zenquotes.io/api/random"));
    if (response.statusCode == 200) {
      print(response.body.toString());
      var body = json.decode(response.body.toString())[0];
      print(body);
      final quote = quoteFromMap(response.body);
      res = quote[0];
    } else
      print(response.statusCode);
    return res;
  }
}

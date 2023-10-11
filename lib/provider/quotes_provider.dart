import 'package:flutter/material.dart';
import 'package:quotes_app/model/quotes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class quotesprovider extends ChangeNotifier {
  // List<Quote> quotes = [];
  dateModel datemodel = dateModel(datetime: DateTime.now());

  date() async {
    datemodel.dateTime =
    "${datemodel.datetime.day}/${datemodel.datetime.month}/${datemodel.datetime.year}     "
        "${datemodel.datetime.hour}:${datemodel.datetime.minute}";

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('dateTime', datemodel.dateTime!);
    notifyListeners();
  }

  bool isConnection = false;

  void connectionChange(bool connection) {
    isConnection = connection;
    notifyListeners();
  }

  //
  // Future<void> fetchAllQuotes() async {
  //   // Fetch quotes from shared preferences
  //   final prefs = await SharedPreferences.getInstance();
  //   quotes = quoteFromMap(prefs.getString("quotes") ?? '[]');
  //   notifyListeners();
  // }
  //
  // Future<void> addQuote(Quote quote) async {
  //   quotes.add(quote);
  //   // Save the updated quotes to shared preferences
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('quotes', quoteToMap(quotes));
  //   notifyListeners();
  // }
}


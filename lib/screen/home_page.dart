import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/helper/api.dart';
import 'package:quotes_app/model/quotes_model.dart';
import 'package:quotes_app/provider/theme_provider.dart';
import 'package:quotes_app/screen/save.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  List<Quote> quotes = [];
  late SharedPreferences prefs;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    fetchAllQuotes();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);

    // Provider.of<QuotesProvider>(context, listen: false).fetchAllQuotes();
  }

  fetchAllQuotes() async {
    prefs = await SharedPreferences.getInstance();
    quotes = quoteFromMap(prefs.getString("quotes") ?? '[]');
    // json.decode(prefs.getString("quotes") ?? '[]');
    print(quotes);
    setState(() {});
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text("Random Quotes"),
        actions: [
          Switch(
            value: Provider.of<ThemeProvider>(context).themeModel.isDark,
            onChanged: (val) {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 90,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: _height * 0.6,
              width: _width / 2,
              child: Card(
                margin: const EdgeInsets.only(top: 20),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quotes.isNotEmpty ? quotes.last.q! : 'No Quotes found',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 22),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            quotes.isNotEmpty ? quotes.last.a! : 'No author',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              var resp = await APICall.fetchQuote();
                              quotes.add(resp);

                              await prefs.setString(
                                  'quotes', quoteToMap(quotes));
                              setState(() {});
                            },
                            child: const Text('Fetch New '),
                          ),
                          // ElevatedButton(
                          //   onPressed: () async {
                          //     var resp = await APICall.fetchQuote();
                          //     Provider.of<QuotesProvider>(context, listen: false).addQuote(resp);
                          //   },
                          //   child: const Text('Fetch New '),
                          // ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ViewPage(quotes: quotes),
                                  ),
                                );
                              },
                              child: Text('View all quotes'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
            Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'package:flutter/material.dart';
import 'package:quotes_app/model/quotes_model.dart';


class ViewPage extends StatelessWidget {
  ViewPage({required this.quotes, super.key}) ;
  List<Quote> quotes;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    return Scaffold(
      appBar: AppBar(title: Text('All Quotes')),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) =>Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: _height * 0.3,
          width: _width / 2,
          child: Card(
            margin: const EdgeInsets.only(top: 20),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(quotes.isNotEmpty ? quotes[index].q! : 'No Quotes found',textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 22),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Text(quotes.isNotEmpty ?quotes[index].a! : 'No author',textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.purple,

                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),)),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}

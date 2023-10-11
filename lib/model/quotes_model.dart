

import 'dart:convert';

List<Quote> quoteFromMap(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromMap(x)));

String quoteToMap(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Quote {
  String? q;
  String? a;
  String? h;

  Quote({
    this.q,
    this.a,
    this.h,
  });

  factory Quote.fromMap(Map<String, dynamic> json) => Quote(
    q: json["q"],
    a: json["a"],
    h: json["h"],
  );

  Map<String, dynamic> toMap() => {
    "q": q,
    "a": a,
    "h": h,
  };
}


class dateModel {
  DateTime datetime;
  String? dateTime;

  dateModel({
    required this.datetime,
  });
}

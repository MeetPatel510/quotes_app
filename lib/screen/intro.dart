import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the cached_network_image package

class IntroPae extends StatefulWidget {
  const IntroPae({Key? key}) : super(key: key);

  @override
  State<IntroPae> createState() => _IntroPaeState();
}

class _IntroPaeState extends State<IntroPae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: " The Random Quotes in App",
            body: "Give me a good script, and I’ll be a hundred times better as a director",
            image: CachedNetworkImage( // Use CachedNetworkImage to load and cache the image
              imageUrl: "https://blogimage.vantagefit.io/vfitimages/2022/08/positiveenergyquotes.b.jpg",
              placeholder: (context, url) => CircularProgressIndicator(), // Placeholder while the image is loading
              errorWidget: (context, url, error) => Icon(Icons.error), // Widget to display if there's an error loading the image
              fit: BoxFit.cover,
            ),
          ),
          PageViewModel(
            title: " The Random Quotes in App",
            body: "Give me a good script, and I’ll be a hundred times better as a director",
            image: CachedNetworkImage( // Use CachedNetworkImage to load and cache the image
              imageUrl: "https://www.invajy.com/wp-content/uploads/2019/12/Short-Quotes-3.jpg",
              placeholder: (context, url) => CircularProgressIndicator(), // Placeholder while the image is loading
              errorWidget: (context, url, error) => Icon(Icons.error), // Widget to display if there's an error loading the image
              fit: BoxFit.cover,
            ),
          ),
        ],
        done: Text("done"),
        onDone: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool("isIntroVisited", true);
          Navigator.pushReplacementNamed(context, 'Quote');
        },
        next: Text("Next"),
        showNextButton: true,
      ),
    );
  }
}



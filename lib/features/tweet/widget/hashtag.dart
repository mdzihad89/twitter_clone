import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class HashTag extends StatelessWidget {
  final String text;

  const HashTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpan = [];
    text.split(" ").forEach((element) {
      if (element.startsWith("#")) {
        textSpan.add(TextSpan(
            text: "$element ",
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )));
      } else if (element.startsWith("www.") || element.startsWith("https://")) {
        textSpan.add(TextSpan(
            text: "$element ",
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
            )));
      } else {
        textSpan.add(TextSpan(
            text: "$element ",
            style: const TextStyle(
              fontSize: 18,
            )));
      }
    });

    return RichText(
      text: TextSpan(children: textSpan),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/theme/pallete.dart';

class TweetIconButton extends StatelessWidget {
  final String path;
  final String text;
  final VoidCallback onTap;
  const TweetIconButton({Key? key, required this.path, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        children: [
          SvgPicture.asset(path,color: Pallete.greyColor,),
          Container(
            margin: const EdgeInsets.all(6),
            child: Text(text,style: const TextStyle(
              fontSize: 16
            ),),
          )
        ],
      ),
    );
  }
}

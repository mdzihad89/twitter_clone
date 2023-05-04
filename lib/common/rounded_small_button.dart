import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class RoundedSmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  const RoundedSmallButton({Key? key, required this.label, required this.onTap,   this.backgroundColor=Pallete.whiteColor,  this.textColor=Pallete.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
          label: Text(label,style: TextStyle(color: textColor),),
        backgroundColor: backgroundColor,

        labelPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
      ),
    );
  }
}

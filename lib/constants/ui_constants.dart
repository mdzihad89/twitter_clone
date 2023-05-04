import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/features/home/home_view.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_list.dart';
import 'package:twitter_clone/theme/theme.dart';
import '../features/explore/view/explore_view.dart';
import '../features/notification/view/notification_view.dart';
import 'assets_constants.dart';

class UIConstants{

  static  AppBar appBar(){
    return AppBar(
      title:  SvgPicture.asset(
          AssetsConstants.twitterLogo,
          color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    // HomeView(),
    // ExploreView(),
    // NotificationView(),
    TweetList(),
    Text("Explore"),
    Text("Notification"),
  ];

}
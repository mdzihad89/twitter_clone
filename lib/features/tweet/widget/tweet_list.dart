import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/common/error_page.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_card.dart';

import '../../../constants/appwrite_constants.dart';
import '../../../model/tweet_model.dart';

class TweetList extends ConsumerWidget {
  const TweetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
          data: (tweets) {
            return ref.watch(getLatestTweetProvider).when(
              data: (data) {
                if (data.events.contains(
                    'databases.*.collections.${AppwriteConstants.tweetCollection}.documents.*.create')) {
                  tweets.insert(0, Tweet.fromMap(data.payload));
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tweet = tweets[index];
                    return TweetCard(tweet: tweet);
                  },
                  itemCount: tweets.length,
                );
              },
              error: (e, stkTrace) {
                return ErrorText(error: e.toString());
              },
              loading: () {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tweet = tweets[index];
                    return TweetCard(tweet: tweet);
                  },
                  itemCount: tweets.length,
                );
              },
            );
          },
          error: (e, stkTrace) {
            return ErrorText(error: e.toString());
          },
          loading: () => const Loader(),
        );
  }
}

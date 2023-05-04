import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../controller/tweet_controller.dart';

class TweetList extends ConsumerWidget {
  const TweetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
      data: (tweets) {
        return Center(child: Text(tweets.length.toString()));


      },
      error: (error, stackTrace) => ErrorText(
        error: error.toString(),
      ),
      loading: () => const Loader(),
    );
  }
}

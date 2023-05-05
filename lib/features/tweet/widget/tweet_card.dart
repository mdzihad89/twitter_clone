import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/enum/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/widget/hashtag.dart';
import 'package:twitter_clone/features/tweet/widget/tweet_icon_button.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../common/error_page.dart';
import '../../../common/loading_page.dart';
import '../../../model/tweet_model.dart';
import 'carousel_image.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;

  const TweetCard({
    required this.tweet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
          data: (user) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 35,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //retweet
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: Text(
                                  user.name.toLowerCase(),
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "@${user.name} . ${timeago.format(tweet.tweetedAt, locale: 'en_short')}",
                                style: const TextStyle(
                                    fontSize: 17, color: Pallete.greyColor),
                              ),
                            ],
                          ),
                          //replied to
                          HashTag(
                            text: tweet.text,
                          ),
                          if (tweet.link.isNotEmpty) ...[
                            const SizedBox(
                              height: 4,
                            ),
                            tweet.imageLinks.isEmpty
                                ? tweet.link.startsWith("w")
                                    ? AnyLinkPreview(
                                        link: "https://${tweet.link.trim()}",
                                        previewHeight: 150,
                                        displayDirection:
                                            UIDirection.uiDirectionHorizontal,
                                        backgroundColor: Colors.black,
                                        errorBody: "404 Not Found",
                                        errorTitle: "404 Not Found",
                                        errorWidget:
                                            const Text("404 Not Found"),
                                      )
                                    : AnyLinkPreview(
                                        displayDirection:
                                            UIDirection.uiDirectionHorizontal,
                                        link: tweet.link.trim(),
                                        backgroundColor: Colors.black,
                                        previewHeight: 150,
                                        errorBody: "404 Not Found",
                                        errorTitle: "404 Not Found",
                                        errorWidget: const SizedBox())
                                : const SizedBox(),
                            // AnyLinkPreview(link:tweet.link.trim())
                          ],
                          if (tweet.tweetType == TweetType.image)
                            CarouselImage(
                              imageLinks: tweet.imageLinks,
                            ),

                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TweetIconButton(
                                  onTap: () {},
                                  path: AssetsConstants.viewsIcon,
                                  text: "0",
                                ),
                                TweetIconButton(
                                  onTap: () {},
                                  path: AssetsConstants.commentIcon,
                                  text: tweet.commentIds.length.toString(),
                                ),
                                TweetIconButton(
                                  onTap: () {},
                                  path: AssetsConstants.retweetIcon,
                                  text: tweet.reshareCount.toString(),
                                ),

                                LikeButton(
                                  likeCount: tweet.likes.length,
                                  countBuilder: (likeCount, isLiked, text) {
                                    return Text(text,style: TextStyle(
                                      color:isLiked? Pallete.redColor:Pallete.greyColor
                                    ),);
                                  },
                                  size: 25,
                                  likeBuilder: (isLiked) {
                                    return isLiked
                                        ? SvgPicture.asset(
                                            AssetsConstants.likeFilledIcon,
                                            color: Pallete.redColor,
                                          )
                                        : SvgPicture.asset(
                                        color: Pallete.greyColor,
                                            AssetsConstants.likeOutlinedIcon);
                                  },
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    size: 20,
                                    color: Pallete.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Pallete.greyColor,
                )
              ],
            );
          },
          error: (e, stkTrace) {
            return ErrorText(error: e.toString());
          },
          loading: () => const Loader(),
        );
  }
}

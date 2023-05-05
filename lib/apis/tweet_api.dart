import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/typedef.dart';
import '../constants/appwrite_constants.dart';
import '../core/failure.dart';
import '../model/tweet_model.dart';

final tweetAPIProvider = Provider((ref) {
  return TweetAPI(
    databases: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class ITweetAPI {
  FutureEither<Document> shareTweet(Tweet tweet);
  FutureEither<Document> likeTweet(Tweet tweet);
  Future<List<Document>> getTweets();


  Stream<RealtimeMessage> getLatestTweet();
}

class TweetAPI implements ITweetAPI {
  final Databases _databases;
  final Realtime _realtime;

  TweetAPI({
    required Databases databases,
    required Realtime realtime,
  })  : _databases = databases,
        _realtime = realtime;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.tweetCollection,
        documentId: ID.unique(),
        data: tweet.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getTweets() async {
    final documents = await _databases.listDocuments(
      databaseId: AppwriteConstants.databaseID,
      collectionId: AppwriteConstants.tweetCollection,
      queries: [Query.orderDesc('tweetedAt')]
    );
    return documents.documents;
  }

  @override
  Stream<RealtimeMessage> getLatestTweet() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseID}.collections.${AppwriteConstants.tweetCollection}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> likeTweet(Tweet tweet) async{

    try {
      final document = await _databases.updateDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.tweetCollection,
        documentId: tweet.id,
        data: {
          'likes':tweet.likes
        },
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }


  }
}

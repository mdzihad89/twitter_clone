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
  return TweetAPI(databases: ref.watch(appwriteDatabaseProvider));
});

abstract class ITweetAPI{
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweets();
}

class TweetAPI implements ITweetAPI{

  final Databases _databases;

  TweetAPI({required Databases databases}) : _databases = databases;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async{
    try {
     final document= await _databases.createDocument(
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
  Future<List<Document>> getTweets()async {
    final documents= await _databases.listDocuments(databaseId: AppwriteConstants.databaseID, collectionId: AppwriteConstants.tweetCollection);
    return documents.documents;
  }

}
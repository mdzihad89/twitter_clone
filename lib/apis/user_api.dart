import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/typedef.dart';
import 'package:twitter_clone/model/user_model.dart';


final userAPIProvider = Provider((ref) {
  return UserAPI(databases: ref.watch(appwriteDatabaseProvider));
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData( String uid);
}

class UserAPI implements IUserAPI {
  final Databases _databases;

  UserAPI({required Databases databases}) : _databases = databases;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _databases.createDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.userCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
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
  Future<model.Document> getUserData(String uid) {

    return _databases.getDocument(
        databaseId: AppwriteConstants.databaseID,
        collectionId: AppwriteConstants.userCollection,
        documentId: uid,
    );


  }
}
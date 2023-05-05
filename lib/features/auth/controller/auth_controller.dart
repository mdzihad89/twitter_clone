import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/extension.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/home/home_view.dart';
import 'package:twitter_clone/model/user_model.dart';
import '../../../apis/auth_api.dart';
import 'package:appwrite/models.dart' as model;
import '../../../apis/user_api.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserAccountProvider = FutureProvider((ref) async {
  return ref.watch(authControllerProvider.notifier).currentUser();
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  return userDetails.value;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;


  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  void signUp({
    required String name,
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(name: name, email: email, pass: pass);
    state = false;
    res.fold((l) {
      showSnackBar(context, l.msg);
    }, (r) async {
      UserModel userModel = UserModel(
        name: name,
        email: email,
        following: [],
        followers: [],
        profilePic: "",
        bannerPic: "",
        uid: r.$id,
        bio: "",
        isTwitterBlue: false,
      );
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.msg), (r) {
        showSnackBar(context, 'Accounted created! Please login.');
        context.pushReplacement(const LoginView());
      });
    },
    );
  }
  void login({
    required String email,
    required String pass,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(email: email, pass: pass);
    state = false;

    res.fold((l) {
      showSnackBar(context, l.msg);
    }, (r) {
      context.pushReplacement(const HomeView());
    });
  }

  void logOut(BuildContext context) async {
    final res = await _authAPI.logOut();
    res.fold((l) {
      return null;
    }, (r) {
      context.pushAndRemoveUntil(const LoginView());
    });
  }

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }
}

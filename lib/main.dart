import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/error_page.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/views/login_view.dart';
import 'package:twitter_clone/features/home/home_view.dart';
import 'package:twitter_clone/theme/app_theme.dart';
import 'common/loading_page.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Twitter Clone',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
              data: (user){
                if(user!=null){
                  return const HomeView();
                }
                return const LoginView();

              },
              error: (error, stackTrace){
                ErrorPage(error: error.toString(),);
              },
              loading: ()=> const LoadingPage(),
            ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sedigram/auth/application/auth_bloc.dart';
import 'package:sedigram/auth/application/auth_event.dart';
import 'package:sedigram/core/data/fire_storage.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/create_post/presentation/create_post_screen.dart';
import 'package:sedigram/edit_profile/application/edit_profile_bloc.dart';
import 'package:sedigram/edit_profile/application/edit_profile_event.dart';
import 'package:sedigram/edit_profile/presentation/edit_profile_screen.dart';
import 'package:sedigram/firebase_options.dart';
import 'package:sedigram/home/application/home_bloc.dart';
import 'package:sedigram/home/presentation/home_screen.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
import 'package:sedigram/post_detail/application/post_detail_bloc.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/presentation/post_detail_screen.dart';
import 'package:sedigram/post_detail/presentation/post_detail_screen_arguments.dart';
import 'package:sedigram/save_post/application/save_post_bloc.dart';
import 'package:sedigram/save_post/presentation/save_post_screen.dart';
import 'package:sedigram/sign_up/presentation/sign_up_screen.dart';
import 'package:sedigram/splash/presentation/splash_screen.dart';
import 'package:sedigram/theme/presentation/color_scheme.dart';
import 'package:sedigram/theme/presentation/text_theme.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:sedigram/user/application/global_user_event.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuth.instance, GoogleSignIn())
            ..add(CheckLoginEvent()),
        ),
        BlocProvider<GlobalUserBloc>(
          create: (context) => GlobalUserBloc()
            ..add(
              GlobalUserUpdateEvent(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          LoginScreen.routeNamed: (context) => const LoginScreen(),
          SignUpScreen.routeNamed: (context) => const SignUpScreen(),
          HomeScreen.routeNamed: (context) => BlocProvider(
                create: (_) {
                  return HomeBloc();
                },
                child: const HomeScreen(),
              ),
          SplashScreen.routeNamed: (context) => const SplashScreen(),
          CreatePostScreen.routeNamed: (context) => const CreatePostScreen(),
          SavePostScreen.routeNamed: (context) {
            final path = ModalRoute.of(context)!.settings.arguments as String?;

            return BlocProvider(
              child: SavePostScreen(
                imagePath: path!,
              ),
              create: (context) => SavePostBloc(
                FirebaseAuth.instance,
                FireStorage(FirebaseStorage.instance),
                const Uuid(),
                FirestoreService(
                  FirebaseFirestore.instance,
                ),
              ),
            );
          },
          EditProfileScreen.routeNamed: (context) => BlocProvider(
                child: const EditProfileScreen(),
                create: (context) => EditProfileBloc(
                  FirebaseAuth.instance,
                  FirestoreService(FirebaseFirestore.instance),
                )..add(EditProfileInitEvent()),
              ),
          PostDetailScreen.routeNamed: (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as PostDetailScreenArguments?;

            return BlocProvider(
              create: (context) {
                return PostDetailBloc(
                  firebaseAuth: FirebaseAuth.instance,
                  firestoreService:
                      FirestoreService(FirebaseFirestore.instance),
                )..add(PostDetailInitEvent(posts: args.posts));
              },
              child: PostDetailScreen(
                postIndex: args!.postIndex,
              ),
            );
          },
        },
        theme: ThemeData(
          textTheme: textTheme,
          colorScheme: colorScheme,
          fontFamily: 'SFPro',
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        home: const SplashScreen(),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
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
import 'package:sedigram/core/domain/user_info.dart';
import 'package:sedigram/create_post/application/create_post_bloc.dart';
import 'package:sedigram/create_post/application/create_post_event.dart';
import 'package:sedigram/create_post/presentation/create_post_screen.dart';
import 'package:sedigram/edit_profile/application/edit_profile_bloc.dart';
import 'package:sedigram/edit_profile/application/edit_profile_event.dart';
import 'package:sedigram/edit_profile/presentation/edit_profile_screen.dart';
import 'package:sedigram/firebase_options.dart';
import 'package:sedigram/follow/application/follow_bloc.dart';
import 'package:sedigram/follow/application/follow_event.dart';
import 'package:sedigram/follow/presentation/follow_screen.dart';
import 'package:sedigram/home/application/home_bloc.dart';
import 'package:sedigram/home/presentation/home_screen.dart';
import 'package:sedigram/login/presentation/login_screen.dart';
import 'package:sedigram/post_detail/application/post_detail_bloc.dart';
import 'package:sedigram/post_detail/application/post_detail_event.dart';
import 'package:sedigram/post_detail/presentation/post_detail_screen.dart';
import 'package:sedigram/post_detail/presentation/post_detail_screen_arguments.dart';
import 'package:sedigram/profile/application/profile_bloc.dart';
import 'package:sedigram/profile/application/profile_event.dart';
import 'package:sedigram/profile/presentation/profile_screen.dart';
import 'package:sedigram/profile_photo/application/profile_photo_bloc.dart';
import 'package:sedigram/profile_photo/presentation/profile_photo_screen.dart';
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
          create: (context) => AuthBloc(
            FirebaseAuth.instance,
            GoogleSignIn(),
            GlobalUserBloc(),
          )..add(CheckLoginEvent()),
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
          CreatePostScreen.routeNamed: (context) {
            return BlocProvider(
              create: (context) {
                return CreatePostBloc()..add(GetImagesEvent());
              },
              child: const CreatePostScreen(nextPage: NextPage.profilePhoto),
            );
          },
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
                GlobalUserBloc(),
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
                  globalUserBloc: GlobalUserBloc(),
                )..add(PostDetailInitEvent(posts: args.posts));
              },
              child: PostDetailScreen(
                postIndex: args!.postIndex,
                userName: args.userName,
              ),
            );
          },
          ProfileScreen.routeNamed: (context) {
            final userId =
                ModalRoute.of(context)!.settings.arguments as String?;

            return BlocProvider(
              create: (context) {
                return ProfileBloc(
                  FirebaseAuth.instance,
                  FirestoreService(FirebaseFirestore.instance),
                  GlobalUserBloc(),
                )..add(ProfileInitEvent(userId: userId));
              },
              child: ProfileScreen(
                userId: userId!,
              ),
            );
          },
          FollowScreen.routeNamed: (context) {
            final userInfo =
                ModalRoute.of(context)!.settings.arguments as UserInfo?;

            return BlocProvider(
              create: (context) {
                return FollowBloc(
                  firestoreService: FirestoreService(
                    FirebaseFirestore.instance,
                  ),
                )..add(FollowInitEvent(userInfo: userInfo!));
              },
              child: const FollowScreen(),
            );
          },
          ProfilePhotoScreen.routeNamed: (context) {
            final imagePath =
                ModalRoute.of(context)!.settings.arguments as String?;

            return BlocProvider(
              create: (context) {
                return ProfilePhotoBloc(
                  fireStoreService:
                      FirestoreService(FirebaseFirestore.instance),
                  globalUserBloc: GlobalUserBloc(),
                  uuid: const Uuid(),
                  fireStorage: FireStorage(FirebaseStorage.instance),
                );
              },
              child: ProfilePhotoScreen(imagePath: imagePath!),
            );
          }
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

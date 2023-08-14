import 'package:online_learning_app/bloc/course/category/add_category/add_category_bloc.dart';
import 'package:online_learning_app/bloc/course/video/get_video_by_id/get_video_by_id_bloc.dart';
import 'package:online_learning_app/bloc/user/delete_user/delete_user_bloc.dart';
import 'package:online_learning_app/screens/admin/add_category_screen.dart';
import 'package:online_learning_app/screens/user/user_edit_profile_screen.dart';

import 'bloc/course/join_course/join_bloc.dart';
import 'bloc/course/video/add_video/add_video_bloc.dart';
import 'bloc/course/video/get_video_by_course_id_and_author_id/get_video_by_course_id_and_author_id_bloc.dart';
import 'export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => CheckLoginBloc(),
        ),
        BlocProvider(
          create: (context) => AddCourseBloc(),
        ),
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => GetCourseByIdBloc(),
        ),
        BlocProvider(
          create: (context) => GetCourseBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserBloc(),
        ),
        BlocProvider(
          create: (context) => JoinBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserJoinedCourseBloc(),
        ),
        BlocProvider(
          create: (context) => SearchCourseBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteCourseBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteVideoBloc(),
        ),
        BlocProvider(
          create: (context) => AddVideoBloc(),
        ),
        BlocProvider(
          create: (context) => GetVideoByCourseIdAndAuthorIdBloc(),
        ),
        BlocProvider(
          create: (context) => AddCategoryBloc(),
        ),
        BlocProvider(
          create: (context) => GetVideoByIdBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteUserBloc(),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      // home: VideoPlayer(),
      initialRoute: '/',
      onGenerateRoute: routes,
    );
    //   routes: {
    //     '/': (context) => const SplashScreen(),
    //     '/auth': (context) => AuthScreen(),
    //     //User Route
    //     '/main': (context) => const BottomNavBar(arguments: {}),
    //     '/settings': (context) => SettingsScreen(arguments: const {}),
    //     '/profil': (context) => const ProfileScreen(),
    //     '/detail-course': (context) => const DetailCourseScreen(),
    //     //Lecturer Route
    //     '/author-main': (context) => const AuthorHomeScreen(arguments: {}),
    //     '/lecturer-main': (context) => const LecturerHomeScreen(arguments: {}),
    //     '/lecturer-detail': (context) => const LecturerDetailCourse(),
    //     '/add-video': (context) => const LecturerAddVideoScreen(),
    //     '/add-course': (context) => const AddCourseScreen(),
    //     //Admin Route
    //     '/add-lecturer': (context) => const AddLecturerScreen(),
    //     '/add-category': (context) => const AddCategoryScreen(),
    //     '/admin-main': (context) => const AdminHomeScreen(arguments: {}),
    //     '/all-data': (context) => const AllDataScreen(),
    //   },
    // );
    // }
  }

  Route<dynamic>? routes(RouteSettings settings) {
    print('build route for ${settings.name}');
    var routes = <String, WidgetBuilder>{
      '/': (context) => const SplashScreen(),
      '/auth': (context) => AuthScreen(),
      //User Route
      '/main': (context) => const BottomNavBar(arguments: {}),
      '/settings': (context) => SettingsScreen(arguments: const {}),
      '/profil': (context) => const ProfileScreen(),
      '/detail-course': (context) => DetailCourseScreen(args: settings.arguments),
      '/detail-video': (context) => VideoPlayer(args: settings.arguments),
      '/edit-profile': (context) => const EditProfileScreen(),
      //Lecturer Route
      '/author-main': (context) => const AuthorHomeScreen(arguments: {}),
      '/lecturer-main': (context) => const LecturerHomeScreen(arguments: {}),
      '/lecturer-detail': (context) => LecturerDetailCourse(args: settings.arguments),
      '/add-video': (context) => LecturerAddVideoScreen(args: settings.arguments),
      '/add-course': (context) => const AddCourseScreen(),
      //Admin Route
      '/add-lecturer': (context) => const AddLecturerScreen(),
      '/add-category': (context) => const AddCategoryScreen(),
      '/admin-main': (context) => const AdminHomeScreen(arguments: {}),
      '/all-data': (context) => const AllDataScreen(),
    };
    WidgetBuilder? builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: (context) => builder(context));
    } else {
      return null;
    }
  }
}

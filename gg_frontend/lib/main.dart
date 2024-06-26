import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gg_frontend/frame/cookie_banner.dart';
import 'package:gg_frontend/frame/footer.dart';
import 'package:gg_frontend/frame/frame_pages/about_us.dart';
import 'package:gg_frontend/frame/frame_pages/datenschutz.dart';
import 'package:gg_frontend/frame/frame_pages/impressum.dart';
import 'package:gg_frontend/frame/header.dart';
import 'package:gg_frontend/global_stuff/DB_User.dart';
import 'package:gg_frontend/global_stuff/backend_com.dart';
import 'package:gg_frontend/global_stuff/global_variables.dart';
import 'package:gg_frontend/pages/game.dart';
import 'package:gg_frontend/pages/homepage.dart';
import 'package:gg_frontend/frame/frame_pages/how_to_userdata.dart';
import 'package:gg_frontend/pages/login.dart';
import 'package:gg_frontend/pages/profile.dart';
import 'package:gg_frontend/pages/register.dart';
import 'package:gg_frontend/pages/result.dart';
import 'package:gg_frontend/pages/game_settings.dart';
import 'package:gg_frontend/pages/splash_screen.dart';
import 'package:gg_frontend/router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDR89Kk5nK1S7IZ_z4_GrmqvqyTyXx455g",
          appId: "1:113329104078:web:f1fa602866d501e1d5dc9f",
          messagingSenderId: "113329104078",
          projectId: "geoguesser-bccbe"));
  FirebaseFirestore.instance; // init firestore
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeographicGame',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: false),
      initialRoute: Homepage.route, //Splash_screen.route,
      onGenerateRoute: generateRoute,
    );
  }
}

class Main extends StatefulWidget {
  static const String route = '/';
  var arguments;
  Main({this.arguments});

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  void _check_user(User? user) async {
    //print(user);
    if (user == null && global_usertype == Usertype.user) {
      global_usertype = Usertype.visitor;
      global_userdata = DB_User();
      global_rebuild_controller.add(true);
    }
    if (user != null && global_usertype == Usertype.visitor) {
      global_usertype = Usertype.user;
      global_userdata = await Backend_Com().get_user();
      global_rebuild_controller.add(true);
    }
  }

  @override
  void initState() {
    auth_firebase.authStateChanges().listen((User? user) async {
      _check_user(user);
    });
    if (auth_firebase.currentUser != null) {
      _check_user(auth_firebase.currentUser!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Background(),
          Column(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  SizedBox(
                      width: _screen_size.width,
                      child: get_main_widget(widget.arguments)),
                  Header(),
                ],
              )),
              Footer()
            ],
          ),
          Align(
            child: Cookie_Banner(),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }
}

Widget get_main_widget(var arguments) {
  switch (global_active_route) {
    case Main.route:
      return Container();
    case Splash_screen.route:
      return Splash_screen();
    case Homepage.route:
      return Homepage();
    case Game_Settings.route:
      return Game_Settings();
    case Profile.route:
      return Profile();
    case Login.route:
      return Login();
    case Register.route:
      return Register();
    case Game.route:
      return Game();
    case Result.route:
      return Result(
        arguments: arguments,
      );
    case About_Us.route:
      return About_Us();
    case Datenschutz.route:
      return Datenschutz();
    case Impressum.route:
      return Impressum();
    case HowToUserdata.route:
      return HowToUserdata();
    default:
      return Homepage();
  }
}

class Background extends StatefulWidget {
  const Background({Key? key}) : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    Size _screen_size = MediaQuery.of(context).size;
    return Container(
      width: _screen_size.width,
      height: _screen_size.height,
      color: global_color_1.withOpacity(0.15),
      child: Opacity(
        opacity: 0.2,
        child: Image.asset(
          "assets/images/gg_background.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

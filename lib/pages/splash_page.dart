import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Packages
import 'package:get_it/get_it.dart';
import 'package:movie_haven/services/movie_service.dart';

// Services
import '../services/http_service.dart';
import '../services/movie_service.dart';

//Model
import '../models/app_config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    Key? key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then(
      (_) => _setup(context).then(
        (_) => widget.onInitializationComplete(),
      ),
    );
  }

  Future<void> _setup(BuildContext _context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
        BASE_API_URL: configData["BASE_API_URL"],
        BASE_IMAGE_API_URL: configData["BASE_IMAGE_API_URL"],
        API_KEY: configData["API_KEY"],
      ),
    );
    getIt.registerSingleton<HTTPService>(
      HTTPService(),
    );
    getIt.registerSingleton<MovieService>(
      MovieService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie Haven",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        // child: Text("Movie Haven"),
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/tmdb.png"),
            ),
          ),
        ),
      ),
    );
  }
}

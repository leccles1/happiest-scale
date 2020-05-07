import 'package:body_composition/core/constants/app_constants.dart';
import 'package:body_composition/core/models/screen_args.dart';
import 'package:body_composition/main.dart';
import 'package:body_composition/ui/widgets/screens/entry_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.EditEntry:
        ScreenArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EntryScreen(
                  editMeasurement: args.editMeasurement,
                  dbService: args.dbService,
                ));
                
      case RoutePaths.NewEntry:
        ScreenArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EntryScreen(
                  dbService: args.dbService,
                ));

      case RoutePaths.Home:
        return MaterialPageRoute(
            builder: (_) => MyHomePage(
                  title: 'Happiest Scale',
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text("No route defined for ${settings.name}"),
                  ),
                ));
    }
  }
}

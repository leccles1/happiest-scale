import 'package:body_composition/core/constants/app_constants.dart';
import 'package:body_composition/core/models/measurement_model.dart';
import 'package:body_composition/ui/widgets/screens/logbook_screen.dart';
import 'package:body_composition/ui/widgets/screens/entry_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.EditEntry:
        Measurement editMeasurement = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EntryScreen(editMeasurement: editMeasurement));

      case RoutePaths.NewEntry:
        return MaterialPageRoute(builder: (_) => EntryScreen());

      case RoutePaths.Home:
        return MaterialPageRoute(
            builder: (_) => LogbookScreen(
                  title: 'Rachel',
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

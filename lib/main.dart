import 'package:body_composition/core/constants/app_constants.dart';
import 'package:body_composition/ui/viewmodels/measurement_viewmodel.dart';
import 'package:body_composition/ui/widgets/router.dart';
import 'package:flutter/material.dart';
import 'package:body_composition/core/services/database_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          //Inject DB service to MeasurementViewModel
          MeasurementViewModel(databaseService: DatabaseService.instance),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.Home,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

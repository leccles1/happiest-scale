import 'package:body_composition/core/constants/app_constants.dart';
import 'package:body_composition/core/models/measurement_model.dart';
import 'package:body_composition/core/models/screen_args.dart';
import 'package:body_composition/ui/widgets/measurement_entry.dart';
import 'package:body_composition/ui/widgets/router.dart';
import 'package:flutter/material.dart';
import 'package:body_composition/core/services/database_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // routes: {
      //   '/new': (_) => EntryScreen(),
      //   '/edit': (_) => EntryScreen(),
      //   '/': (_) => MyHomePage(title: 'Happiest Scale')
      // },
      initialRoute: RoutePaths.Home,
      onGenerateRoute: Router.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Initialise DB service
  final DatabaseService dbService = DatabaseService();

  List<Measurement> _measurements = [];

  @override
  void initState() {
    super.initState();
    // Open DB connection
    dbService.initialiseDatabase().then(
        (dbs) => dbs.fetchMeasurements().then((measurements) => setState(() {
              _measurements = measurements;
            })));
  }

  void _addMeasurement() {
    //TODO: Update to use provider to inject dbserivce
    Navigator.of(context)
        .pushNamed('/new', arguments: ScreenArgs(dbService: dbService));
  }

  void measurementEntryTap(int id) {
    //TODO: Update to use provider to inject dbserivce
    dbService.fetchMeasurement(id).then((entry) {
      Navigator.of(context).pushNamed('/edit',
          arguments: ScreenArgs(editMeasurement: entry, dbService: dbService));
    });
  }

  void _measurementDelete(Measurement measurement, int index) {
    setState(() {
      dbService.deleteMeasurement(measurement.id);
      _measurements.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: _measurements.length > 0
              ? ListView.builder(
                  itemCount: _measurements.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      confirmDismiss: (direction) async {
                        if(direction == DismissDirection.endToStart) {
                          _measurementDelete(_measurements[index], index);
                          return true;
                        } else {
                          print('un-recognised swipe');
                          return false;
                        }
                      },
                      key: Key(index.toString()),
                      background: Container(
                        alignment: Alignment(0.9, 0.0),
                        child: Text(
                          'Delete',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),
                        ),
                        color: Colors.red,
                      ),
                      child: MeasurementEntry(
                        measurementEntry: _measurements[index],
                        tapCallback: measurementEntryTap,
                      ),
                    );
                  })
              : Center(
                  child: Text("No entries to show"),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMeasurement,
        tooltip: 'New Measurement Entry',
        child: Icon(Icons.add),
      ),
    );
  }
}

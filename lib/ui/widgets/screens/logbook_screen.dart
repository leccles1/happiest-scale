import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:body_composition/core/models/measurement_model.dart';
import 'package:body_composition/ui/viewmodels/measurement_viewmodel.dart';
import 'package:body_composition/ui/widgets/measurement_list_item.dart';

class LogbookScreen extends StatelessWidget {
    final String title;

    LogbookScreen({Key key, this.title}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      void _addMeasurement() {
      Navigator.of(context).pushNamed('/new');
    }

    void measurementEntryTap(int id, int modelIndex) {
      Measurement entry =
          Provider.of<MeasurementViewModel>(context, listen: false)
              .entries[modelIndex];
      Navigator.of(context).pushNamed('/edit', arguments: entry);
    }
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(title),
      ),
      body: Container(
        child: Consumer<MeasurementViewModel>(
          builder: (context, model, _) => Center(
            child: model.entries.length > 0
                ? ListView.builder(
                    itemCount: model.entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            await model.deleteEntry(
                                model.entries[index].id, index);
                            return true;
                          } else {
                            print('un-recognised swipe');
                            return false;
                          }
                        },
                        key: UniqueKey(),
                        background: Container(
                          alignment: Alignment(0.9, 0.0),
                          child: Text(
                            'Delete',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          color: Colors.red,
                        ),
                        child: MeasurementLisItem(
                          measurementEntry: model.entries[index],
                          modelIndex: index,
                          tapCallback: measurementEntryTap,
                        ),
                      );
                    })
                : Center(
                    child: Text("No entries to show"),
                  ),
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

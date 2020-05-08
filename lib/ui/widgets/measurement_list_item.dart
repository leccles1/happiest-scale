import 'package:body_composition/core/models/measurement_model.dart';
import 'package:flutter/material.dart';

class MeasurementLisItem extends StatelessWidget {
  final Measurement measurementEntry;
  final Function tapCallback;
  final int modelIndex;

  const MeasurementLisItem({Key key, this.measurementEntry, this.tapCallback, this.modelIndex})
      : super(key: key);

  static final Map monthMap = {
    '1': 'Jan',
    '2': 'Feb',
    '3': 'Mar',
    '4': 'Apr',
    '5': 'May',
    '6': 'Jun',
    '7': 'Jul',
    '8': 'Aug',
    '9': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec'
  };
  void _weightEntryTap() {
    tapCallback(measurementEntry.id, modelIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _weightEntryTap,
      child: Card(
        child: ListTile(
          leading: SizedBox(
            height: 40,
            width: 40,
            child: Column(
              children: <Widget>[
                Text(measurementEntry.date.day.toString() + ' '),
                Text(monthMap['${measurementEntry.date.month}'])
              ],
            ),
          ),
          title: Text(
              'Weight: ${measurementEntry.weight} ${measurementEntry.unitOfMeasurement}'),
          subtitle: Text(measurementEntry.notes),
          trailing: Text("ID: " + measurementEntry.id.toString()),
        ),
      ),
    );
  }
}

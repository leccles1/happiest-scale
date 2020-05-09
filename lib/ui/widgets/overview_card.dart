import 'package:body_composition/ui/viewmodels/measurement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    num average = Provider.of<MeasurementViewModel>(context).movingAverage;
    String movingAverage = average.isNaN
        ? "No weight entries"
        : average.toStringAsFixed(2) + ' kg';
    return Expanded(
      flex: 15,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 8, 48.0, 8),
        child: Card(
          child: Column(
            children: <Widget>[
              Text(
                "Moving Average",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '$movingAverage',
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

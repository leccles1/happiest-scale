import 'package:body_composition/ui/viewmodels/measurement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MeasurementViewModel>(
      builder: (context, model, child) => Expanded(
        flex: 15,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8, 12.0, 8),
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
                  '${model.movingAverage.toStringAsFixed(2)} kg',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

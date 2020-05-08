import 'package:body_composition/core/models/measurement_model.dart';
import 'package:body_composition/ui/viewmodels/measurement_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum UnitEnum { kg, pounds }

class EntryScreen extends StatefulWidget {
  final Measurement editMeasurement;
  const EntryScreen({Key key, this.editMeasurement})
      : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  UnitEnum _unit = UnitEnum.kg;

  @override
  Widget build(BuildContext context) {
    final Measurement editMeasurement = widget.editMeasurement;

    if (editMeasurement != null) {
      setState(() {
        _weightController.text = editMeasurement.weight.toString();
        _notesController.text = editMeasurement.notes;
        _unit = editMeasurement.unitOfMeasurement == 'kg'
            ? UnitEnum.kg
            : UnitEnum.pounds;
      });
    }
    return Consumer<MeasurementViewModel>(
      builder: (context, model, _) => Scaffold(
          appBar: AppBar(
            title: editMeasurement != null
                ? Text("Update Entry")
                : Text("New Entry"),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "Weight", hintText: '80'),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: _weightController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Notes", hintText: 'AM weigh in'),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    controller: _notesController,
                  ),
                  ListTile(
                    title: const Text('kg'),
                    leading: Radio(
                        value: UnitEnum.kg,
                        groupValue: _unit,
                        onChanged: (UnitEnum unit) {
                          setState(() {
                            _unit = unit;
                          });
                        }),
                  ),
                  ListTile(
                    title: const Text('lbs'),
                    leading: Radio(
                        value: UnitEnum.pounds,
                        groupValue: _unit,
                        onChanged: (UnitEnum unit) {
                          setState(() {
                            _unit = unit;
                          });
                        }),
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    child: editMeasurement != null
                        ? Text("Update Entry")
                        : Text('Add Entry'),
                    onPressed: () async {
                      final String weight = _weightController.value.text;
                      final String notes = _notesController.value.text;
                      final String unit = _unit == UnitEnum.kg ? 'kg' : 'lbs';
                      if (editMeasurement == null) {
                        await model.insertEntry(Measurement(
                            weight: int.parse(weight),
                            notes: notes,
                            unitOfMeasurement: unit,
                            date: DateTime.now()));
                      } else {
                        await model.updateEntry(Measurement(
                            id: editMeasurement.id,
                            weight: int.parse(weight),
                            notes: notes,
                            unitOfMeasurement: unit,
                            date: DateTime.now()));
                      }
                      Navigator.pushNamed(context, '/');
                    },
                    color: Colors.indigo,
                  )
                ],
              ),
            ),
          )),
    );
  }
}

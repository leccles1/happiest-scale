import 'dart:collection';

import 'package:body_composition/core/models/measurement_model.dart';
import 'package:body_composition/core/services/database_service.dart';
import 'package:flutter/material.dart';

class MeasurementViewModel extends ChangeNotifier {
  final DatabaseService databaseService;
  
  MeasurementViewModel({@required this.databaseService}) {
    fetchEntries();
  }

  final List<Measurement> _entries = [];

  UnmodifiableListView<Measurement> get entries => UnmodifiableListView(_entries);

  Future<void> fetchEntries() async {
    List<Measurement> measurements = await databaseService.fetchMeasurements();

    measurements.forEach((entry) => _entries.add(entry));
    notifyListeners();
  }

  Future<void> insertEntry(Measurement measurement) async {
    int rowId = await databaseService.insertMeasurement(measurement);
    measurement.id = rowId;
    _entries.insert(0, measurement);
    notifyListeners();
  }

  Future<void> deleteEntry(int id, int index) async {
    await databaseService.deleteMeasurement(id);
    _entries.removeAt(index);
    notifyListeners();
  }
  Future<void> updateEntry(Measurement measurement) async {
    await databaseService.updateMeasurement(measurement);
    int modified = _entries.indexWhere((element) => element.id == measurement.id);
    //Remove modified entry insert updated
    _entries.removeAt(modified);
    _entries.insert(modified, measurement);
    notifyListeners();
  }
}
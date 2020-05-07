import 'package:body_composition/core/services/database_service.dart';

import 'measurement_model.dart';

class ScreenArgs {
  final DatabaseService dbService;
  final Measurement editMeasurement;

  ScreenArgs({this.dbService, this.editMeasurement});
}
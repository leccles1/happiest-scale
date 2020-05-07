class Measurement {
  final int id;
  final int weight;
  final String notes;
  final String unitOfMeasurement;
  final DateTime date;

  Measurement({this.id, this.weight, this.notes, this.unitOfMeasurement, this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'weight': this.weight,
      'notes': this.notes,
      'unit_of_measurement': this.unitOfMeasurement,
      'date': this.date.toString()
    };
  }
}
class ClinicModel {
  final int id;
  final int number;

  ClinicModel({
    required this.id,
    required this.number,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(id: json['id'], number: json['number']);
  }
}

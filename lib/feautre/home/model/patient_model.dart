class PatientModel {
  final int id;
  final String fName;
  final String lName;
  final String gender;
  final String birthday;
  final String image;

  PatientModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.gender,
    required this.birthday,
    required this.image,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      fName: json['first_name'],
      lName: json['last_name'],
      gender: json['gender'],
      birthday: json['birthday'],
      image: json['image'],
    );
  }
}

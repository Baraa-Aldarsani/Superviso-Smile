class SectionModel {
  final int id;
  final String name;
  final String image;

  SectionModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'],
      name: json['name'],
      image: json['section_image'],
    );
  }
}

class ImageModel {
  int? id;
  final String image;
  ImageModel({
    required this.image,
    this.id,
  });

  static ImageModel fromMap(Map<String, dynamic> map) {
    return ImageModel(
      image: map["image"],
      id: map["id"],
    );
  }
}

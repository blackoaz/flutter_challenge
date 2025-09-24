class PixabayImage {
  final String thumbnail;
  final String photographer;
  final String tags;

  PixabayImage({
    required this.thumbnail,
    required this.photographer,
    required this.tags,
  });

  factory PixabayImage.fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      thumbnail: json['previewURL'] as String,
      photographer: json['user'] as String,
      tags: json['tags'] as String,
    );
  }
}
class CafeData {
  final String name;
  final double rating;
  final String description;
  final List<String> tags;
  final String imageColor;
  final String? imagePath; // local asset image
  final String? address;
  final String? timings;
  final String? whatsapp;
  final List<FoodMemory> memories;

  const CafeData({
    required this.name,
    required this.rating,
    required this.description,
    required this.tags,
    required this.imageColor,
    this.imagePath,
    this.address,
    this.timings,
    this.whatsapp,
    this.memories = const [],
  });
}

class FoodMemory {
  final String title;
  final String price;
  final String time;
  final String? imagePath;
  final String imageColor;

  const FoodMemory({
    required this.title,
    required this.price,
    required this.time,
    this.imagePath,
    required this.imageColor,
  });
}

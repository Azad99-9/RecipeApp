import 'package:hive/hive.dart';

part 'recipe.g.dart';

/// A class representing a recipe data object for Hive storage.

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  /// The unique identifier of the recipe.
  @HiveField(0)
  final String id;

  /// The name of the recipe.
  @HiveField(1)
  final String name;

  /// The URL of the recipe's image.
  @HiveField(2)
  final String imageUrl;

  /// Creates a new `Recipe` object.
  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  /// Creates a `Recipe` object from a JSON map.
  ///
  /// This constructor is useful for parsing recipe data from API responses
  /// or other JSON sources.
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['dishId'],
      name: json['dishName'],
      imageUrl: json['imageUrl'],
    );
  }
}

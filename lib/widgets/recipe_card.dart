import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/services/sizeconfig.dart';
import 'package:recipes/view_models.dart/recipe_view_model.dart';

/// A widget that displays a recipe card with an image, title, cooking time,
/// vegetarian indicator, and a rating bar.
///
/// This widget allows users to favorite recipes by tapping a heart icon and
/// displays the favorite state based on the provided `recipeViewModel`.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final EdgeInsets? detailsCustomPadding;
  final RecipeViewModel viewModel;

  /// flag indicating if the recipe is vegetarian.
  final bool isVegetarian = true;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.viewModel,
    this.detailsCustomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: SizeConfig.screenWidth * 0.7,
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: viewModel.isFavorite(recipe)
                              ? Colors.red
                              : Colors.white,
                        ),
                        onPressed: () {
                          viewModel.toggleFavorite(recipe);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: detailsCustomPadding ?? const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '30 minutes',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 5,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    isVegetarian
                                        ? "Vegetarian"
                                        : "Non-Vegetarian",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

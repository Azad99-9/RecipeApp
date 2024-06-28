import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/view_models.dart/recipe_view_model.dart';

/// A widget that displays a list of the user's favorite recipes.
///
/// This widget retrieves favorite recipes from a Hive box and displays them
/// in a list view. It also allows users to remove recipes from their favorites
/// by tapping a delete icon.
class FavoriteRecipesPage extends StatelessWidget {
  /// A Hive box for storing favorite recipes.
  final Box<Recipe> favoriteBox = Hive.box<Recipe>('favorites');

  /// An instance of the `RecipeViewModel` used to manage favorite recipes.
  final RecipeViewModel recipeViewModel;

  /// The constructor for the `FavoriteRecipesPage`.
  ///
  /// Takes an instance of `RecipeViewModel` as a dependency.
  FavoriteRecipesPage({
    required this.recipeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: ValueListenableBuilder(
        /// Listens to changes in the favoriteBox.
        valueListenable: favoriteBox.listenable(),
        builder: (context, Box<Recipe> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No favorite recipes yet.'),
            );
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final recipe = box.getAt(index);
              return Padding(
                  padding: const EdgeInsets.fromLTRB(2, 4, 2, 4),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(recipe!.imageUrl),
                              fit: BoxFit.cover)),
                      width: 100,
                      height: 100,
                    ),
                    title: Text(recipe.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        /// Calls the recipeViewModel to toggle favorite state.
                        recipeViewModel.toggleFavorite(recipe);
                      },
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

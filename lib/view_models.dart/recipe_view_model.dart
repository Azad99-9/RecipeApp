import 'package:hive/hive.dart';
import 'package:recipes/services/recipe_service.dart';
import 'package:stacked/stacked.dart';
import 'package:recipes/models/recipe.dart';

/// A view model class responsible for managing recipe data and user interactions
/// in the Recipes application.
///
/// This class extends `BaseViewModel` from the `stacked` package and provides
/// functionalities for fetching recipes, managing favorites, and notifying the UI
/// of changes.
class RecipeViewModel extends BaseViewModel {
  /// A Hive box for storing favorite recipes.
  final Box<Recipe> _favoriteBox = Hive.box<Recipe>('favorites');

  /// An instance of the `RecipeService` used to fetch recipes from an API.
  final RecipeService recipeService;

  /// The constructor for the `RecipeViewModel`.
  ///
  /// Takes an instance of `RecipeService` as a dependency.
  RecipeViewModel(this.recipeService);

  /// A list of recipes retrieved from the API.
  List<Recipe> recipes = [];

  /// Fetches a list of recipes from the `recipeService`.
  ///
  /// This method sets the busy state to true before making the API request.
  /// In case of success, it updates the `recipes` list and notifies listeners.
  /// If an error occurs, it prints the error message. Finally, it sets the
  /// busy state back to false.
  Future<void> fetchRecipes() async {
    setBusy(true);
    try {
      recipes = await recipeService.fetchRecipes();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    } finally {
      setBusy(false);
    }
  }

  /// Checks if a recipe is currently marked as a favorite.
  ///
  /// This method uses the Hive box to check if the recipe's ID exists as a key.
  /// It returns true if the recipe is a favorite, false otherwise.
  bool isFavorite(Recipe recipe) {
    return _favoriteBox.containsKey(recipe.id);
  }

  /// Toggles the favorite status of a recipe.
  ///
  /// This method checks if the recipe exists in the favorites box. If it does,
  /// it removes it. Otherwise, it adds the recipe to the favorites box. It then
  /// notifies listeners about the change.
  void toggleFavorite(Recipe recipe) {
    if (_favoriteBox.containsKey(recipe.id)) {
      _favoriteBox.delete(recipe.id);
    } else {
      _favoriteBox.put(recipe.id, recipe);
    }
    notifyListeners();
  }
}

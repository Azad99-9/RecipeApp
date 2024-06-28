import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/models/recipe.dart';

/// A service class responsible for fetching recipe data from an API.
class RecipeService {
  /// The base URL of the API endpoint that provides recipe data.
  final String apiUrl =
      "https://fls8oe8xp7.execute-api.ap-south-1.amazonaws.com/dev/nosh-assignment";

  /// Fetches a list of recipes from the API.
  ///
  /// This method performs an HTTP GET request to the configured API endpoint
  /// and parses the JSON response into a list of `Recipe` objects.
  ///
  /// Throws an exception if the request fails or the response status code
  /// is not 200 (OK).
  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load Recipes');
    }
  }
}

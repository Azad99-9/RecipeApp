import 'package:flutter/material.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/view_models.dart/recipe_view_model.dart';

/// A widget that displays the "Dish of the Day" section on the RecipePage.
///
/// This widget showcases a recipe with a background image, a search bar
/// overlay, and the dish name with a "Dish of the Day" label. It also
/// includes a favorite icon that toggles the recipe's favorite state
/// using the provided `recipeViewModel`.
class DishOfTheDay extends StatelessWidget {
  final Recipe recipe;
  final RecipeViewModel recipeViewModel;

  const DishOfTheDay({
    super.key,
    required this.recipe,
    required this.recipeViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Image.network(
            recipe.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        // Overlay with gradient for better text visibility
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                ),
              ),
            ),
          ),
        ),
        // Dish name and "Dish of the Day" text
        Positioned(
          bottom: 24.0,
          left: 16.0,
          right: 16.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Dish of the Day',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                recipe.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        // Heart Icon
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: recipeViewModel.isFavorite(recipe)
                  ? Colors.red
                  : Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              recipeViewModel.toggleFavorite(recipe);
            },
          ),
        ),
      ],
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(
              _searchText.isEmpty ? Icons.search : Icons.close,
            ),
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchText = '';
              });
            },
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchText = value;
          });
        },
      ),
    );
  }
}

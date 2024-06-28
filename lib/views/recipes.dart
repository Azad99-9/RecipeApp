import 'package:flutter/material.dart';
import 'package:recipes/services/recipe_service.dart';
import 'package:recipes/services/sizeconfig.dart';
import 'package:recipes/view_models.dart/recipe_view_model.dart';
import 'package:recipes/views/favorite_recipes.dart';
import 'package:recipes/widgets/dish_of_the_day.dart';
import 'package:recipes/widgets/recipe_card.dart';
import 'package:stacked/stacked.dart';

/// The main recipe page of the application.
///
/// This widget displays a list of recipes fetched from an API. It also
/// includes a "Dish of the Day" section, a floating action button to refresh
/// recipes, and a navigation button to the favorites page.
class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeService = RecipeService();
    return ViewModelBuilder<RecipeViewModel>.reactive(
      /// Creates and configures a RecipeViewModel instance.
      viewModelBuilder: () => RecipeViewModel(recipeService),
      onViewModelReady: (viewModel) => viewModel.fetchRecipes(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recipes'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoriteRecipesPage(
                                  recipeViewModel: viewModel,
                                )));
                  },
                  icon: const Icon(Icons.favorite_border))
            ],
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                    viewModel.recipes.isNotEmpty
                        ? SizedBox(
                            height: SizeConfig.screenHeight * 0.4,
                            child: DishOfTheDay(
                              recipe: viewModel.recipes[3],
                              recipeViewModel: viewModel,
                            ),
                          )
                        : Container(),
                    CardGroup(groupTitle: 'Discover regional delights', titleColor: Colors.black, backgroundColor: Colors.white, viewModel: viewModel),
                    CardGroup(groupTitle: 'Breakfasts for champions', titleColor: Colors.white, backgroundColor: Colors.black, viewModel: viewModel)
                  ] +
                  List.generate(
                      viewModel.recipes.length,
                      (index) => Container(
                            padding: const EdgeInsets.only(top: 8),
                            height: SizeConfig.screenHeight * 0.5,
                            width: SizeConfig.screenWidth * 0.89,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0),
                              child: RecipeCard(
                                recipe: viewModel.recipes[index],
                                viewModel: viewModel,
                                detailsCustomPadding:
                                    const EdgeInsets.all(16.0),
                              ),
                            ),
                          )),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.fetchRecipes();
            },
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}

/// A widget that displays a group of recipe cards with a title.
class CardGroup extends StatelessWidget {
  final RecipeViewModel viewModel;
  final String groupTitle;
  final Color backgroundColor;
  final Color titleColor;
  const CardGroup({
    super.key,
    required this.groupTitle,
    required this.titleColor,
    required this.backgroundColor,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(28, 30, 20, 10),
          width: SizeConfig.screenWidth,
          color: backgroundColor,
          child: Text(groupTitle,
              style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 20)),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          height: SizeConfig.screenWidth,
          child: viewModel.recipes.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = viewModel.recipes[index];
                    return Padding(
                        padding: EdgeInsets.fromLTRB(index == 0 ? 26 : 2, 0,
                            index == viewModel.recipes.length - 1 ? 26 : 2, 6),
                        child: RecipeCard(
                          recipe: recipe,
                          viewModel: viewModel,
                        ));
                  },
                ),
        ),
      ],
    );
  }
}

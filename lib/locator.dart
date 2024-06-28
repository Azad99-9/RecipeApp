import 'package:get_it/get_it.dart';
import 'package:recipes/services/recipe_service.dart';
import 'package:recipes/services/sizeconfig.dart';

/// A service locator instance using the `get_it` package.
final locator = GetIt.instance;

/// Instance of the RecipeService retrieved from the locator.
final RecipeService recipeService = locator<RecipeService>();

/// Instance of the SizeConfig retrieved from the locator.
final SizeConfig sizeConfig = locator<SizeConfig>();

/// Sets up the service locator with dependencies.
void setupLocator() {
  /// Registers SizeConfig as a singleton.
  /// There should only be one instance throughout the application.
  locator.registerSingleton(SizeConfig());

  /// Registers RecipeService as a factory.
  /// A new instance will be created each time it's requested.
  locator.registerFactory(() => RecipeService());
}

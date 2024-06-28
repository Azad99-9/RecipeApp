import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipes/locator.dart'; // Import for service locator
import 'package:recipes/models/recipe.dart';
import 'package:recipes/views/recipes.dart'; // Likely RecipePage widget

void main() async {
  // Ensure Flutter widgets are initialized before further actions
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local data storage
  await Hive.initFlutter();

  // Register an adapter for Recipe objects with Hive
  Hive.registerAdapter(RecipeAdapter());

  // Open a Hive box named 'favorites' to store favorite recipes
  await Hive.openBox<Recipe>('favorites');

  // Configure the service locator with dependencies
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig for responsive design (assuming it exists)
    sizeConfig.init(context);

    return MaterialApp(
      title: 'Nosh Robotics Assignment',
      theme: ThemeData(
        // Set app theme with deep purple as the seed color and Material 3 design
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RecipePage(), // Set RecipePage as the initial screen
    );
  }
}

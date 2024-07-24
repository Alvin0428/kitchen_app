import 'package:flutter/material.dart';
import 'package:kitchen_app/recipe.dart';
import 'package:kitchen_app/unit_converter.dart';
import 'package:kitchen_app/timer.dart';

void main() {
  runApp(KitchenApp());
}

class KitchenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _recipes = [
    'Fried Rice',
    'Spaghetti Bolognese',
    'Pancakes',
    'Caesar Salad',
    'Chili Con Carne',
    'Omelette',
    'Other Recipe'
  ];
  String _selectedRecipe = 'Fried Rice';

  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _measurementController = TextEditingController();
  final List<Map<String, String>> _customIngredients = [];

  final TextEditingController _stepController = TextEditingController();
  final List<Map<String, dynamic>> _customSteps = [];
  final Map<String, List<Map<String, dynamic>>> _recipeSteps = {};

  @override
  void initState() {
    super.initState();
    // Initialize the recipe steps with 'completed' flag
    recipes.forEach((recipeName, recipeDetails) {
      _recipeSteps[recipeName] = recipeDetails['steps']
          .map<Map<String, dynamic>>((step) => {'step': step, 'completed': false})
          .toList();
    });
  }

  void _selectRecipe(String recipe) {
    setState(() {
      _selectedRecipe = recipe;
      _customIngredients.clear();
      _customSteps.clear();
    });
  }

  void _addCustomIngredient() {
    setState(() {
      _customIngredients.add({
        'ingredient': _ingredientController.text,
        'measurement': _measurementController.text,
      });
      _ingredientController.clear();
      _measurementController.clear();
    });
  }

  void _addCustomStep() {
    setState(() {
      _customSteps.add({
        'step': _stepController.text,
        'completed': false,
      });
      _stepController.clear();
    });
  }

  void _toggleStepCompletion(String recipe, int index) {
    setState(() {
      if (recipe == 'custom') {
        _customSteps[index]['completed'] = !_customSteps[index]['completed'];
      } else {
        _recipeSteps[recipe]![index]['completed'] = !_recipeSteps[recipe]![index]['completed'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = _selectedRecipe == 'Other Recipe'
        ? []
        : recipes[_selectedRecipe]?['ingredients'] ?? [];
    final steps = _selectedRecipe == 'Other Recipe'
        ? []
        : _recipeSteps[_selectedRecipe] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Kitchen App'),
        backgroundColor: Colors.teal[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text('Recipes', style: Theme.of(context).textTheme.headlineSmall),
              Wrap(
                spacing: 8.0,
                children: _recipes.map((recipe) {
                  return ElevatedButton(
                    onPressed: () => _selectRecipe(recipe),
                    child: Text(recipe),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[600],
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Ingredients', style: Theme.of(context).textTheme.headlineSmall),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      decoration: InputDecoration(
                        labelText: 'Enter ingredient...',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _measurementController,
                      decoration: InputDecoration(
                        labelText: 'Enter measurement...',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addCustomIngredient,
                child: Text('Add Ingredient'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: ingredients.map<Widget>((ingredient) {
                  return ListTile(
                    title: Text('${ingredient['ingredient']}: ${ingredient['measurement']}'),
                  );
                }).toList() + _customIngredients.map<Widget>((ingredient) {
                  return ListTile(
                    title: Text('${ingredient['ingredient']}: ${ingredient['measurement']}'),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Cooking Steps', style: Theme.of(context).textTheme.headlineSmall),
              TextField(
                controller: _stepController,
                decoration: InputDecoration(
                  labelText: 'Enter cooking step...',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addCustomStep,
                child: Text('Add Step'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: steps.map<Widget>((stepData) {
                  return ListTile(
                    title: Text(
                      stepData['step'],
                      style: TextStyle(
                        decoration: stepData['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    onTap: () => _toggleStepCompletion(_selectedRecipe, steps.indexOf(stepData)),
                  );
                }).toList() + _customSteps.map<Widget>((stepData) {
                  return ListTile(
                    title: Text(
                      stepData['step'],
                      style: TextStyle(
                        decoration: stepData['completed']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    onTap: () => _toggleStepCompletion('custom', _customSteps.indexOf(stepData)),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Unit Converter', style: Theme.of(context).textTheme.headlineSmall),
              UnitConverter(),
              SizedBox(height: 20),
              Text('Timer', style: Theme.of(context).textTheme.headlineSmall),
              TimerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

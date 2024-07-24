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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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

  int _completedTimers = 0;

  void _selectRecipe(String recipe) {
    setState(() {
      _selectedRecipe = recipe;
      _customIngredients.clear();
      _customSteps.clear();
    });
    _tabController.animateTo(1);
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

  void _deleteCustomIngredient(int index) {
    setState(() {
      _customIngredients.removeAt(index);
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

  void _deleteCustomStep(int index) {
    setState(() {
      _customSteps.removeAt(index);
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

  void _incrementCompletedTimers() {
    setState(() {
      _completedTimers++;
    });
  }

  void _resetCompletedTimers() {
    setState(() {
      _completedTimers = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 3) {
        _resetCompletedTimers();
      }
    });
    // Initialize the recipe steps with 'completed' flag
    recipes.forEach((recipeName, recipeDetails) {
      _recipeSteps[recipeName] = recipeDetails['steps']
          .map<Map<String, dynamic>>((step) => {'step': step, 'completed': false})
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitchen App'),
        backgroundColor: Colors.teal[800],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4.0,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: "Recipes"),
            Tab(text: "Ingredients & Steps"),
            Tab(text: "Unit Converter"),
            Tab(
              child: Stack(
                children: <Widget>[
                  Center(child: Text("Timer")),
                  if (_completedTimers > 0)
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '$_completedTimers',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecipeTab(),
          _IngredientsAndStepsTab(
            selectedRecipe: _selectedRecipe,
            ingredientController: _ingredientController,
            measurementController: _measurementController,
            customIngredients: _customIngredients,
            stepController: _stepController,
            customSteps: _customSteps,
            recipeSteps: _recipeSteps,
            addCustomIngredient: _addCustomIngredient,
            deleteCustomIngredient: _deleteCustomIngredient,
            addCustomStep: _addCustomStep,
            deleteCustomStep: _deleteCustomStep,
            toggleStepCompletion: _toggleStepCompletion,
          ),
          UnitConverter(),
          TimerWidget(
            incrementCompletedTimers: _incrementCompletedTimers,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeTab() {
    final List<String> imagePaths = [
      'image1.jpg',
      'image2.jpg',
      'image3.jpg',
      'image4.jpg',
      'image5.jpg',
      'image6.jpg',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        if (index < _recipes.length - 1) {
          return GestureDetector(
            onTap: () => _selectRecipe(_recipes[index]),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/${imagePaths[index]}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _recipes[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => _selectRecipe(_recipes[index]),
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 50, color: Colors.teal[600]),
                  Text(
                    'Make Your Own',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.teal[600]),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class _IngredientsAndStepsTab extends StatefulWidget {
  final String selectedRecipe;
  final TextEditingController ingredientController;
  final TextEditingController measurementController;
  final List<Map<String, String>> customIngredients;
  final TextEditingController stepController;
  final List<Map<String, dynamic>> customSteps;
  final Map<String, List<Map<String, dynamic>>> recipeSteps;
  final Function addCustomIngredient;
  final Function deleteCustomIngredient;
  final Function addCustomStep;
  final Function deleteCustomStep;
  final Function toggleStepCompletion;

  _IngredientsAndStepsTab({
    required this.selectedRecipe,
    required this.ingredientController,
    required this.measurementController,
    required this.customIngredients,
    required this.stepController,
    required this.customSteps,
    required this.recipeSteps,
    required this.addCustomIngredient,
    required this.deleteCustomIngredient,
    required this.addCustomStep,
    required this.deleteCustomStep,
    required this.toggleStepCompletion,
  });

  @override
  __IngredientsAndStepsTabState createState() => __IngredientsAndStepsTabState();
}

class __IngredientsAndStepsTabState extends State<_IngredientsAndStepsTab>
    with AutomaticKeepAliveClientMixin<_IngredientsAndStepsTab> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final ingredients = widget.selectedRecipe == 'Other Recipe'
        ? []
        : recipes[widget.selectedRecipe]?['ingredients'] ?? [];
    final steps = widget.selectedRecipe == 'Other Recipe'
        ? []
        : widget.recipeSteps[widget.selectedRecipe] ?? [];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Text('Ingredients', style: Theme.of(context).textTheme.headlineSmall),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.ingredientController,
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
                    controller: widget.measurementController,
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
              onPressed: () => widget.addCustomIngredient(),
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
              }).toList() + widget.customIngredients.map<Widget>((ingredient) {
                return ListTile(
                  title: Text('${ingredient['ingredient']}: ${ingredient['measurement']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => widget.deleteCustomIngredient(widget.customIngredients.indexOf(ingredient)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('Cooking Steps', style: Theme.of(context).textTheme.headlineSmall),
            TextField(
              controller: widget.stepController,
              decoration: InputDecoration(
                labelText: 'Enter cooking step...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => widget.addCustomStep(),
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
                  onTap: () => widget.toggleStepCompletion(widget.selectedRecipe, steps.indexOf(stepData)),
                );
              }).toList() + widget.customSteps.map<Widget>((stepData) {
                return ListTile(
                  title: Text(
                    stepData['step'],
                    style: TextStyle(
                      decoration: stepData['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => widget.deleteCustomStep(widget.customSteps.indexOf(stepData)),
                  ),
                  onTap: () => widget.toggleStepCompletion('custom', widget.customSteps.indexOf(stepData)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
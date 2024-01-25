import 'package:flutter/material.dart';
import 'package:recipe_nba/model/recipe%20models/recipe.api.dart';
import 'package:recipe_nba/model/recipe%20models/recipe.dart';
import 'package:recipe_nba/nba/nba_homepage.dart';
import 'package:recipe_nba/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
    print('init state called');
  }

  Future<void> getRecipes() async {
    print('function called');
    _recipes = await RecipeApi.getRecipe();
    print('this is recipe : $_recipes');
    setState(() {
      _isLoading = false;
      print('set state called');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text('food Recipe')],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NbaPage()),
                    );
                  },
                  child: Text('NBA'))
            ]),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images);
                }));
  }
}

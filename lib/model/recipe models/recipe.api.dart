import 'dart:convert';
import 'package:recipe_nba/model/recipe%20models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https(
        'yummly2.p.rapidapi.com', '/feeds/list', {"limit": '24', "start": "0", 'tag':'list.recipe.popular'});
    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'dd9e5bfb82mshfaed08084190e82p1d851djsnbaa192c9cf35',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
    });
    Map data = jsonDecode(response.body);
    List temp = [];
    for (var i in data['feed']) {
      temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapshot(temp);
  }
}

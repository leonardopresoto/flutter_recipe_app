import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/model/recipe.dart';
import 'package:flutter_recipe_app/screens/details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.orange,
        middle: Text("Cooking at home"),
      ),
      child: FutureBuilder<List<Recipe>>(
        initialData: List<Recipe>(),
        future: fetchPhotos(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RecipeList(recipes: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

List<Recipe> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
}

Future<List<Recipe>> fetchPhotos(BuildContext context) async {
  final response =
  await DefaultAssetBundle.of(context).loadString('assets/recipe.json');

  return parsePhotos(response);
}

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;


  RecipeList({Key key, this.recipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Recipe> newRecipes = recipes.toSet().toList();
    newRecipes.shuffle();
    return ListView.builder(
      itemCount: newRecipes.length,
      itemBuilder: (context, index) {
        return _RecipeItem(newRecipes[index]);
      },
    );
  }
}

class _RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final double radiusBorder = 30;

  _RecipeItem(this.recipe);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => Details(recipe: recipe)));
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.orange,
        shape: _setCardBorder(),
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                _cardImage(),
                _cardTitle(),
                _cardDuration(),
              ],
            )
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder _setCardBorder() {
    return RoundedRectangleBorder(
      side: BorderSide(color: Colors.transparent, width: 1),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusBorder),
          bottomRight: Radius.circular(radiusBorder)),
    );
  }

  Positioned _cardTitle() {
    return Positioned(
              left: 10,
              bottom: 10,
              child: SizedBox(
                width: 250,
                child: Text(
                  recipe.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            );
  }

  Positioned _cardDuration() {
    return Positioned(
        right: 12,
        bottom: 10,
        child: RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: 15,
                backgroundColor: Colors.black.withOpacity(0.5)
            ),
            children: [
              WidgetSpan(
                child: Icon(Icons.timer,
                  color: Colors.white, size: 15,),
              ),
              TextSpan(
                text: ' '+recipe.duration,
              ),
            ],
          ),
        ));
  }

  ClipRRect _cardImage() {
    return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusBorder),
                  bottomRight: Radius.circular(radiusBorder)),
              child: Image.asset(
                recipe.photo,
                fit: BoxFit.cover,
                height: 200,
              ),
            );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/model/recipe.dart';


class Details extends StatelessWidget {

  final Recipe recipe;

  Details({Key key, @required this.recipe}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return _construirDetalhes(context);
  }

  Widget _construirDetalhes(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: <Widget>[
              Icon(CupertinoIcons.arrow_left, color: Colors.black,size: 25,),
            ],
          ),
        ),
        backgroundColor: Colors.orange,
        middle: Text(recipe.title, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: false, ),
      ),
      child: ListView(
        children: <Widget>[
          _construirImagemDetalhes(recipe.photo),
          _construirTituloDetalhes(recipe.title),
          _construirLinhaIconesDetalhes(recipe.duration, '${recipe.portion} portions'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          _construirSubtitulosDetalhes('Ingredients'),
          _construirTextoDetalhes(recipe.ingredients),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1,
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          _construirSubtitulosDetalhes('Preparation Method'),
          _construirTextoDetalhes(recipe.method)
        ],
      ),
    );
  }

  Widget _construirImagemDetalhes(String imagem) {
    return ClipRRect(
      child: Image.asset(
        recipe.photo,
        fit: BoxFit.cover,
        height: 200,
      ),
    );
  }

  Widget _construirTituloDetalhes(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Center(
        child: Text(titulo, textAlign: TextAlign.center, style: TextStyle(color: Colors.orange, fontSize: 30)),
      ),
    );
  }

  Widget _construirSubtitulosDetalhes(String subtitulo) {
    return Center(
        child: Text(subtitulo, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
    );
  }

  Widget _construirTextoDetalhes(String texto) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Text(texto)
    );
  }

  Widget _construirLinhaIconesDetalhes(String tempo, String rendimento) {
    return Row(
      children: <Widget>[
        _construirColuna(tempo, Icons.timer),
        _construirColuna(rendimento, Icons.restaurant)
      ],
    );
  }

  Widget _construirColuna(String dado, IconData icone) {
    return  Expanded(
        child:
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Icon(icone, color: Colors.orange),
                Text(dado, style: TextStyle(color: Colors.orange,
                    fontWeight: FontWeight.bold, fontSize: 12)
                )],
            )
        )
    );
  }
}
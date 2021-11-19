import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=> Navigator.pushNamed(context, charactersDetailsScreen , arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.myGrey,
              child: character.img.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/1loading.gif',
                      image: character.img,
                    )
                  : Image.asset('assets/images/1.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character.name}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

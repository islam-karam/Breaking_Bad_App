import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key key, this.character}) : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildDivider(double endIndent){
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }
  Widget chechIfQuotesAreLoaded(CharactersState state){
    if (state is QuotesLoaded){
      return displayRandomQuoteOrEmptySpace(state);
    }else{
      return showProgressIndicator();

    }
  }
  Widget displayRandomQuoteOrEmptySpace(state){
    var quotes = (state).quote;
    if(quotes.length !=0){
      int randomQuotIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.myYellow,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0,0),
              ),
            ]
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuotIndex].quote),
            ],
          ),
        ),
      );
    }else {
      return Container();
    }
  }
  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuoteCubit(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('jop : ',character.occupation.join(' / ')),
                    buildDivider(290),
                    characterInfo('Appeared in : ',character.category),
                    buildDivider(220),
                    characterInfo('Seasons : ',character.appearance.join(' / ')),
                    buildDivider(250),
                    characterInfo('Status : ',character.status),
                     buildDivider(260),
                    character.betterCallSaulAppearance.isEmpty ?Container() :
                    characterInfo('Better Call Saul SeaSons : ',character.betterCallSaulAppearance.join(' / ')),
                    character.betterCallSaulAppearance.isEmpty ?Container() :
                    buildDivider(120),
                    characterInfo('Actor / Actress : ',character.status),
                    buildDivider(200),
                    SizedBox(height: 20,),
                    BlocBuilder<CharactersCubit,CharactersState>(builder: (context, state){
                      return chechIfQuotesAreLoaded(state);
                    },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 300,),
            ]),
          ),
        ],
      ),
    );
  }
}

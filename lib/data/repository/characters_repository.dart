import '../api/characters_api.dart';
import '../models/characters.dart';
import '../models/quotes.dart';

class CharactersRepository{
  final CharactersApi charactersApi;

  CharactersRepository(this.charactersApi);

  Future<List<Character>> getAllCharactersRepository() async{
    final characters = await charactersApi.getAllCharactersApi();
    return characters.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> getCharacterQuotesRepository(String charName) async{
    final quotes = await charactersApi.getCharacterQuotes(charName);
    return quotes.map((charQuote) => Quote.fromJason(charQuote)).toList();
  }



}
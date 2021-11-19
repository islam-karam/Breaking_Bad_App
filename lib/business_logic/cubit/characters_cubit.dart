import 'package:bloc/bloc.dart';
import '../../data/models/characters.dart';
import '../../data/models/quotes.dart';
import '../../data/repository/characters_repository.dart';
import 'package:meta/meta.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

  final CharactersRepository charactersRepository;

  List<Character> characters;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharactersCubit() {
    charactersRepository.getAllCharactersRepository().then((characters) { 
        emit(CharactersLoaded(characters));
        this.characters = characters;
    });
    return characters;

  }

  void getQuoteCubit(String charName) {
    charactersRepository..getCharacterQuotesRepository(charName).then((quotes) {
      emit(QuotesLoaded(quotes));
    });
  }

}

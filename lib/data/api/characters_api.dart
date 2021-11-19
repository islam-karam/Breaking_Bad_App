import '../../constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersApi {
  Dio dio;

  CharactersApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 50 * 1000,
      receiveTimeout: 50 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharactersApi() async {
    try {
      Response response = await dio.get('characters');
      print(response.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacterQuotes(String charName) async {
    try {
      Response response = await dio.get('quote', queryParameters: {'author':charName});
      print(response.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }



}

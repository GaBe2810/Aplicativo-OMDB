import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelojson/modelojson.dart';

class OmdbService {
  final String apiKey = 'bf325c9';

  Future<List<Filmes>> procurarFilme(String title, String year) async {
    if (title.isEmpty) return [];

    final url = Uri.parse(
      'https://www.omdbapi.com/?apikey=$apiKey&s=$title${year.isNotEmpty ? '&y=$year' : ''}',
    );

    final res = await http.get(url);
    final data = jsonDecode(res.body);

    if (data['Search'] == null) return [];

    return (data['Search'] as List)
        .map((json) => Filmes.fromJson(json))
        .toList();
  }

  Future<FilmesInfo> pegarInformacao(String imdbID) async {
    final url = Uri.parse(
      'https://www.omdbapi.com/?apikey=$apiKey&i=$imdbID&plot=full',
    );

    final res = await http.get(url);
    final data = jsonDecode(res.body);

    return FilmesInfo.fromJson(data);
  }
}

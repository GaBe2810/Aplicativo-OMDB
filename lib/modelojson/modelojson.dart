class Filmes {
  final String title;
  final String year;
  final String imdbID;
  final String poster;

  Filmes({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
  });

  factory Filmes.fromJson(Map<String, dynamic> json) {
    return Filmes(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      imdbID: json['imdbID'] ?? '',
      poster: json['Poster'] ?? '',
    );
  }
}

class FilmesInfo {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String poster;

  FilmesInfo({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.poster,
  });

  factory FilmesInfo.fromJson(Map<String, dynamic> json) {
    return FilmesInfo(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      rated: json['Rated'] ?? '',
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
      genre: json['Genre'] ?? '',
      director: json['Director'] ?? '',
      writer: json['Writer'] ?? '',
      actors: json['Actors'] ?? '',
      plot: json['Plot'] ?? '',
      poster: json['Poster'] ?? '',
    );
  }
}

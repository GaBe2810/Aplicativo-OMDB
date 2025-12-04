import 'package:flutter/material.dart';
import '../modelojson/modelojson.dart';
import '../servicoapi/apiservico.dart';

class PaginaInfo extends StatelessWidget {
  final Filmes movie;

  const PaginaInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    final bool isTablet = largura > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFE6E4D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE6E4D6),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          movie.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: isTablet ? 24 : 18,
          ),
        ),
      ),
      body: FutureBuilder(
        future: OmdbService().pegarInformacao(movie.imdbID),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final m = snap.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? largura * 0.15 : 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IMAGEM RESPONSIVA
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    m.poster,
                    height: isTablet ? altura * 0.55 : altura * 0.40,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.movie, size: 100),
                  ),
                ),

                SizedBox(height: altura * 0.03),

                // TÍTULO RESPONSIVO
                Text(
                  m.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: altura * 0.04),

                // INFO LIST
                infoTile("Ano", m.year, isTablet),
                infoTile("Classificação", m.rated, isTablet),
                infoTile("Lançamento", m.released, isTablet),
                infoTile("Duração", m.runtime, isTablet),
                infoTile("Gênero", m.genre, isTablet),
                infoTile("Diretor", m.director, isTablet),
                infoTile("Escritor", m.writer, isTablet),
                infoTile("Atores", m.actors, isTablet),

                SizedBox(height: altura * 0.04),

                Text(
                  "Sinopse",
                  style: TextStyle(
                    fontSize: isTablet ? 26 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: altura * 0.015),

                Text(
                  m.plot,
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget infoTile(String title, String value, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 20 : 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: isTablet ? 20 : 16),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}

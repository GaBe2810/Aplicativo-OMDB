import 'package:flutter/material.dart';
import '../servicoapi/apiservico.dart';
import '../modelojson/modelojson.dart';
import 'pagina_informacoes.dart';

class BuscaPagina extends StatefulWidget {
  @override
  State<BuscaPagina> createState() => _PaginaPesquisa();
}

class _PaginaPesquisa extends State<BuscaPagina> {
  final titleController = TextEditingController();
  final yearController = TextEditingController();

  List<Filmes> results = [];
  bool loading = false;

  void procurar() async {
    setState(() => loading = true);

    results = await OmdbService().procurarFilme(
      titleController.text.trim(),
      yearController.text.trim(),
    );

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;
    final altura = MediaQuery.of(context).size.height;

    final bool isTablet = largura > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFE6E4D6),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? largura * 0.2 : 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  SizedBox(height: altura * 0.03),

                  // Campo de Título
                  TextField(
                    controller: titleController,
                    style: TextStyle(fontSize: isTablet ? 20 : 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Nome do filme",
                      hintStyle: TextStyle(fontSize: isTablet ? 20 : 16),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  SizedBox(height: altura * 0.02),

                  // Campo de Ano
                  TextField(
                    controller: yearController,
                    style: TextStyle(fontSize: isTablet ? 20 : 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Ano (opcional)",
                      hintStyle: TextStyle(fontSize: isTablet ? 20 : 16),
                      prefixIcon: const Icon(Icons.calendar_month),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  SizedBox(height: altura * 0.03),

                  // Botão
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 20 : 16,
                        ),
                        backgroundColor: const Color.fromARGB(255, 117, 77, 152),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: procurar,
                      child: Text(
                        "Pesquisar",
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: altura * 0.02),

                  // Loading
                  if (loading) const CircularProgressIndicator(),

                  // Lista
                  if (!loading)
                    Expanded(
                      child: results.isEmpty
                          ? const Center(child: Text("Nenhum resultado encontrado"))
                          : ListView.builder(
                              itemCount: results.length,
                              itemBuilder: (context, i) {
                                final movie = results[i];
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    leading: Image.network(
                                      movie.poster,
                                      width: isTablet ? 80 : 50,
                                      errorBuilder: (_, _, _) =>
                                          const Icon(Icons.movie),
                                    ),
                                    title: Text(
                                      movie.title,
                                      style: TextStyle(
                                        fontSize: isTablet ? 20 : 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      movie.year,
                                      style: TextStyle(
                                        fontSize: isTablet ? 18 : 14,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PaginaInfo(movie: movie),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Página responsável por mostrar os detalhes
// de uma espécie de abelha.
//
// É StatefulWidget porque possui um estado
// que pode mudar: favorito ou não favorito.
class DetalhesPage extends StatefulWidget {
  // Nome popular recebido da tela inicial.
  final String nome;

  // Nome científico recebido da tela inicial.
  final String nomeCientifico;

  // Descrição recebida da tela inicial.
  final String descricao;

  // Informa se a espécie já estava favoritada
  // quando a página foi aberta.
  final bool favoritoInicial;

  // Função utilizada para avisar a HomePage
  // quando o estado do favorito mudar.
  final ValueChanged<bool> onFavoritoAlterado;

  const DetalhesPage({
    super.key,
    required this.nome,
    required this.nomeCientifico,
    required this.descricao,
    required this.favoritoInicial,
    required this.onFavoritoAlterado,
  });

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}

// Classe responsável pelo estado da página.
class _DetalhesPageState extends State<DetalhesPage> {
  // Variável que armazena o estado atual do favorito.
  late bool favorito;

  // initState é executado uma vez
  // quando a página é criada.
  @override
  void initState() {
    super.initState();

    // O estado começa com o valor recebido
    // da HomePage.
    favorito = widget.favoritoInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior.
      appBar: AppBar(
        title: Text(widget.nome),
      ),

      // Conteúdo principal da página.
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Representação visual da abelha.
            const Center(
              child: Text(
                '🐝',
                style: TextStyle(fontSize: 80),
              ),
            ),

            const SizedBox(height: 20),

            // Nome popular.
            Text(
              widget.nome,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Nome científico.
            Text(
              widget.nomeCientifico,
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 20),

            // Descrição da espécie.
            Text(
              widget.descricao,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Botão de favorito.
            Center(
              child: ElevatedButton.icon(
                // onPressed captura o toque.
                onPressed: () {
                  // Atualiza o estado da página.
                  setState(() {
                    favorito = !favorito;
                  });

                  // Informa à HomePage que o
                  // estado do favorito foi alterado.
                  widget.onFavoritoAlterado(
                    favorito,
                  );
                },

                // O ícone muda conforme o estado.
                icon: Icon(
                  favorito
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),

                // O texto também muda conforme o estado.
                label: Text(
                  favorito
                      ? 'Favoritada'
                      : 'Favoritar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
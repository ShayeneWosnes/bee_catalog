import 'package:flutter/material.dart';

// Página responsável por mostrar
// os detalhes de uma espécie.
//
// É StatefulWidget porque possui um estado
// que pode mudar durante a execução:
// favorito ou não favorito.
class DetalhesPage extends StatefulWidget {
  // Nome popular recebido da HomePage.
  final String nome;

  // Nome científico recebido da HomePage.
  final String nomeCientifico;

  // Descrição recebida da HomePage.
  final String descricao;

  // Caminho da imagem recebida da HomePage.
  final String imagem;

  // Informa se a espécie já estava favoritada
  // quando a página foi aberta.
  final bool favoritoInicial;

  // Função utilizada para informar à HomePage
  // quando o estado do favorito for alterado.
  final ValueChanged<bool> onFavoritoAlterado;

  // Construtor da página.
  //
  // Os parâmetros required precisam ser enviados
  // sempre que a página for criada.
  const DetalhesPage({
    super.key,
    required this.nome,
    required this.nomeCientifico,
    required this.descricao,
    required this.imagem,
    required this.favoritoInicial,
    required this.onFavoritoAlterado,
  });

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}

// Classe responsável pelo estado
// da página de detalhes.
class _DetalhesPageState extends State<DetalhesPage> {
  // Variável que armazena se a espécie
  // está favoritada ou não.
  //
  // late significa que o valor será definido
  // antes de ser utilizado.
  late bool favorito;

  // initState é executado uma única vez
  // quando a página é criada.
  @override
  void initState() {
    super.initState();

    // O estado inicial recebe o valor
    // enviado pela HomePage.
    favorito = widget.favoritoInicial;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela.
    return Scaffold(
      // Barra superior da página.
      appBar: AppBar(
        // O nome da espécie é exibido no topo.
        title: Text(widget.nome),
      ),

      // Conteúdo principal da página.
      body: Padding(
        // Espaçamento entre o conteúdo
        // e as bordas da tela.
        padding: const EdgeInsets.all(20),

        // Column organiza os elementos verticalmente.
        child: Column(
          // Alinha os elementos à esquerda.
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Centraliza a imagem da espécie.
            Center(
              // ClipRRect permite criar
              // bordas arredondadas na imagem.
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),

                // Image.asset carrega a imagem
                // armazenada dentro do projeto.
                child: Image.asset(
                  widget.imagem,

                  // Define o tamanho da imagem.
                  width: 220,
                  height: 180,

                  // Faz a imagem ocupar o espaço
                  // sem ficar deformada.
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Espaçamento após a imagem.
            const SizedBox(height: 24),

            // Exibe o nome popular.
            Text(
              widget.nome,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Exibe o nome científico.
            Text(
              widget.nomeCientifico,
              style: const TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),

            // Espaçamento antes da descrição.
            const SizedBox(height: 20),

            // Exibe a descrição da espécie.
            Text(
              widget.descricao,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            // Espaçamento antes do botão.
            const SizedBox(height: 30),

            // Centraliza o botão de favorito.
            Center(
              // ElevatedButton.icon cria
              // um botão com ícone e texto.
              child: ElevatedButton.icon(
                // onPressed captura o toque do usuário.
                onPressed: () {
                  // setState informa ao Flutter
                  // que o estado da tela mudou.
                  setState(() {
                    // Inverte o valor atual.
                    //
                    // false -> true
                    // true -> false
                    favorito = !favorito;
                  });

                  // Informa à HomePage que o estado
                  // do favorito foi alterado.
                  widget.onFavoritoAlterado(
                    favorito,
                  );

                  // Fecha um Snackbar anterior,
                  // caso ainda esteja sendo exibido.
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar();

                  // Exibe uma mensagem temporária
                  // na parte inferior da tela.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      // O conteúdo da mensagem muda
                      // conforme o estado do favorito.
                      content: Text(
                        favorito
                            ? '${widget.nome} adicionada aos favoritos!'
                            : '${widget.nome} removida dos favoritos!',
                      ),

                      // Tempo em que a mensagem
                      // permanece visível.
                      duration: const Duration(
                        seconds: 2,
                      ),
                    ),
                  );
                },

                // O ícone muda conforme
                // o estado do favorito.
                icon: Icon(
                  favorito
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),

                // O texto do botão também muda.
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
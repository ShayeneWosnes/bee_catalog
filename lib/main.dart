import 'package:flutter/material.dart';

// Importa a página responsável por mostrar
// os detalhes de cada espécie.
import 'pages/detalhes_page.dart';

// Importa a página responsável por mostrar
// os detalhes sobre o app.

import 'pages/sobre_page.dart';

// Função principal do programa.
// Todo aplicativo Dart começa pela função main().
void main() {
  // runApp inicia a aplicação Flutter.
  runApp(const BeeCatalogApp());
}

// Widget principal do aplicativo.
//
// É um StatelessWidget porque as configurações
// gerais da aplicação não mudam durante a execução.
class BeeCatalogApp extends StatelessWidget {
  const BeeCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp configura a estrutura geral do aplicativo.
    return MaterialApp(
      // Remove a faixa "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,

      // Define o nome do aplicativo.
      title: 'BeeCatalog',

      // Define a primeira tela exibida.
      home: const HomePage(),
    );
  }
}

// A HomePage é StatefulWidget porque precisa
// armazenar quais espécies foram marcadas como favoritas.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Classe responsável por controlar
// o estado da HomePage.
class _HomePageState extends State<HomePage> {
  // Set utilizado para armazenar os nomes
  // das espécies marcadas como favoritas.
  //
  // Set não permite valores duplicados.
  final Set<String> favoritos = {};

  // Função responsável por adicionar ou remover
  // uma espécie da lista de favoritos.
  void _alterarFavorito(String nome, bool favorito) {
    // setState informa ao Flutter que os dados
    // da tela foram alterados e a interface precisa
    // ser reconstruída.
    setState(() {
      if (favorito) {
        // Adiciona a espécie aos favoritos.
        favoritos.add(nome);
      } else {
        // Remove a espécie dos favoritos.
        favoritos.remove(nome);
      }
    });
  }

  // Função reutilizável responsável
  // por criar os cards das espécies.
  //
  // Isso evita repetir o mesmo código
  // três vezes para espécies diferentes.
  Widget _criarCardAbelha({
    required BuildContext context,
    required String nome,
    required String nomeCientifico,
    required String descricao,
    required String imagem,
  }) {
    // Verifica se essa espécie está favoritada.
    final bool estaFavorita = favoritos.contains(nome);

    // Card cria um elemento visual semelhante
    // a um cartão.
    return Card(
      // Cria um espaço abaixo de cada card.
      margin: const EdgeInsets.only(bottom: 12),

      // Faz com que o conteúdo respeite
      // as bordas arredondadas do card.
      clipBehavior: Clip.antiAlias,

      child: Padding(
        // Espaçamento interno do card.
        padding: const EdgeInsets.all(12),

        // Row organiza os elementos horizontalmente.
        child: Row(
          children: [
            // ClipRRect permite deixar
            // as bordas da imagem arredondadas.
            ClipRRect(
              borderRadius: BorderRadius.circular(10),

              // Image.asset carrega uma imagem
              // salva dentro do próprio projeto.
              child: Image.asset(
                imagem,

                // Define o tamanho da imagem.
                width: 75,
                height: 75,

                // Faz a imagem preencher o espaço
                // sem ficar deformada.
                fit: BoxFit.cover,
              ),
            ),

            // Espaçamento entre a imagem e o texto.
            const SizedBox(width: 16),

            // Expanded faz o conteúdo ocupar
            // o espaço restante da linha.
            Expanded(
              child: Column(
                // Alinha os textos à esquerda.
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Exibe o nome popular da espécie.
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  // Exibe o nome científico.
                  Text(
                    nomeCientifico,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Se a espécie estiver favoritada,
            // exibe um coração no card.
            if (estaFavorita)
              const Icon(
                Icons.favorite,
                size: 20,
              ),

            // Botão responsável por abrir
            // a página de detalhes.
            IconButton(
              // onPressed captura o toque do usuário.
              onPressed: () {
                // Navigator.push abre uma nova página.
                Navigator.push(
                  context,

                  // MaterialPageRoute define
                  // qual página será exibida.
                  MaterialPageRoute(
                    builder: (context) => DetalhesPage(
                      // Envia os dados da espécie
                      // para a página de detalhes.
                      nome: nome,
                      nomeCientifico: nomeCientifico,
                      descricao: descricao,
                      imagem: imagem,

                      // Informa se a espécie
                      // já está favoritada.
                      favoritoInicial: estaFavorita,

                      // Recebe de volta o novo estado
                      // do favorito.
                      onFavoritoAlterado: (novoValor) {
                        _alterarFavorito(
                          nome,
                          novoValor,
                        );
                      },
                    ),
                  ),
                );
              },

              // Ícone que representa a navegação.
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold fornece a estrutura principal
    // de uma tela Flutter.
    return Scaffold(
      // Barra superior da página.
      // Barra superior da tela inicial.
appBar: AppBar(
  // Título do aplicativo.
  title: const Text('🐝 BeeCatalog'),

  // actions permite adicionar botões
  // no lado direito da AppBar.
  actions: [
    // Botão responsável por abrir
    // a página "Sobre o BeeCatalog".
    IconButton(
      // Ícone de informação.
      icon: const Icon(
        Icons.info_outline,
      ),

      // Texto mostrado caso o usuário
      // mantenha o cursor/toque sobre o botão.
      tooltip: 'Sobre',

      // onPressed captura o clique/toque.
      onPressed: () {
        // Navigator.push realiza a navegação
        // para a página SobrePage.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const SobrePage(),
          ),
        );
      },
    ),
  ],
),

      // ListView organiza os elementos verticalmente
      // e permite rolagem caso o conteúdo seja maior
      // que a tela.
      body: ListView(
        // Espaçamento entre o conteúdo
        // e as bordas da tela.
        padding: const EdgeInsets.all(16),

        children: [
          // Título principal da tela.
          const Text(
            'Conheça as abelhas brasileiras',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Espaçamento entre o título e os cards.
          const SizedBox(height: 20),

          // Card da espécie Jataí.
          _criarCardAbelha(
            context: context,
            nome: 'Jataí',
            nomeCientifico: 'Tetragonisca angustula',

            // Caminho da imagem dentro do projeto.
            imagem: 'assets/images/jatai.webp',

            descricao:
                'A Jataí é uma abelha sem ferrão amplamente '
                'distribuída no Brasil. É conhecida pelo pequeno '
                'tamanho e pela importância na polinização.',
          ),

          // Card da espécie Mandaçaia.
          _criarCardAbelha(
            context: context,
            nome: 'Mandaçaia',
            nomeCientifico: 'Melipona quadrifasciata',

            // Caminho da imagem dentro do projeto.
            imagem: 'assets/images/mandacaia.webp',

            descricao:
                'A Mandaçaia é uma abelha sem ferrão do gênero '
                'Melipona. É conhecida pelas faixas claras no '
                'abdômen e possui grande importância ecológica '
                'como polinizadora.',
          ),

          // Card da espécie Iraí.
          _criarCardAbelha(
            context: context,
            nome: 'Iraí',
            nomeCientifico: 'Nannotrigona testaceicornis',

            // Caminho da imagem dentro do projeto.
            imagem: 'assets/images/irai.webp',

            descricao:
                'A Iraí é uma pequena abelha sem ferrão encontrada '
                'em diferentes regiões do Brasil. Forma colônias '
                'sociais e participa da polinização de diversas plantas.',
          ),
        ],
      ),
    );
  }
}
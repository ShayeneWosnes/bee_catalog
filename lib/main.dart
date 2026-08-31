import 'package:flutter/material.dart';

// Importa a página responsável por mostrar
// os detalhes de cada espécie.
import 'pages/detalhes_page.dart';

// Função principal da aplicação.
// Todo programa Dart começa pela função main().
void main() {
  // runApp inicia o aplicativo Flutter.
  runApp(const BeeCatalogApp());
}

// Widget principal da aplicação.
//
// StatelessWidget é utilizado porque as configurações
// gerais do aplicativo não mudam durante a execução.
class BeeCatalogApp extends StatelessWidget {
  const BeeCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove a faixa "DEBUG".
      debugShowCheckedModeBanner: false,

      // Nome da aplicação.
      title: 'BeeCatalog',

      // Define a HomePage como primeira tela.
      home: const HomePage(),
    );
  }
}

// A HomePage agora é StatefulWidget.
//
// Isso é necessário porque ela irá armazenar
// quais espécies foram marcadas como favoritas.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Classe responsável pelo estado da HomePage.
class _HomePageState extends State<HomePage> {
  // Set armazena os nomes das espécies favoritas.
  //
  // Utilizamos Set porque não queremos permitir
  // valores duplicados.
  final Set<String> favoritos = {};

  // Função responsável por adicionar ou remover
  // uma espécie da lista de favoritos.
  void _alterarFavorito(String nome, bool favorito) {
    // setState informa ao Flutter que houve
    // uma alteração nos dados da tela.
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

  // Função reutilizável para criar os cards das espécies.
  Widget _criarCardAbelha({
    required BuildContext context,
    required String nome,
    required String nomeCientifico,
    required String descricao,
  }) {
    // Verifica se essa espécie está na lista de favoritos.
    final bool estaFavorita = favoritos.contains(nome);

    return Card(
      // Cria um espaço entre os cards.
      margin: const EdgeInsets.only(bottom: 12),

      child: Padding(
        // Espaçamento interno do card.
        padding: const EdgeInsets.all(16),

        // Row organiza os elementos horizontalmente.
        child: Row(
          children: [
            // Representação visual da abelha.
            const Text(
              '🐝',
              style: TextStyle(fontSize: 40),
            ),

            const SizedBox(width: 16),

            // Expanded ocupa o espaço disponível.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome popular da espécie.
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Nome científico da espécie.
                  Text(
                    nomeCientifico,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Mostra um coração caso a espécie
            // esteja marcada como favorita.
            if (estaFavorita)
              const Icon(
                Icons.favorite,
                size: 20,
              ),

            // Botão usado para acessar os detalhes.
            IconButton(
              // onPressed captura o toque do usuário.
              onPressed: () {
                // Navigator.push abre uma nova página.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesPage(
                      // Envia as informações da espécie.
                      nome: nome,
                      nomeCientifico: nomeCientifico,
                      descricao: descricao,

                      // Envia o estado atual do favorito.
                      favoritoInicial: estaFavorita,

                      // Função chamada quando o usuário
                      // altera o favorito na tela de detalhes.
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
    // Scaffold fornece a estrutura principal da tela.
    return Scaffold(
      // Barra superior.
      appBar: AppBar(
        title: const Text('🐝 BeeCatalog'),
      ),

      // ListView permite rolagem vertical.
      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          // Título principal.
          const Text(
            'Conheça as abelhas brasileiras',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Card da Jataí.
          _criarCardAbelha(
            context: context,
            nome: 'Jataí',
            nomeCientifico: 'Tetragonisca angustula',
            descricao:
                'A Jataí é uma abelha sem ferrão amplamente '
                'distribuída no Brasil. É conhecida pelo pequeno '
                'tamanho e pela importância na polinização.',
          ),

          // Card da Mandaçaia.
          _criarCardAbelha(
            context: context,
            nome: 'Mandaçaia',
            nomeCientifico: 'Melipona quadrifasciata',
            descricao:
                'A Mandaçaia é uma abelha sem ferrão do gênero '
                'Melipona. É conhecida pelas faixas claras no '
                'abdômen e possui grande importância ecológica '
                'como polinizadora.',
          ),

          // Card da Iraí.
          _criarCardAbelha(
            context: context,
            nome: 'Iraí',
            nomeCientifico: 'Nannotrigona testaceicornis',
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
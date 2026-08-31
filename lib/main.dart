import 'package:flutter/material.dart';

// Importa a página de detalhes da abelha.
// Esse arquivo está dentro da pasta "pages".
import 'pages/detalhes_page.dart';

// Função principal da aplicação.
// Todo aplicativo Dart começa pela função main().
void main() {
  // runApp inicia a aplicação Flutter.
  // BeeCatalogApp será o primeiro Widget carregado.
  runApp(const BeeCatalogApp());
}

// Widget principal da aplicação.
//
// StatelessWidget é utilizado quando o Widget
// não precisa alterar seu próprio estado.
class BeeCatalogApp extends StatelessWidget {
  const BeeCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp configura a estrutura geral da aplicação.
    return MaterialApp(
      // Remove a faixa "DEBUG" do canto da tela.
      debugShowCheckedModeBanner: false,

      // Define o nome da aplicação.
      title: 'BeeCatalog',

      // Define qual será a primeira tela exibida.
      home: const HomePage(),
    );
  }
}

// Tela inicial do aplicativo.
//
// Também é StatelessWidget porque atualmente
// essa tela não possui informações que mudam dinamicamente.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold fornece a estrutura básica de uma tela Flutter,
    // permitindo utilizar AppBar, body, botões, menus etc.
    return Scaffold(

      // Barra superior da página.
      appBar: AppBar(
        title: const Text('🐝 BeeCatalog'),
      ),

      // Conteúdo principal da tela.
      body: Padding(

        // Cria um espaçamento de 16 pixels
        // entre o conteúdo e as bordas da tela.
        padding: const EdgeInsets.all(16),

        // Column organiza os Widgets verticalmente.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Título da página.
            const Text(
              'Conheça as abelhas brasileiras',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Cria um espaço vertical entre os elementos.
            const SizedBox(height: 20),

            // Card utilizado para representar uma espécie.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                // Row organiza os elementos horizontalmente.
                child: Row(
                  children: [

                    // Representação visual simples da abelha.
                    const Text(
                      '🐝',
                      style: TextStyle(fontSize: 40),
                    ),

                    // Espaçamento horizontal.
                    const SizedBox(width: 16),

                    // Expanded faz o conteúdo ocupar
                    // o espaço disponível dentro da Row.
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Nome popular da espécie.
                          Text(
                            'Jataí',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Nome científico da espécie.
                          Text(
                            'Tetragonisca angustula',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botão utilizado para acessar
                    // a página de detalhes da espécie.
                    IconButton(

                      // onPressed captura o evento de clique/toque.
                      onPressed: () {

                        // Navigator.push realiza a navegação
                        // para uma nova página.
                        Navigator.push(
                          context,

                          // MaterialPageRoute define
                          // qual página será aberta.
                          MaterialPageRoute(
                            builder: (context) =>
                                const DetalhesPage(),
                          ),
                        );
                      },

                      // Ícone exibido no botão.
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
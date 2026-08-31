import 'package:flutter/material.dart';

// Página que apresenta os detalhes da espécie.
//
// StatefulWidget é utilizado porque essa tela possui
// uma informação que pode mudar durante a execução:
// o estado de favorito.
class DetalhesPage extends StatefulWidget {
  const DetalhesPage({super.key});

  @override
  State<DetalhesPage> createState() =>
      _DetalhesPageState();
}

// Classe responsável por armazenar e controlar
// o estado da página DetalhesPage.
class _DetalhesPageState extends State<DetalhesPage> {

  // Variável que indica se a espécie
  // está marcada como favorita.
  //
  // Começa como false (não favoritada).
  bool favorito = false;

  @override
  Widget build(BuildContext context) {

    // Scaffold cria a estrutura principal da página.
    return Scaffold(

      // Barra superior da tela.
      appBar: AppBar(
        title: const Text('Jataí'),
      ),

      // Conteúdo principal.
      body: Padding(
        padding: const EdgeInsets.all(20),

        // Column organiza os elementos verticalmente.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Emoji utilizado como representação da espécie.
            const Center(
              child: Text(
                '🐝',
                style: TextStyle(fontSize: 80),
              ),
            ),

            // Espaçamento entre elementos.
            const SizedBox(height: 20),

            // Nome popular.
            const Text(
              'Jataí',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Nome científico.
            const Text(
              'Tetragonisca angustula',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 20),

            // Texto com uma breve descrição da espécie.
            const Text(
              'A Jataí é uma abelha sem ferrão amplamente '
              'distribuída no Brasil. É conhecida pelo pequeno '
              'tamanho e pela importância na polinização.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // Centraliza o botão de favorito.
            Center(

              // ElevatedButton.icon cria um botão
              // contendo texto e ícone.
              child: ElevatedButton.icon(

                // onPressed é executado quando
                // o usuário toca no botão.
                onPressed: () {

                  // setState informa ao Flutter que
                  // alguma informação da interface mudou.
                  //
                  // Depois disso, o Flutter executa
                  // novamente o método build().
                  setState(() {

                    // O operador ! inverte o valor booleano.
                    //
                    // false -> true
                    // true  -> false
                    favorito = !favorito;
                  });
                },

                // O ícone mostrado depende
                // do valor da variável favorito.
                icon: Icon(
                  favorito
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),

                // O texto do botão também muda
                // conforme o estado da variável.
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
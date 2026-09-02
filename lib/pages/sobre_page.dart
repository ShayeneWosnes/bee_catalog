import 'package:flutter/material.dart';

// Página responsável por apresentar informações
// gerais sobre o aplicativo BeeCatalog.
class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold cria a estrutura básica da tela.
    return Scaffold(
      // Barra superior da página.
      appBar: AppBar(
        title: const Text('Sobre o BeeCatalog'),
      ),

      // SingleChildScrollView permite rolagem
      // caso o conteúdo ultrapasse o tamanho da tela.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          // Alinha os elementos à esquerda.
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Ícone visual do aplicativo.
            const Center(
              child: Text(
                '🐝',
                style: TextStyle(
                  fontSize: 80,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Nome do aplicativo.
            const Center(
              child: Text(
                'BeeCatalog',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Pequena descrição do projeto.
            const Center(
              child: Text(
                'Catálogo de abelhas brasileiras desenvolvido em Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Título da seção de objetivo.
            const Text(
              'Objetivo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Explica o objetivo acadêmico do projeto.
            const Text(
              'O BeeCatalog foi desenvolvido como atividade prática '
              'da disciplina de Programação de Software e Aplicativos II. O aplicativo '
              'demonstra conceitos básicos do desenvolvimento '
              'multiplataforma utilizando Flutter e Dart.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // Título da seção de tecnologias.
            const Text(
              'Tecnologias utilizadas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ListTile cria uma linha com ícone,
            // título e descrição.
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.flutter_dash),
              title: Text('Flutter'),
              subtitle: Text(
                'Framework multiplataforma utilizado para criar a aplicação.',
              ),
            ),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.code),
              title: Text('Dart'),
              subtitle: Text(
                'Linguagem de programação utilizada pelo Flutter.',
              ),
            ),

            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.android),
              title: Text('Android'),
              subtitle: Text(
                'Plataforma utilizada para executar e testar o aplicativo.',
              ),
            ),

            const SizedBox(height: 20),

            // Título da seção de conceitos.
            const Text(
              'Conceitos demonstrados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Wrap organiza pequenos elementos
            // e quebra a linha automaticamente quando necessário.
            Wrap(
              spacing: 8,
              runSpacing: 8,

              children: const [
                Chip(
                  label: Text('Widgets'),
                ),
                Chip(
                  label: Text('StatelessWidget'),
                ),
                Chip(
                  label: Text('StatefulWidget'),
                ),
                Chip(
                  label: Text('Navigator'),
                ),
                Chip(
                  label: Text('Eventos'),
                ),
                Chip(
                  label: Text('setState'),
                ),
                Chip(
                  label: Text('Assets'),
                ),
                Chip(
                  label: Text('Snackbar'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Texto final.
            const Center(
              child: Text(
                'Desenvolvido para fins acadêmicos.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
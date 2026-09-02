// Importa o pacote principal do Flutter.
// Esse pacote traz os widgets que usamos para criar a interface do aplicativo.
import 'package:flutter/material.dart';

// Importa a página que mostra os detalhes de cada espécie de abelha.
import 'pages/detalhes_page.dart';

// Importa a página que mostra informações sobre o BeeCatalog.
import 'pages/sobre_page.dart';



// FUNÇÃO PRINCIPAL


// Todo programa em Dart começa pela função main().
void main() {
  // runApp() inicia o aplicativo Flutter.
  // Aqui estamos dizendo:
  // "Flutter, comece o aplicativo usando BeeCatalogApp".
  runApp(const BeeCatalogApp());
}



// APLICATIVO PRINCIPAL



// Ela é um StatelessWidget porque as configurações principais
// do aplicativo não precisam mudar enquanto ele está funcionando.
class BeeCatalogApp extends StatelessWidget {
  // Construtor da classe.
  const BeeCatalogApp({super.key});

  // O método build() é responsável por montar a interface.
  @override
  Widget build(BuildContext context) {
    // MaterialApp cria a estrutura geral de um aplicativo
    // seguindo o padrão visual Material Design.
    return MaterialApp(
      // Remove a faixa vermelha escrita "DEBUG"
      // que normalmente aparece no canto da tela.
      debugShowCheckedModeBanner: false,

      // Define o nome do aplicativo.
      title: 'BeeCatalog',

      // Define qual será a primeira tela exibida
      // quando o aplicativo for aberto.
      home: const HomePage(),
    );
  }
}



// TELA INICIAL


// HomePage representa a tela inicial do aplicativo.
// Ela é um StatefulWidget porque existem informações
// nessa tela que podem mudar.
// Por exemplo:

// 1. Uma abelha pode ser favoritada ou desfavoritada.

// 2. O usuário pode digitar alguma coisa no campo de pesquisa.

// Quando esses valores mudam, a tela precisa ser atualizada.
class HomePage extends StatefulWidget {
  // Construtor da HomePage.
  const HomePage({super.key});

  // Cria o objeto que será responsável
  // por guardar e controlar o estado da tela.
  @override
  State<HomePage> createState() => _HomePageState();
}



// ESTADO DA TELA INICIAL


// Esta classe guarda todas as informações
// que podem mudar dentro da HomePage.
class _HomePageState extends State<HomePage> {
  

  // FAVORITOS
  

  // Cria um conjunto chamado favoritos.
  // Um Set é parecido com uma lista,
  // mas ele não permite valores repetidos.
  // Aqui guarda os nomes das abelhas favoritadas.
  
  // Exemplo:
  
  // favoritos = {'Jataí', 'Iraí'}
  final Set<String> favoritos = {};



  // PESQUISA
  

  // Guarda o texto que o usuário digitou
  // dentro do campo de pesquisa.
  // No início ele está vazio.
  String pesquisa = '';


  // FUNÇÃO PARA NORMALIZAR O TEXTO
  

  // Esta função prepara um texto para ser pesquisado.
  // Ela transforma todas as letras em minúsculas
  // e também remove alguns acentos.

  // Isso permite, por exemplo:
  
  // Usuário digita: atai
  // Aplicativo encontra:Jataí
  //
  // Mesmo que o usuário não tenha colocado o acento.

  String _normalizarTexto(String texto) {
    // Primeiro transforma tudo em letras minúsculas.
    return texto
        .toLowerCase()

        // Depois substitui letras com acento
        // pelas mesmas letras sem acento.
        .replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('ä', 'a')
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('ë', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ì', 'i')
        .replaceAll('î', 'i')
        .replaceAll('ï', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ò', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('ö', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ù', 'u')
        .replaceAll('û', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ç', 'c');
  }


  
  // FUNÇÃO QUE VERIFICA A PESQUISA
  

  // Esta função verifica se uma determinada abelha
  // combina com aquilo que o usuário pesquisou.

  // A pesquisa funciona usando:
  //
  // 1. Nome popular.
  // 2. Nome científico.
  //
  // Por exemplo:
  //
  // "Jataí"
  // "Tetragonisca"
  //
  // Os dois podem encontrar a mesma abelha.
  bool _correspondePesquisa(
    String nome,
    String nomeCientifico,
  ) {
    // Normaliza o texto digitado pelo usuário.
    //
    // Exemplo:
    //
    // "JATAÍ" vira "jatai".
    final String termoPesquisado = _normalizarTexto(pesquisa);

    // Normaliza o nome popular da abelha.
    final String nomeNormalizado = _normalizarTexto(nome);

    // Normaliza o nome científico.
    final String nomeCientificoNormalizado =
        _normalizarTexto(nomeCientifico);

    // contains() pergunta:
    //
    // "Este texto contém aquilo que foi pesquisado?"
    //
    // O símbolo || significa "OU".
    //
    // Então a função retorna verdadeiro se:
    //
    // o nome popular combinar
    //
    // OU
    //
    // o nome científico combinar.
    return nomeNormalizado.contains(termoPesquisado) ||
        nomeCientificoNormalizado.contains(termoPesquisado);
  }


  
  // FUNÇÃO PARA FAVORITAR OU DESFAVORITAR


  // Esta função recebe:
  //
  // nome = nome da abelha.
  //
  // favorito = true ou false.
  //
  // true significa que a abelha deve ficar favoritada.
  //
  // false significa que ela deve deixar de ser favorita.
  void _alterarFavorito(
    String nome,
    bool favorito,
  ) {
    // setState() avisa ao Flutter:
    //
    // "Alguma informação mudou.
    // Reconstrua a tela para mostrar essa mudança."
    setState(() {
      // Verifica se favorito é verdadeiro.
      if (favorito) {
        // Se for verdadeiro,
        // adicionamos a abelha ao conjunto de favoritos.
        favoritos.add(nome);
      } else {
        // Se for falso,
        // removemos a abelha do conjunto.
        favoritos.remove(nome);
      }
    });
  }


  
  // FUNÇÃO QUE CRIA OS CARDS DAS ABELHAS
  

  // Esta função cria um card de abelha.
  //
  // Nós criamos uma função reutilizável para não precisar
  // escrever praticamente o mesmo código várias vezes.
  //
  // Para criar cada card precisamos informar:
  //
  // nome;
  // nome científico;
  // descrição;
  // imagem.
  Widget _criarCardAbelha({
    required BuildContext context,
    required String nome,
    required String nomeCientifico,
    required String descricao,
    required String imagem,
  }) {
    // Verifica se o nome da abelha está
    // dentro do conjunto de favoritos.
    //
    // O resultado será true ou false.
    final bool estaFavorita = favoritos.contains(nome);

    // Card cria um elemento visual parecido
    // com um cartão.
    return Card(
      // Cria um espaço abaixo de cada card.
      margin: const EdgeInsets.only(bottom: 12),

      // Faz com que elementos internos,
      // como a imagem, respeitem as bordas do card.
      clipBehavior: Clip.antiAlias,

      // Padding cria um espaço interno.
      child: Padding(
        // Cria 12 pixels de espaço
        // entre o conteúdo e as bordas do card.
        padding: const EdgeInsets.all(12),

        // Row organiza seus elementos
        // horizontalmente.
        //
        // Neste caso:
        //
        // imagem -> textos -> coração -> seta.
        child: Row(
          children: [
           
            // IMAGEM DA ABELHA
            

            // ClipRRect permite criar bordas arredondadas
            // na imagem.
            ClipRRect(
              // Define o arredondamento.
              borderRadius: BorderRadius.circular(10),

              // Image.asset carrega uma imagem
              // que está salva dentro da pasta assets.
              child: Image.asset(
                // Caminho da imagem.
                imagem,

                // Largura da imagem.
                width: 75,

                // Altura da imagem.
                height: 75,

                // Faz a imagem preencher o espaço
                // sem ficar deformada.
                fit: BoxFit.cover,
              ),
            ),

            // Cria espaço entre a imagem e os textos.
            const SizedBox(width: 16),

           
            // TEXTOS DO CARD
           

            // Expanded permite que os textos utilizem
            // o espaço disponível dentro da linha.
             Expanded(
              // Column organiza os elementos verticalmente.
              child: Column(
                // Alinha os textos à esquerda.
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Mostra o nome popular.
                  Text(
                    nome,

                    // Configura o estilo do nome.
                    style: const TextStyle(
                      // Define o tamanho da letra.
                      fontSize: 20,

                      // Deixa o nome em negrito.
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Pequeno espaço entre os dois nomes.
                  const SizedBox(height: 3),

                  // Mostra o nome científico.
                  Text(
                    nomeCientifico,

                    // Nome científico aparece em itálico.
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            
            // ÍCONE DE FAVORITO
           

            // Só mostra o coração se a abelha
            // estiver favoritada.
            if (estaFavorita)
              const Icon(
                // Ícone de coração preenchido.
                Icons.favorite,

                // Tamanho do coração.
                size: 20,
              ),

            
            // BOTÃO PARA ABRIR OS DETALHES
            

            // IconButton cria um botão usando um ícone.
            IconButton(
              // onPressed é executado quando
              // o usuário toca no botão.
              onPressed: () {
                // Navigator.push abre uma nova tela
                // sem fechar a tela atual.
                Navigator.push(
                  context,

                  // MaterialPageRoute informa
                  // qual página deve ser aberta.
                  MaterialPageRoute(
                    // Cria a página DetalhesPage.
                    builder: (context) => DetalhesPage(
                      // Envia o nome popular.
                      nome: nome,

                      // Envia o nome científico.
                      nomeCientifico: nomeCientifico,

                      // Envia a descrição.
                      descricao: descricao,

                      // Envia a imagem.
                      imagem: imagem,

                      // Informa se a abelha já estava favorita
                      // antes de abrir a página.
                      favoritoInicial: estaFavorita,

                      // Essa função será chamada quando
                      // o usuário favoritar ou desfavoritar
                      // a abelha na página de detalhes.
                      onFavoritoAlterado: (novoValor) {
                        // Atualiza o favorito
                        // também na tela inicial.
                        _alterarFavorito(
                          nome,
                          novoValor,
                        );
                      },
                    ),
                  ),
                );
              },

              // Mostra uma pequena seta para a direita.
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ),
    );
  }



  // CONSTRUÇÃO DA TELA
  

  // build() monta tudo aquilo que aparece
  // visualmente na HomePage.
  @override
  Widget build(BuildContext context) {
    // Scaffold fornece a estrutura básica
    // de uma tela Flutter.
    return Scaffold(
      
      // BARRA SUPERIOR
      

      // AppBar cria a barra superior da tela.
      appBar: AppBar(
        // Mostra o nome do aplicativo.
        title: const Text(
          '🐝 BeeCatalog',
        ),

        // actions permite colocar botões
        // no lado direito da AppBar.
        actions: [
          // Botão de informações.
          IconButton(
            // Mostra o ícone de informação.
            icon: const Icon(
              Icons.info_outline,
            ),

            // Texto exibido quando o usuário
            // mantém o cursor sobre o botão.
            tooltip: 'Sobre',

            // Executado quando o botão é pressionado.
            onPressed: () {
              // Abre a página SobrePage.
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


   
      // CONTEÚDO DA TELA
     

      // ListView organiza os elementos
      // verticalmente.
      //
      // Ela também permite rolar a tela
      // caso o conteúdo seja maior que o celular.
      body: ListView(
        // Cria espaço entre o conteúdo
        // e as bordas da tela.
        padding: const EdgeInsets.all(16),

        children: [
          
          // TÍTULO
          

          // Mostra o título principal.
          const Text(
            'Conheça as abelhas brasileiras',

            // Configura o estilo do título.
            style: TextStyle(
              // Tamanho da letra.
              fontSize: 22,

              // Deixa o texto em negrito.
              fontWeight: FontWeight.bold,
            ),
          ),

          // Espaço abaixo do título.
          const SizedBox(height: 16),


          
          // CAMPO DE PESQUISA
         

          // TextField permite que o usuário
          // digite alguma coisa.
          TextField(
            // Configura a aparência do campo.
            decoration: InputDecoration(
              // Texto que aparece quando
              // o campo ainda está vazio.
              hintText: 'Pesquisar abelha...',

              // Mostra uma lupa do lado esquerdo.
              prefixIcon: const Icon(
                Icons.search,
              ),

              // Define a borda do campo.
              border: OutlineInputBorder(
                // Deixa os cantos arredondados.
                borderRadius: BorderRadius.circular(14),
              ),

              // Define o espaço interno do campo.
              contentPadding:
                  const EdgeInsets.symmetric(
                // Espaço horizontal.
                horizontal: 16,

                // Espaço vertical.
                vertical: 12,
              ),
            ),

            // onChanged é chamado toda vez
            // que o usuário digita ou apaga uma letra.
            onChanged: (valorDigitado) {
              // setState avisa que alguma informação mudou.
              setState(() {
                // Guarda o novo texto na variável pesquisa.
                pesquisa = valorDigitado;
              });
            },
          ),

          // Espaço entre a pesquisa e os cards.
          const SizedBox(height: 16),


          
          // JATAÍ
          

          // Antes de criar o card da Jataí,
          // verifica se ela combina com o que foi pesquisado.
          if (_correspondePesquisa(
            'Jataí',
            'Tetragonisca angustula',
          ))
            // Se combinar, o card aparece.
            _criarCardAbelha(
              // Contexto atual da tela.
              context: context,

              // Nome popular.
              nome: 'Jataí',

              // Nome científico.
              nomeCientifico:
                  'Tetragonisca angustula',

              // Caminho da imagem.
              imagem:
                  'assets/images/jatai.webp',

              // Texto mostrado na página de detalhes.
              descricao:
                  'A Jataí é uma abelha sem ferrão amplamente '
                  'distribuída no Brasil. É conhecida pelo pequeno '
                  'tamanho e pela importância na polinização.',
            ),


          
          // MANDAÇAIA
          

          // Verifica se a Mandaçaia combina
          // com aquilo que foi pesquisado.
          if (_correspondePesquisa(
            'Mandaçaia',
            'Melipona quadrifasciata',
          ))
            // Se combinar, mostra o card.
            _criarCardAbelha(
              // Contexto atual.
              context: context,

              // Nome popular.
              nome: 'Mandaçaia',

              // Nome científico.
              nomeCientifico:
                  'Melipona quadrifasciata',

              // Caminho da imagem.
              imagem:
                  'assets/images/mandacaia.webp',

              // Descrição da espécie.
              descricao:
                  'A Mandaçaia é uma abelha sem ferrão do gênero '
                  'Melipona. É conhecida pelas faixas claras no '
                  'abdômen e possui grande importância ecológica '
                  'como polinizadora.',
            ),


          
          // IRAÍ
         

          // Verifica se a Iraí combina
          // com aquilo que foi pesquisado.
          if (_correspondePesquisa(
            'Iraí',
            'Nannotrigona testaceicornis',
          ))
            // Se combinar, mostra o card.
            _criarCardAbelha(
              // Contexto atual.
              context: context,

              // Nome popular.
              nome: 'Iraí',

              // Nome científico.
              nomeCientifico:
                  'Nannotrigona testaceicornis',

              // Caminho da imagem.
              imagem:
                  'assets/images/irai.webp',

              // Descrição da espécie.
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
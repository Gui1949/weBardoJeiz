import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final List<String> bebidas = <String>[
  '51',
  'Dreher',
  'Velho Barreiro',
  'Glacial'
];

final List<String> descricao = [
  'A melhor cachaça dessa porra, eu fico até puto.',
  'Um Conhaque clássico para um homem clássico.',
  'A cachaça mais idosa e tradicional do Brasil.',
  'Essa aí nós tomamos.'
];

// ['51', 'A melhor cachaça dessa porra, eu fico até puto.', 'https://http2.mlstatic.com/D_NQ_NP_694197-MLB42691722065_072020-O.jpg']

final List<String> ibageis = [
  'https://http2.mlstatic.com/D_NQ_NP_694197-MLB42691722065_072020-O.jpg',
  'https://http2.mlstatic.com/D_NQ_NP_968486-MLB43566973599_092020-O.jpg',
  'https://http2.mlstatic.com/D_NQ_NP_938683-MLB43182195751_082020-O.jpg',
  'http://3.bp.blogspot.com/-GdH9PoDlLn0/UkJAKa4pLHI/AAAAAAAAAH0/Ib0hdYTPT6Q/s1600/SNC01499.jpg'
];

final List<String> opiniao = [
  'A Minha opinião mais que sincera sobre essa bebida, prevalece-se do sabor inigualável de cana, do seu modo mais puro possível. A cachaça 51 é uma das sete maravilhas do nosso querido globo terrestre. Sem mais.',
  'Dreher, um clássico conhaque tupiniquim, com uma majestosa história e um sabor inigualável. O melhor amigo do homem, tanto em seus momentos de solidão, quanto em suas mais badaladas confraternzações. Sem mais.',
  'Seria um subterfúgio da minha parte dizer que a frase "Chama o Velho" não é uma das mais ditas nos Bares da nossa querida terras brasilis. Velho Barreiro, além de ser um clássico nacional, ja faz parte do dia a dia do Brasileiro. Sem mais.',
  'Admito, nas outras análises, paguei para que um escritor muito famoso as elaborasse. Glacial é foda cara, é do caralho, puta que pariu. Essa aí eu bebo até quente, no calor do deserto do Saara. Sem mais.'
];

class Args {
  final int id;
  Args(this.id);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeBar do Jeiz',
      initialRoute: '/',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF282a36),
          colorScheme: ColorScheme.dark(),
          scaffoldBackgroundColor: Color(0xFF282a36)),
      routes: {
        '/': (context) => MyHomePage(title: 'WeBar do Jeiz'),
        '/detalhes': (context) => TelaDetalhes(),
        '/opiniao': (context) => TelaOpiniao()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemCount: bebidas.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/detalhes',
                      arguments: Args(index));
                },
                title: Text(bebidas[index]));
          }),
    );
  }
}

class TelaDetalhes extends StatelessWidget {
  // const TelaDetalhes({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Args;

    return Scaffold(
        appBar: AppBar(title: Text('Detalhes do Produto')),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(children: [
            Image.network(
              ibageis[args.id],
              width: 500,
              height: 160,
              fit: BoxFit.cover,
            ),
            Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  bebidas[args.id],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            Text(descricao[args.id]),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround, //Alinhar!!!!!!
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                          title: Text('Alerta'),
                          content: Text('O produto foi adicionado ao carrinho.'),
                        )),
                    child: Row(
                      children: [
                        Text('Comprar'),
                        Icon(Icons.add_shopping_cart)
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pushNamed(context, '/opiniao',
                        arguments: Args(args.id)),
                    child: Row(
                      children: [Text('Analise'), Icon(Icons.policy)],
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }
}

class TelaOpiniao extends StatelessWidget {
  const TelaOpiniao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Args;

    return Scaffold(
        appBar: AppBar(title: Text('Opinião sincera do Jeiz')),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                bebidas[args.id],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('por Jeiz', style: TextStyle(fontStyle: FontStyle.italic)),
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  opiniao[args.id],
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ));
  }
}

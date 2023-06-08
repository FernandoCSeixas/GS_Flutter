import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Monitoramento de Plantações',
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/imagens': (context) => ImagensScreen(),
        '/historico': (context) => HistoricoScreen(),
      },
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoramento de Plantações'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Bem-vindo ao Monitoramento de Plantações! Utilize os botões abaixo para conseguir detalhes sobre as platações, no momento estão sendo monitoradas 2 plantações diferentes',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/imagens');
              },
              child: Text('Imagens Capturadas'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/historico');
              },
              child: Text('Histórico'),
            ),
          ],
        ),
      ),
    );
  }
}
class ImageInfo {
  final int id;
  final String imageUrl;
  final String tipoDePlantacao;
  final String numeroPragas;
  final String irrigacao;

  ImageInfo({
    required this.id,
    required this.imageUrl,
    required this.tipoDePlantacao,
    required this.numeroPragas,
    required this.irrigacao,
  });
}
class ImagensScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ImageInfo> imageInfos = [
      ImageInfo(
        id: 1,
        imageUrl:
            'https://nutricaodesafras.com.br/wp-content/uploads/2023/03/plantacao-milh-mosaic.jpg',
        tipoDePlantacao: 'Milho',
        numeroPragas: 'Pragas detectadas: 1',
        irrigacao: 'Necessidade de irrigação: Média',
      ),
      ImageInfo(
        id: 2,
        imageUrl:
            'https://blog.aegro.com.br/wp-content/uploads/2020/03/plantio-de-trigo-original.jpg',
        tipoDePlantacao: 'Trigo',
        numeroPragas: 'Pragas detectadas: 3',
        irrigacao: 'Necessidade de irrigação: Alta',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagens Capturadas'),
      ),
      body: ListView.builder(
        itemCount: imageInfos.length,
        itemBuilder: (BuildContext context, int index) {
          ImageInfo imageInfo = imageInfos[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnaliseScreen(imageInfo: imageInfo),
                ),
              );
            },
            leading: Image.network(
              imageInfo.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(imageInfo.tipoDePlantacao),
            subtitle: Text(imageInfo.id.toString()),
          );
        },
      ),
    );
  }
}
class AnaliseScreen extends StatelessWidget {
  final ImageInfo imageInfo;
  AnaliseScreen({required this.imageInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações Gerais'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageInfo.imageUrl,
              width: 300,
              height: 300,
            ),
            Text(
              'Tipo de Plantação: ${imageInfo.tipoDePlantacao}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(imageInfo.id.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                )),
            SizedBox(height: 16.0),
            Text(
              imageInfo.numeroPragas,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              imageInfo.irrigacao,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
String generateImageId(int index) {
  return 'IMG-${index + 1}';
}
class HistoricoScreen extends StatelessWidget {
  final List<ImageInfo> historico = [
    ImageInfo(
      id: 1,
      imageUrl:
          'https://nutricaodesafras.com.br/wp-content/uploads/2023/03/plantacao-milh-mosaic.jpg',
      tipoDePlantacao: 'Milho',
      numeroPragas: 'Pragas detectadas: 3',
      irrigacao: 'Necessidade de irrigação: Média',
    ),
    ImageInfo(
      id: 2,
      imageUrl:
          'https://blog.aegro.com.br/wp-content/uploads/2020/03/plantio-de-trigo-original.jpg',
      tipoDePlantacao: 'Trigo',
      numeroPragas: 'Pragas detectadas: 3',
      irrigacao: 'Necessidade de irrigação: Alta',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico'),
      ),
      body: ListView.builder(
        itemCount: historico.length,
        itemBuilder: (BuildContext context, int index) {
          ImageInfo imageInfo = historico[index];
          return ListTile(
            leading: Image.network(
              imageInfo.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(imageInfo.tipoDePlantacao),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(imageInfo.numeroPragas),
                Text(imageInfo.irrigacao),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetalhesHistoricoScreen(imageInfo: imageInfo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class DetalhesHistoricoScreen extends StatelessWidget {
  final ImageInfo imageInfo;
  DetalhesHistoricoScreen({required this.imageInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Histórico'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes da Imagem:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Image.network(
              imageInfo.imageUrl,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Tipo de Plantação: ${imageInfo.tipoDePlantacao}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Análises Anteriores:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              imageInfo.numeroPragas,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              imageInfo.irrigacao,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:distribuidora_ilha_grande/login.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Layout.primary(),
        accentColor: Layout.secondary(),
        textTheme: TextTheme(
          headline5: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
          headline6: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Layout.primary(),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      //home: MyHomePage(title: 'Distribuidora Ilha Grandes'),
      routes: {
        '/': (context) => LoginPage(),
        'home': (context) => MyHomePage(title: 'Distribuidora Ilha Grandes'),

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget content = FutureBuilder(
      future: getData,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
          
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: RefreshProgressIndicator());
        }

        var result = ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            var item = snapshot.data[index];

            return ListTile(
              leading: Icon(Icons.people, size: 52),
              title: Text("Água Ilha Grande"),
              //title: Text("${item['nome']}"),
              // title: Text(nome),
              subtitle: Text("Valor total: ${item['valorTotal']}0"),
              // trailing: RaisedButton(
              //   onPressed: () {},
              //   child: Text('Aperte-me', style: TextStyle(color: Layout.light())),
              // ),
            );
          },
        );

        return result;
      },
    );
    return Layout.render(Column(
      children: <Widget>[
         Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          height: 150,
          child: Image(
                  image: AssetImage('assets/banner_ilhagrande.png'),
                  fit: BoxFit.fill,
                ),
          ),
        Container(
          height: 100,
          color: Layout.light(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 5,),
              Padding(
                padding:EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Container(
                height: 80,
                width: 90,
                color: Layout.info(),
                child: Image(
                  image: AssetImage('assets/foto_app.png'),
                  fit: BoxFit.fill,
                )
               ),
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Container(
                height: 80,
                width: 90,
                color: Layout.info(),
                child: Image(
                  image: AssetImage('assets/foto_app.png'),
                  fit: BoxFit.fill,
                )
               ),
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Container(
                height: 80,
                width: 90,
                color: Layout.info(),
                child: Image(
                  image: AssetImage('assets/foto_app.png'),
                  fit: BoxFit.fill,
                )
               ),
              ),
              SizedBox(width: 5,),
            ],
          )
        ),
        Expanded(child: content),
      ],));
  }


  Future<List<Map<String, dynamic>>> get getData async {
    var docs = await Firestore.instance.collection('pedido').getDocuments();
    var result = <Map<String, dynamic>>[];
    
    for (DocumentSnapshot doc in docs.documents) {
      
      DocumentSnapshot client = await doc.data['cliente'].get();
      result.add({
        "nome": client.data['nome'],
        "valorTotal": doc.data['valor_total'],
        "quantidade": doc.data['qtd'],
      });
    }
    return result;
  }
}
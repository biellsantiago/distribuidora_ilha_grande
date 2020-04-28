import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distribuidora Ilha Grande',
      theme: ThemeData(
        primaryColor: Layout.primary(),
        accentColor: Layout.secondary(),
        textTheme: TextTheme(
          headline: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
          title: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Layout.primary(),
          textTheme: ButtonTextTheme.normal,
        ),
      ),
      home: MyHomePage(title: 'Distribuidora Ilha Grande 1'),
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
      future: getData(),
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
              title: Text("${item['nome']}"),
              // title: Text(nome),
              subtitle: Text("Valor total: ${item['valorTotal']}"),
              trailing: RaisedButton(
                onPressed: () {},
                child: Text('Aperte-me', style: TextStyle(color: Layout.light())),
              ),
            );
          },
        );

        return result;
      },
    );
    return Layout.render(content);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var docs = await Firestore.instance.collection('pedido').getDocuments();
    var result = <Map<String, dynamic>>[];

    for (DocumentSnapshot doc in docs.documents) {
      DocumentSnapshot client = await doc.data['cliente'].get();

      result.add({
        "nome": client.data['nome'],
        "valorTotal": doc.data['valor_total'],
      });
    }

    return result;
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Baby Names',
//      home: MyHomePage(),
//    );
//  }
// }

// class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() {
//    return _MyHomePageState();
//  }
// }

// class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Distribuidora Ilha Grande 1')),
//      body: _buildBody(context),
//    );
//  }

//  Widget _buildBody(BuildContext context) {
//  return StreamBuilder<QuerySnapshot>(
//    stream: Firestore.instance.collection('bandnames').snapshots(),
//    builder: (context, snapshot) {
//      if (!snapshot.hasData) return LinearProgressIndicator();

//      return _buildList(context, snapshot.data.documents);
//    },
//  );
// }

//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//  final record = Record.fromSnapshot(data);

//    return Padding(
//      key: ValueKey(record.name),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: ListTile(
//          title: Text(record.name),
//          trailing: Text(record.votes.toString()),
//          onTap: () => print(record),
//        ),
//      ),
//    );
//  }
// }

// class Record {
//  final String name;
//  final int votes;
//  final DocumentReference reference;

//  Record.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['name'] != null),
//        assert(map['votes'] != null),
//        name = map['name'],
//        votes = map['votes'];

//  Record.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);

//  @override
//  String toString() => "Record<$name:$votes>";
// }

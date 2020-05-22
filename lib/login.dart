import 'package:distribuidora_ilha_grande/layout.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    // Captura o tema do titulo
    TextStyle titleTheme = Theme.of(context).textTheme.headline6.copyWith(
          color: Layout.light(),
        );

    return Scaffold(
      backgroundColor: Layout.primaryDark(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Layout.light(),
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(160),
                      color: Layout.dark(.8),
                    ),
                    child: Image.asset('assets/foto_app.png'),
                  ),
                  borderRadius: BorderRadius.circular(170),
                ),
                SizedBox(height: 20),
                Text('Distribuidora Ilha Grande', style: titleTheme),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Layout.dark(),
                        offset: const Offset(0, 0),
                        spreadRadius: 8,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Layout.light(),
                ),
                height: MediaQuery.of(context).size.height * .5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                        initialValue: 'Email',
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                        initialValue: 'Senha',
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'ENTRAR',
                            style: titleTheme,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Layout {
//https://material.io/resources/color/#!/?view.left=0&view.right=1&primary.color=4450aa&secondary.color=45a348

  static Widget render(Widget content,
      [String title = 'Destribuidora Ilha Grande']) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  static Color primary([double opacity = 1]) => Colors.indigo[500].withOpacity(opacity);
  static Color primaryLight([double opacity = 1]) => Color(0xff757de8).withOpacity(opacity);
  static Color primaryDark([double opacity = 1]) => Color(0xff002984).withOpacity(opacity);

  static Color secondary([double opacity = 1]) => Color(0xff45a348).withOpacity(opacity);
  static Color secondaryLight([double opacity = 1]) => Color(0xff78d576).withOpacity(opacity);
  static Color secondaryDark([double opacity = 1]) => Color(0xff00731b).withOpacity(opacity);

  static Color light([double opacity = 1]) => Color.fromRGBO(230, 230, 230, opacity);
  static Color dark([double opacity = 1]) => Color(0xff333333).withOpacity(opacity);

  static Color danger([double opacity = 1]) => Color.fromRGBO(217, 74, 74, opacity);
  static Color sucess([double opacity = 1]) => Color.fromRGBO(5, 100, 50, opacity);
  static Color info([double opacity = 1]) => Color.fromRGBO(100, 150, 255, opacity);
  static Color warning([double opacity = 1]) => Color.fromRGBO(250, 200, 70, opacity);
}

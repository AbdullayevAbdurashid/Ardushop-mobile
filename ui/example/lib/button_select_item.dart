import 'package:flutter/material.dart';
import 'package:ui/debug.dart';
import 'package:ui/ui.dart';

class ButtonSelectItemScreen extends StatelessWidget {
  const ButtonSelectItemScreen({Key? key}) : super(key: key);

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
          title: const Text('Button Select Item'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Button select default'),
              ButtonSelect(
                child: const Text('A'),
                onTap: () => avoidPrint('click'),
              ),
              ButtonSelect(
                isSelect: true,
                onTap: () => avoidPrint('click'),
                child: const Text('A'),
              ),
              ButtonSelect.icon(
                child: const Text('Flat Rate : \$10'),
                onTap: () => avoidPrint('click'),
              ),
              ButtonSelect.icon(
                isSelect: true,
                onTap: () => avoidPrint('click'),
                child: const Text('Flat Rate : \$10'),
              ),
              ButtonSelect.filter(
                child: const Text('Flat Rate : \$10'),
                onTap: () => avoidPrint('click'),
              ),
              ButtonSelect.filter(
                isSelect: true,
                onTap: () => avoidPrint('click'),
                child: const Text('Flat Rate : \$10'),
              ),
            ],
          ),
        ));
  }
}

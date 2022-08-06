import 'package:flutter/material.dart';
import 'package:ui/debug.dart';
import 'package:ui/ui.dart';

class CommentHorizontalItemScreen extends StatelessWidget {
  const CommentHorizontalItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding10 = const EdgeInsets.symmetric(vertical: 10);
    String name = 'Livisa';
    Text comment =const Text('Lorem Ipsum is simply dummy text of the avoidPrinting \nand typesetting industry',
        style: TextStyle(color: Colors.black));
    Text date = const  Text('12/12/2020', style: TextStyle(color: Colors.black));
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
          title: const Text('Category Post Item'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.5),
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
              CommentHorizontalItem(
                image: 'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                name: Text(name),
                date: date,
                comment: comment,
                onClick: () => avoidPrint('click'),
              ),
              Padding(
                padding: padding10,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              CommentHorizontalItem(
                image: 'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                name: Text(name),
                date: date,
                reply: InkWell(
                  onTap: () {},
                  child:const Text('REPLY'),
                ),
                comment: comment,
                onClick: () => avoidPrint('click'),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Column(children: [
                    Padding(
                      padding: padding10,
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    CommentHorizontalItem(
                      image: 'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                      name: Text(name),
                      date: date,
                      comment: comment,
                      onClick: () => avoidPrint('click'),
                      reply: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('REPLY'),
                          OutlinedButton(
                            onPressed: () {
                              avoidPrint('Feedback');
                            },
                            child:const Text("3 Feedback"),
                          )
                        ],
                      ),
                    ),
                  ])),
              Padding(
                padding: padding10,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                ),
              ),
              const Text('Comment rating(***)', style: TextStyle(color: Colors.blue)),
              CommentHorizontalItem(
                image: 'https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                name: Text(name),
                date: date,
                rating:const Text('*****', style: TextStyle(color: Colors.black)),
                comment: comment,
                onClick: () => avoidPrint('click'),
              ),
              const Text('Comment post', style: TextStyle(color: Colors.blue)),
              CommentHorizontalPost(
                  name: const Text('user'),
                  post: const Text('post'),
                  date: const Text('date'),
                  comment: comment,
                  image: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/01/b1-1.jpg',
                        width: 48, height: 48),
                  ),
                  onClick: () => {})
            ],
          ),
        ));
  }
}

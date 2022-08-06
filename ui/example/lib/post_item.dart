import 'package:flutter/material.dart';
import 'package:ui/debug.dart';
import 'package:ui/ui.dart';

String image =
    'https://img.freepik.com/free-photo/white-cube-product-stand-white-room-studio-scene-product-minimal-design-3d-rendering_184920-218.jpg?size=338&ext=jpg';

class PostItemScreen extends StatelessWidget {
  const PostItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height20 = 20;
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
          title:const Text('Post Item'),
        ),
        body: SingleChildScrollView(
          padding:const EdgeInsets.all(16),
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
              PostContainedItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(image),
                ),
                name:const Text('PostContainedItem'),
                category: const Text(
                  'Category',
                  style: TextStyle(color: Colors.white),
                ),
                date: const Text('date'),
                author: const Text('author'),
                comment: const Text('comment'),
                onClick: () => avoidPrint('click'),
              ),
              PostContainedItem(
                image: Image.network(
                  image,
                ),
                name:const Text('PostContainedItem'),
                date: const Text('date'),
                author: const Text('author'),
                comment: const Text('comment'),
                onClick: () => avoidPrint('click'),
                borderRadius: BorderRadius.circular(8),
                paddingContent: const EdgeInsets.all(16),
              ),
              SizedBox(height: height20),
              PostHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                ),
                name:const Text('Test PostHorizontalItem'),
                date: const Text('10/02/1990'),
                author: const Text('author'),
                comment: const Text('comment'),
                category: const Text('category'),
                onClick: () => avoidPrint('click'),
                // elevation: 10,
              ),
              PostHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                ),
                name:const Text('Test PostHorizontalItem'),
                date: const Text('10/02/1990'),
                author: const Text('author'),
                comment: const Text('comment'),
                category: const Text('category'),
                onClick: () => avoidPrint('click'),
              ),
              PostHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 120,
                    height: 120,
                  ),
                ),
                name:const Text('Test PostHorizontalItem'),
                date: const Text('10/02/1990'),
                author: const Text('author'),
                comment: const Text('comment'),
                category: const Text('category'),
                onClick: () => avoidPrint('click'),
                isRightImage: true,
              ),
              SizedBox(height: height20),
              // PostHorizontalItem(
              //   post: post,
              //   isLeftImage: false,
              // ),
              PostNumberItem(
                number:const Text(
                  '01',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500, color: Color(0xFF0686F8)),
                ),
                name: const Text('Name PostNumberItem'),
                category: const Text('category'),
                date: const Text('10/02/1990'),
                author: const Text('author'),
                comment: const Text('comment'),
                onClick: () => avoidPrint('click'),
              ),
              PostOverlayItem(
                image: Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                ),
                name:const Text('PostOverlayItem', style: TextStyle(color: Colors.white)),
                category: const Text('Category', style: TextStyle(color: Colors.white)),
                date: const Text('date', style: TextStyle(color: Colors.white)),
                author: const Text('author', style: TextStyle(color: Colors.white)),
                comment: const Text('comment', style: TextStyle(color: Colors.white)),
                excerpt: const Text('description', style: TextStyle(color: Colors.white)),
                onClick: () => avoidPrint('click'),
              ),
              PostGradientItem(
                image: Image.network(
                  image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 400,
                ),
                name:const Text('PostGradientItem', style: TextStyle(color: Colors.white)),
                category: const Text('Category', style: TextStyle(color: Colors.white)),
                date: const Text('date', style: TextStyle(color: Colors.white)),
                author: const Text('author', style: TextStyle(color: Colors.white)),
                comment: const Text('comment', style: TextStyle(color: Colors.white)),
                description: const Text('description', style: TextStyle(color: Colors.white)),
                onClick: () => avoidPrint('click'),
              ),
              PostVerticalItem(
                image: Image.network(
                  image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                name:const Text('PostVerticalItem'),
                category: const Text('Category'),
                date: const Text('date'),
                author: const Text('author'),
                comment: const Text('comment'),
                excerpt: const Text('description'),
                onClick: () => avoidPrint('click'),
                width: 200,
              ),
              PostEmergeItem(
                image: Image.network(
                  image,
                  width: 335,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                name:const Text('PostEmergeItem'),
                category: const Text('Category'),
                date: const Text('date'),
                author: const Text('author'),
                comment: const Text('comment'),
                excerpt: const Text('description'),
                onClick: () => avoidPrint('click'),
                width: 335,
              ),
              PostTimeLineItem(
                image: Image.network(
                  image,
                  width: 335,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                name:const Text('PostTimeLineItem'),
                category: const Text('Category'),
                headingInfo: const Text('Heading'),
                left: const Text('left'),
                description: const Text('description'),
                onClick: () => avoidPrint('click'),
              ),
              SizedBox(height: height20),
              PostTopNameItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 335,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                name:const Text('PostTopNameItem'),
                category: const Text('Category'),
                date: const Text('date'),
                author: const Text('author'),
                comment: const Text('comment'),
                excerpt: const Text('description'),
                onClick: () => avoidPrint('click'),
              ),
              SizedBox(height: height20),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

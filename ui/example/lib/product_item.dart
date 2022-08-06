import 'package:flutter/material.dart';
import 'package:ui/debug.dart';
import 'package:ui/ui.dart';

class ProductItemScreen extends StatelessWidget {
  const ProductItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    String image =
        'https://static.remove.bg/remove-bg-web/8be32deab801c5299982a503e82b025fee233bd0/assets/start-0e837dcc57769db2306d8d659f53555feb500b3c5d456879b9c843d1872e7baa.jpg';
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title:const Text('Product Item'),
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
              const SizedBox(
                height: 15,
              ),
              ProductCurveItem(
                image: Image.network(
                  image,
                  width: 300,
                  height: 200,
                ),
                name: const Text('title'),
                price: const Text('price'),
                rating: const Text('ratting'),
                addCard: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                tagExtra: const Text('extra'),
                wishlist: const Text('wishlist'),
                onClick: () {},
                width: 300,
                color: Colors.yellow,
              ),
              const SizedBox(
                height: 15,
              ),
              ProductCardVerticalItem(
                image: Image.network(
                  image,
                  width: 300,
                  height: 200,
                ),
                name: const Text('title'),
                price: const Text('price'),
                category: const Text('category'),
                rating: const Text('ratting'),
                addCard: const Text('add card'),
                tagExtra: const Text('extra'),
                wishlist: const Text('wishlist'),
                onClick: () {},
                width: 300,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 20),
              ProductCardHorizontalItem(
                image: Image.network(
                  image,
                  width: 300,
                  height: 200,
                ),
                name: const Text('title'),
                category: const Text('category'),
                tagExtra: const Text('tag'),
                addCart: const Text('add'),
                wishlist: const Text('wishlist'),
                onClick: () {},
                width: 300,
              ),
              const SizedBox(
                height: 15,
              ),
              ProductContainedItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                  ),
                ),
                name: const Text('Name'),
                price: const Text('Price'),
                tagExtra: const Text(
                  'Tax Extra',
                  style: TextStyle(color: Colors.white),
                ),
                wishlist: const Text('wishlist'),
                addCard: const Text('Button add', style:  TextStyle(color: Colors.white)),
                rating: const Text('rating'),
                onClick: () => avoidPrint('product'),
              ),
              const SizedBox(
                height: 15,
              ),
              ProductHorizontalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 70,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                ),
                name: const Text('Name'),
                price: const Text('Price'),
                tagExtra: const Text('Tax Extra'),
                addCard: const Text('Button add'),
                rating: const Text('rating'),
                onClick: () => avoidPrint('product'),
              ),
              const SizedBox(
                height: 15,
              ),
              ProductCartItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 70,
                    height: 102,
                    fit: BoxFit.cover,
                  ),
                ),
                name: const Text('Name'),
                price: const Text('Price'),
                quantity: const Text('quantity'),
                attribute: const Text('attribute'),
                onClick: () => avoidPrint('product'),
              ),
              ProductEmergeItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 160,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                name: const Text('Name'),
                price: const Text('Price'),
                category: const Text('Category'),
                tagExtra: const Text(
                  'Tax',
                  style: TextStyle(color: Colors.white),
                ),
                addCart: Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: const Text('A'),
                ),
                rating: const Text('rating'),
                wishlist: const Text('W'),
                onClick: () => avoidPrint('product'),
                width: 160,
              ),
              const SizedBox(height: 20),
              const Text('ProductVerticalItem'),
              const SizedBox(height: 12),
              ProductVerticalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 160,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                name: const Text('Name'),
                price: const Text('Price'),
                category: const Text('Category'),
                tagExtra: const Text(
                  'Tax',
                  style:  TextStyle(color: Colors.white),
                ),
                addCard: Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: const Text('A'),
                ),
                rating: const Text('rating'),
                wishlist: const Text('W'),
                onClick: () => avoidPrint('product'),
                width: 160,
              ),
              const SizedBox(height: 20),
              const Text('ProductVerticalItem center'),
              const SizedBox(height: 12),
              ProductVerticalItem(
                image: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    width: 160,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
                name: const Text('Name'),
                price: const Text('Price'),
                category: const Text('Category'),
                tagExtra: const Text(
                  'Tax',
                  style:  TextStyle(color: Colors.white),
                ),
                addCard: Container(
                  height: 34,
                  width: 100,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text('A'),
                ),
                rating: const Text('rating'),
                wishlist: const Text('W'),
                onClick: () => avoidPrint('product'),
                width: 160,
                type: ProductVerticalItemType.center,
              ),
            ],
          ),
        ));
  }
}

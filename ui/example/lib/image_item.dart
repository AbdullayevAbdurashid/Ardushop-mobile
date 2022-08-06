import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class ImageItemScreen extends StatelessWidget {
  const ImageItemScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height30 = 30;
    double height10 = 10;
    TextStyle textStyle = const TextStyle(color: Colors.red);
    EdgeInsets padding24 = const EdgeInsets.all(24);
    EdgeInsets paddingVer60 = const EdgeInsets.symmetric(horizontal: 24, vertical: 60);
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
        title: const Text('Image Item'),
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
            const Text('Style1 - ImageContainedItem'),
            SizedBox(height: height10),
            ImageFooterItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              title: Text('Title', style: textStyle),
              subTitle: Text('Subtitle', style: textStyle),
              footer: Text('Footer', style: textStyle),
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style2 - ImageContainedItem'),
            SizedBox(height: height10),
            ImageFooterItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              footer: Text('Footer', style: textStyle),
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style3 - ImageAlignmentItem'),
            SizedBox(height: height10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: textStyle),
              title: Text('title', style: textStyle),
              trailing: Text('trailing', style: textStyle),
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: paddingVer60,
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style4 - ImageAlignmentItem'),
            SizedBox(height: height10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: textStyle),
              trailing: Text('trailing', style: textStyle),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              padding: paddingVer60,
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style5 - ImageAlignmentItem'),
            SizedBox(height: height10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: textStyle),
              title: Text('Title', style: textStyle),
              trailing: Text('trailing', style: textStyle),
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style6 - ImageFooterItem'),
            SizedBox(height: height10),
            ImageFooterItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              title: Container(
                alignment: Alignment.centerRight,
                child: Text('Title', style: textStyle),
              ),
              footer: Text('Footer', style: textStyle),
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style7 - ImageAlignmentItem'),
            SizedBox(height: height10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: textStyle),
              trailing: Text('trailing', style: textStyle),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              padding: padding24,
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Style8 - ImageAlignmentItem'),
            SizedBox(height: height10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: textStyle),
              title: Text('title', style: textStyle),
              trailing: Container(
                alignment: Alignment.centerRight,
                child: Text('trailing', style: textStyle),
              ),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: padding24,
              onTap: (){},
            ),
            SizedBox(height: height30),
            const Text('Slideshow style 1 - ImageAlignmentItem'),
            SizedBox(height: height10),
            ImageAlignmentItem(
              image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
              leading: Text('leading', style: textStyle),
              title: Text('title', style: textStyle),
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: padding24,
              onTap: (){},
            ),
            const Text('Slideshow style 2 - ImageFooterItem'),
            SizedBox(height: height10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageFooterItem(
                image: Image.network('https://grocery.rnlab.io/wp-content/uploads/2021/02/99.jpg'),
                title: Text('Title', style: textStyle),
                subTitle: Text('Subtitle', style: textStyle),
                footer: Text('Footer', style: textStyle),
                crossAxisAlignment: CrossAxisAlignment.start,
                onTap: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}

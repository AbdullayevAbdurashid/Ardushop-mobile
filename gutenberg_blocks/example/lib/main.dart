import 'package:flutter/material.dart';

/// Rehub
import 'example/rehub/info_box.dart';
import 'example/rehub/title_box.dart';
import 'example/rehub/double_heading.dart';
import 'example/rehub/offer_box.dart';
import 'example/rehub/post_offer_box.dart';
import 'example/rehub/review_box.dart';
import 'example/rehub/cons_pros.dart';
import 'example/rehub/accordion.dart';
import 'example/rehub/post_offer_listing.dart';
import 'example/rehub/offer_listing.dart';
import 'example/rehub/woocommerce_list.dart';
import 'example/rehub/versus_table.dart';
import 'example/rehub/woocommerce_box.dart';
import 'example/rehub/itinerary.dart';
import 'example/rehub/slider.dart';
import 'example/rehub/pretty_list.dart';
import 'example/rehub/promo_box.dart';
import 'example/rehub/review_heading.dart';
import 'example/rehub/color_heading.dart';
import 'example/rehub/comparison_table.dart';
import 'example/rehub/woocommerce_query.dart';
import 'example/rehub/how_to.dart';
import 'example/rehub/listing_builder.dart';

/// core
import 'example/core/audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Home'),

        // Post Item
        '/rehub_info_box': (context) => const ExampleInfoBox(),
        '/rehub_title_box': (context) => const ExampleTitleBox(),
        '/rehub_double_heading': (context) => const ExampleDoubleHeading(),
        '/rehub_offer_box': (context) => const ExampleOfferBox(),
        '/rehub_post_offer_box': (context) => const ExamplePostOfferBox(),
        '/rehub_review_box': (context) => const ExampleReviewBox(),
        '/rehub_cons_pros': (context) => const ExampleConsPros(),
        '/rehub_accordion': (context) => const ExampleAccordion(),
        '/rehub_post_offer_listing': (context) => const ExamplePostOfferListing(),
        '/rehub_offer_listing': (context) => const ExampleOfferListing(),
        '/rehub_woocommerce_list': (context) => const ExampleWoocommerceList(),
        '/rehub_versus_table': (context) => const ExampleVersusTable(),
        '/rehub_woocommerce_box': (context) => const ExampleWoocommerceBox(),
        '/rehub_itinerary': (context) => const ExampleItinerary(),
        '/rehub_slider': (context) => const ExampleSlider(),
        '/rehub_pretty_list': (context) => const ExamplePrettyList(),
        '/rehub_promo_box': (context) => const ExamplePromoBox(),
        '/rehub_review_heading': (context) => const ExampleReviewHeading(),
        '/rehub_color_heading': (context) => const ExampleColorHeading(),
        '/rehub_comparison_table': (context) => const ExampleComparisonTable(),
        '/rehub_woocommerce_query': (context) => const ExampleWoocommerceQuery(),
        '/rehub_how_to': (context) => const ExampleHowTo(),
        '/rehub_listing_builder': (context) => const ExampleListingBuilder(),

        // Core
        '/core_audio': (context) => const ExampleAudio(),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Text('Rehub', style: Theme.of(context).textTheme.headline3),
            Text('Core', style: Theme.of(context).textTheme.headline3),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[buildRehub(context), buildCore(context)],
      ),
    );
  }
}

Widget buildRehub(BuildContext context) {
  return SingleChildScrollView(
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        ListTile(
          title: const Text('Info Box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_info_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Title Box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_title_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Double heading'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_double_heading'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Offer box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_offer_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Post offer box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_post_offer_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Review box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_review_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Cons Pros'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_cons_pros'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Accordion'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_accordion'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Post offer listing'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_post_offer_listing'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Offer listing'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_offer_listing'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Woocommerce list'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_woocommerce_list'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Versus table'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_versus_table'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Woocommerce box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_woocommerce_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Itinerary'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_itinerary'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Slider'),
          onTap: () => Navigator.of(context).pushNamed('/rehub_slider'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Pretty list'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_pretty_list'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Promo box'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_promo_box'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Review heading'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_review_heading'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Color heading'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_color_heading'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Comparison table'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_comparison_table'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Woocommerce query'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_woocommerce_query'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('How to'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_how_to'),
        ),
        const Divider(thickness: 1, height: 1),
        ListTile(
          title: const Text('Listing builder'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/rehub_listing_builder'),
        ),
        const Divider(thickness: 1, height: 1),
      ],
    ),
  );
}

Widget buildCore(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        ListTile(
          title: const Text('Audio'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed('/core_audio'),
        ),
      ],
    ),
  );
}

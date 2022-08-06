import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(FeatherIcons.alertCircle, color: Colors.amber, size: 32),
            const SizedBox(height: 16),
            Text("Data not found.", style: Theme.of(context).textTheme.headline5),
            const SizedBox(height: 20),
            const Text("Please create or import pre template in App builder."),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Retrieving News Data')),
            LinearProgressIndicator(
              value: null,
            )
          ],
        ));
  }
}

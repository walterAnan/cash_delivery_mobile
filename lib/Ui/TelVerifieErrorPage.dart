import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelVerifieErrorPage extends StatelessWidget {
  const TelVerifieErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Votre appareil n\'a pas encore été enrégisté',
      ),
    );
  }
}

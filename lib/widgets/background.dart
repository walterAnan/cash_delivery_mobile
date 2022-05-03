import 'package:flutter/material.dart';


class BackgroundImage extends StatelessWidget {
  final String imageUrl;
  const BackgroundImage({
    Key key,
    this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover
        )
      ),
    );
  }
}

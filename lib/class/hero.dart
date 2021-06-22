import 'package:flutter/material.dart';

class HeroWindow extends StatelessWidget {
  final String image, herotag;

  HeroWindow({this.image, this.herotag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(double.infinity),
          child: Hero(
            tag: herotag,
            child: Image.asset(image),
          ),
        ),
      ),
    );
  }
}

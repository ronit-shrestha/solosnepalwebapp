import 'package:completesoloswebsite/screens/drawer/solosdrawer.dart';
import 'package:completesoloswebsite/screens/shop/shop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'videolaptop.dart';
import 'videomobile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: size.height * .08,
          backgroundColor: Colors.black,
          title: Text('S O L O S',
              style: GoogleFonts.koHo(
                  fontWeight: FontWeight.bold, fontSize: size.height * .04)),
          centerTitle: true,
        ),
        drawer: SolosDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Container(
                child: Stack(
                  children: [
                    VideoMobile(),
                    Opacity(
                      opacity: .7,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Center(
                      child: shopnowbutton(size),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                child: Stack(
                  children: [
                    VideoLaptop(),
                    Opacity(
                      opacity: .8,
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      left: size.width * .45,
                      top: size.height * .65,
                      child: shopnowbutton(size),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }

  shopnowbutton(size) {
    return Opacity(
      opacity: .5,
      child: MaterialButton(
        splashColor: Colors.white,
        elevation: 10,
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'SHOP NOW',
            textScaleFactor: 1,
            style: GoogleFonts.koHo(
              fontWeight: FontWeight.bold,
              letterSpacing: 12,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Shop();
          }));
        },
      ),
    );
  }
}

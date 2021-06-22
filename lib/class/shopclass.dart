import 'package:completesoloswebsite/class/productclass.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopClass extends StatelessWidget {
  final String name, image1, image2;

  ShopClass({
    this.name,
    this.image1,
    this.image2,
  });
  @override
  Widget build(BuildContext context) {
    Function nav = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProductClass(
          appbartitle: name,
        );
      }));
    };
    Size size = MediaQuery.of(context).size;
    TextStyle h2mobile = GoogleFonts.koHo(
        fontSize: size.width * .05, fontWeight: FontWeight.w500);

    TextStyle h2laptop = GoogleFonts.koHo(
        fontSize: size.height * .03, fontWeight: FontWeight.w500);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return Column(
          children: [
            producttitle(size, h2mobile, nav),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                  onTap: nav, child: Image.asset(image1))))),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                  onTap: nav, child: Image.asset(image2)))))
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[700],
            )
          ],
        );
      } else {
        return Column(
          children: [
            producttitle(size, h2laptop, nav),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                              onTap: nav,
                              child: Image.asset(image1,
                                  height: size.height * .5)))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                              onTap: nav,
                              child: Image.asset(image2,
                                  height: size.height * .5))))
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[700],
            )
          ],
        );
      }
    });
  }

  producttitle(size, h2, nav) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: nav,
        child: Card(
          shadowColor: Colors.grey[500],
          color: Colors.black,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: h2,
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ),
    );
  }
}

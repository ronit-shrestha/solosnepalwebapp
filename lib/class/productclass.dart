import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completesoloswebsite/screens/shop/cart.dart';
import 'package:completesoloswebsite/class/hero.dart';
import 'package:completesoloswebsite/class/productimageclass.dart';
import 'package:completesoloswebsite/screens/shop/shop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductClass extends StatelessWidget {
  final String appbartitle;

  ProductClass({this.appbartitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle textsizelaptop = GoogleFonts.koHo(fontSize: size.height * .025);
    TextStyle textsizemobile = GoogleFonts.koHo(fontSize: size.width * .04);
    TextStyle h1laptop = GoogleFonts.koHo(
        fontSize: size.height * .04, fontWeight: FontWeight.bold);
    TextStyle h1mobile = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);
    TextStyle h2mobile = GoogleFonts.koHo(
        fontSize: size.width * .05, fontWeight: FontWeight.w500);

    TextStyle h2laptop = GoogleFonts.koHo(
        fontSize: size.height * .03, fontWeight: FontWeight.w500);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return scaffold(size, textsizemobile, h1mobile, h2mobile, context);
      } else {
        return scaffold(size, textsizelaptop, h1laptop, h2laptop, context);
      }
    });
  }

  scaffold(size, textsize, h1, h2, context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          toolbarHeight: size.height * .08,
          title: Text(appbartitle, style: h1),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Cart();
                  }));
                },
                child: Icon(Icons.shopping_cart_outlined)),
            SizedBox(width: size.height * .02)
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey[800], Colors.black])),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('collection', isEqualTo: appbartitle)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: List.generate(
                    snapshot.data.docs.length,
                    (i) {
                      DocumentSnapshot doc = snapshot.data.docs[i];
                      List predocimage = [
                        doc['image1'],
                        doc['image2'],
                        doc['image3'],
                        doc['image4'],
                        doc['image5'],
                        doc['image6']
                      ];
                      List docimage = [];
                      predocimage.forEach((f) {
                        if (f != '') {
                          docimage.add(f);
                        }
                        return docimage;
                      });
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
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
                                      doc['type'],
                                      style: h2,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(docimage.length, (i) {
                                return _imagebox(
                                    size, docimage[i], docimage[i], context);
                              })),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.grey[500],
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        doc['tagline'],
                                        style: textsize,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: size.height * .04),
                                      Table(
                                        columnWidths: {0: FlexColumnWidth(0.5)},
                                        children: [
                                          TableRow(
                                            children: [
                                              Text('FABRIC:', style: textsize),
                                              Text(doc['fabric'],
                                                  style: textsize),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text('FIT:', style: textsize),
                                              Text(doc['fit'], style: textsize),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text('SIZE:', style: textsize),
                                              Text(doc['size'],
                                                  style: textsize),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text('DETAILS:', style: textsize),
                                              Text(doc['details'],
                                                  textAlign: TextAlign.justify,
                                                  style: textsize),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text('WASH:', style: textsize),
                                              Text(doc['wash'],
                                                  style: textsize),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              Text('PRICE:', style: textsize),
                                              Text('Rs ' + doc['price'],
                                                  style: textsize.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height * .04),
                                      Text('MADE IN NEPAL',
                                          style: GoogleFonts.koHo(
                                            letterSpacing: 5,
                                          )),
                                      SizedBox(height: size.height * .04),
                                      MaterialButton(
                                        color: Colors.black,
                                        elevation: 10,
                                        onPressed: () {
                                          showAlertDialog(context);

                                          selectedproducts
                                              .add(ProductImageClass(
                                            type: doc['type'],
                                            price: doc['price'],
                                            i1: doc['image1'],
                                          ));
                                        },
                                        child: Text('Add to Cart'),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(height: size.height * .03),
                          Divider(
                            thickness: 1,
                            color: Colors.grey[700],
                          )
                        ],
                      );
                    },
                  ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            )));
  }

  _imagebox(size, imagelist, herotag, context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            child: Hero(
              tag: herotag,
              child: Image.asset(imagelist, height: size.height * .35),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HeroWindow(
                  image: imagelist,
                  herotag: herotag,
                );
              }));
            },
          ),
        ),
        SizedBox(width: size.height * .03),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("SUCESSFULLY ADDED TO CART",
          style: GoogleFonts.koHo(fontWeight: FontWeight.bold)),
      content: Text("Would you like to shop more?"),
      actions: [
        TextButton(
          child: Text(
            "Yes, Shop more",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Proceed to Checkout",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Cart();
            })).then((value) => Navigator.pop(context));
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

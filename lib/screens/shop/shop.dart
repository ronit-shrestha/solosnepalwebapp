import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completesoloswebsite/class/shopclass.dart';
import 'package:completesoloswebsite/screens/drawer/solosdrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart.dart';

List selectedproducts = [];

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle h1laptop = GoogleFonts.koHo(
        fontSize: size.height * .04,
        fontWeight: FontWeight.bold,
        letterSpacing: 15);
    TextStyle h1mobile = GoogleFonts.koHo(
        fontSize: size.width * .06,
        fontWeight: FontWeight.bold,
        letterSpacing: 15);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return scaffold(size, h1mobile, context);
      } else {
        return scaffold(size, h1laptop, context);
      }
    });
  }

  scaffold(size, h1, context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: size.height * .08,
        title: Text('SHOP', style: h1),
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
      drawer: SolosDrawer(),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey[800], Colors.black])),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('catagories')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: List.generate(snapshot.data.docs.length, (i) {
                      DocumentSnapshot doc = snapshot.data.docs[i];
                      return ShopClass(
                        name: doc['name'],
                        image1: doc['image1'],
                        image2: doc['image2'],
                      );
                    }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}

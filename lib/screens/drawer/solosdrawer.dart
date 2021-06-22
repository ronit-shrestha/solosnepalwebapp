import 'package:completesoloswebsite/screens/aboutus/aboutus.dart';
import 'package:completesoloswebsite/screens/contactus/contactus.dart';
import 'package:completesoloswebsite/screens/shop/cart.dart';
import 'package:completesoloswebsite/screens/shop/shop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/homepage.dart';

class SolosDrawer extends StatefulWidget {
  @override
  _SolosDrawerState createState() => _SolosDrawerState();
}

class _SolosDrawerState extends State<SolosDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle textsizelaptop = GoogleFonts.koHo(fontSize: size.height * .025);
    TextStyle textsizemobile = GoogleFonts.koHo(fontSize: size.width * .04);
    TextStyle h1laptop = GoogleFonts.koHo(
        fontSize: size.height * .04, fontWeight: FontWeight.bold);
    TextStyle h1mobile = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);

    return SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return drawermobile(size, textsizemobile, h1mobile);
      } else {
        return drawerlaptop(size, textsizelaptop, h1laptop);
      }
    }));
  }

  drawermobile(size, textsize, h1) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(120)),
      child: Opacity(
        opacity: 0.85,
        child: Container(
            width: size.width * .6, child: commondrawer(size, textsize, h1)),
      ),
    );
  }

  drawerlaptop(size, textsize, h1) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(120)),
      child: Opacity(
        opacity: 0.85,
        child: Container(
            width: size.height * .5, child: commondrawer(size, textsize, h1)),
      ),
    );
  }

  commondrawer(size, textsize, h1) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black, Colors.grey[800]])),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              height: size.height * .08,
              child: Center(
                child: Text('S O L O S', style: h1),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              },
              title: Text('HOME',
                  style: textsize.copyWith(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios, size: size.height * .02),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Shop();
                }));
              },
              title: Text('SHOP',
                  style: textsize.copyWith(fontWeight: FontWeight.bold)),
              trailing: Icon(Icons.arrow_forward_ios, size: size.height * .02),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ContactUs();
                }));
              },
              title: Text('CONTACT US',
                  style: textsize.copyWith(fontWeight: FontWeight.bold)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: size.height * .02,
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Cart();
                }));
              },
              title: Text('MY CART',
                  style: textsize.copyWith(fontWeight: FontWeight.bold)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: size.height * .02,
              ),
            ),
            Divider(thickness: 1),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutUs();
                }));
              },
              title: Text('ABOUT US',
                  style: textsize.copyWith(fontWeight: FontWeight.bold)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: size.height * .02,
              ),
            ),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}

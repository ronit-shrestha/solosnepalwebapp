import 'package:completesoloswebsite/screens/drawer/solosdrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle textsizelaptop = GoogleFonts.koHo(fontSize: size.height * .025);
    TextStyle textsizemobile = GoogleFonts.koHo(fontSize: size.width * .04);
    TextStyle h1laptop = GoogleFonts.koHo(
        fontSize: size.height * .04, fontWeight: FontWeight.bold);
    TextStyle h1mobile = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return scaffold(size, textsizemobile, h1mobile);
      } else {
        return scaffold(size, textsizelaptop, h1laptop);
      }
    });
  }

  scaffold(size, textsize, h1) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: size.height * .08,
        title: Text('ABOUT US', style: h1),
      ),
      drawer: SolosDrawer(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.grey[800], Colors.black])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Card(
                  shadowColor: Colors.grey[500],
                  color: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      SizedBox(height: size.height * .07),
                      Text(
                        'Established in 2020, Solos is a Nepali fashion label. With an aim to provide global quality standard jackets at reasonable price, we gradually moved to wider range of clothing apparels by the end of the year. Our main moto is to provide quality exportable clothing at a reasonable price and empower local craftsmanship. We intend to supply better quality clothing and make our nation largely dependable on itself for clothing. For generations, we have been dependent upon different nations for our basic quality apparels. We are here to change the trend and create a new benchmark amongst the Nepalese youths. We believe in Making in Nepal.\n\n Fabrics used by the label are either locally sourced or imported. However, the manufacturing process is solely done inside the nation through local garments and craftsmen. We try to bring designs that are normally a combination of culture and youth taste.\n\nThrough our products, we try to connect as many people as possible along with their lives and journeys.\n\n \n\nThank you!\nSOLOS NEPAL',
                        style: textsize,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: size.height * .07),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

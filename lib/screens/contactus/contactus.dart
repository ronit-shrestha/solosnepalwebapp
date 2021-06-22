import 'package:completesoloswebsite/screens/drawer/solosdrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TransformationController controlmap1 = TransformationController();
TransformationController controlmap2 = TransformationController();

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
          title: Text('CONTACT US', style: h1),
        ),
        drawer: SolosDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Container(
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
                        table(size, textsize),
                        SizedBox(height: size.height * .1),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Center(
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InteractiveViewer(
                                      boundaryMargin:
                                          EdgeInsets.all(double.infinity),
                                      transformationController: controlmap1,
                                      onInteractionEnd: (val) {
                                        setState(() {
                                          controlmap1.value =
                                              Matrix4.identity();
                                        });
                                      },
                                      child: Image(
                                          height: size.height * .3,
                                          image: AssetImage('assets/map2.png')),
                                    ),
                                  ),
                                  SizedBox(width: size.height * .05),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InteractiveViewer(
                                      boundaryMargin:
                                          EdgeInsets.all(double.infinity),
                                      transformationController: controlmap2,
                                      onInteractionEnd: (details) {
                                        setState(() {
                                          controlmap2.value =
                                              Matrix4.identity();
                                        });
                                      },
                                      child: Image(
                                          height: size.height * .3,
                                          image: AssetImage('assets/map1.png')),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: size.height * .1),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [Colors.grey[800], Colors.black])),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        table(size, textsize),
                        SizedBox(height: size.height * .1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset('assets/map2.png')),
                            ),
                            SizedBox(width: size.height * .05),
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset('assets/map1.png')),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }

  table(size, textsize) {
    return Card(
      shadowColor: Colors.grey[500],
      color: Colors.black,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(height: size.height * .07),
          Table(
            columnWidths: {0: FlexColumnWidth(0.5)},
            children: [
              TableRow(children: [
                Text('CONTACT NUMBER:', style: textsize),
                SelectableText('9841639836, 9849365361, 9864477032',
                    style: textsize)
              ]),
              TableRow(children: [
                Text('LOCATION:', style: textsize),
                SelectableText(
                    'Pulchowk, Opposite to Lalitpur Metropolitan Office. Beside Labim Mall',
                    style: textsize)
              ]),
              TableRow(children: [
                Text('EMAIl ID:', style: textsize),
                SelectableText('solosnepal@gmail.com', style: textsize)
              ]),
              TableRow(children: [
                Text('INSTAGRAM:', style: textsize),
                SelectableText('www.instagram.com/solosnepal', style: textsize)
              ]),
            ],
          ),
          SizedBox(height: size.height * .07),
        ]),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completesoloswebsite/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shop.dart';

class Confirm extends StatefulWidget {
  @override
  _ConfirmState createState() => _ConfirmState();
}

final key = GlobalKey<FormState>();
String name, location, contactno, presize, hw;
TextEditingController controlname = TextEditingController();
TextEditingController controllocation = TextEditingController();
TextEditingController controlcontactno = TextEditingController();
TextEditingController controlpresize = TextEditingController();
TextEditingController controlhw = TextEditingController();
List orderdetails = [];

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < selectedproducts.length; i++)
      orderdetails.add({
        "type": selectedproducts[i].type,
        "price": selectedproducts[i].price,
      });
    Size size = MediaQuery.of(context).size;
    TextStyle h1laptop = GoogleFonts.koHo(
        fontSize: size.height * .04, fontWeight: FontWeight.bold);
    TextStyle h1mobile = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return scaffold(size, h1mobile);
      } else {
        return scaffold(size, h1laptop);
      }
    });
  }

  scaffold(size, h1) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: size.height * .08,
        title: Text('DELIVERY INFO', style: h1),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.grey.shade800, Colors.black])),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: key,
                child: ListView(
                  children: [
                    customtextfromfield(controlname, name, "Full Name", size),
                    customtextfromfield(
                        controllocation, location, "Full Location", size),
                    numbercustomtextfromfield(
                        controlcontactno, contactno, "Contact Number", size),
                    optionalcustomtextfromfield(
                        controlpresize, presize, "Prefered Size", size),
                    optionalcustomtextfromfield(
                        controlhw, hw, "Your Height and Weight", size),
                    MaterialButton(
                      onPressed: () {
                        if (key.currentState.validate()) {
                          FirebaseFirestore.instance
                              .collection('orders')
                              .doc('neworders')
                              .collection('neworders')
                              .add({
                            'name': controlname.text,
                            'location': controllocation.text,
                            'number': controlcontactno.text,
                            'preferedsize': controlpresize.text,
                            'heightweight': controlhw.text,
                            'date': Timestamp.now(),
                            'orderdetails': FieldValue.arrayUnion(orderdetails)
                          });

                          controlname.clear();
                          controllocation.clear();
                          controlcontactno.clear();
                          controlpresize.clear();
                          controlhw.clear();
                          showAlertDialog(context);
                          setState(() {
                            selectedproducts.clear();
                            orderdetails.clear();
                          });
                        }
                      },
                      child: Text(
                        'CONFIRM ORDER',
                        style: GoogleFonts.koHo(fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Back to Cart',
                        style: GoogleFonts.koHo(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Text(
                        '# You will recieve a call from our representatives with 24 hours to confirm all the details.',
                        style: GoogleFonts.koHo(color: Colors.grey))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  customtextfromfield(control, vari, label, size) {
    return Column(
      children: [
        TextFormField(
          controller: control,
          onChanged: (value) {
            vari = value;
          },
          validator: (value) => value.isEmpty ? 'Cannot be Empty' : null,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.koHo(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white))),
        ),
        SizedBox(
          height: size.height * .02,
        )
      ],
    );
  }

  numbercustomtextfromfield(control, vari, label, size) {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.number,
          controller: control,
          onChanged: (value) {
            vari = value;
          },
          validator: (value) =>
              value.length < 7 ? 'Please Enter a Valid number' : null,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.koHo(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white))),
        ),
        SizedBox(
          height: size.height * .02,
        )
      ],
    );
  }

  optionalcustomtextfromfield(control, vari, label, size) {
    return Column(
      children: [
        TextFormField(
          controller: control,
          onChanged: (value) {
            vari = value;
          },
          decoration: InputDecoration(
              helperText: 'Optional',
              labelText: label,
              labelStyle: GoogleFonts.koHo(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white))),
        ),
        SizedBox(
          height: size.height * .02,
        )
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("Your Order has been sucessfully placed.",
          style: GoogleFonts.koHo(
              fontWeight: FontWeight.bold, color: Colors.white)),
      content: Text(
          "You will received a call from our representatives within 24 hours to confirm all the details.",
          style: GoogleFonts.koHo(color: Colors.white)),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: GoogleFonts.koHo(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false);
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

import 'package:completesoloswebsite/screens/shop/shop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confirm.dart';
import 'shop.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    int sum = 0, price = 0;

    for (var i = 0; i < selectedproducts.length; i++) {
      price = int.parse(selectedproducts[i].price);
      sum += price;
    }

    Size size = MediaQuery.of(context).size;
    TextStyle textsizelaptop = GoogleFonts.koHo(
        fontSize: size.height * .025, fontWeight: FontWeight.w700);
    TextStyle textsizemobile = GoogleFonts.koHo(
        fontSize: size.width * .04, fontWeight: FontWeight.w700);
    TextStyle h1laptop = GoogleFonts.koHo(
        fontSize: size.height * .04, fontWeight: FontWeight.bold);
    TextStyle h1mobile = GoogleFonts.koHo(
        fontSize: size.width * .06, fontWeight: FontWeight.bold);
    TextStyle h2mobile = GoogleFonts.koHo(
        fontSize: size.width * .05,
        fontWeight: FontWeight.bold,
        letterSpacing: 3);

    TextStyle h2laptop = GoogleFonts.koHo(
        fontSize: size.height * .03,
        fontWeight: FontWeight.bold,
        letterSpacing: 3);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return scaffold(size, textsizemobile, h1mobile, h2mobile, sum);
      } else {
        return scaffold(size, textsizelaptop, h1laptop, h2laptop, sum);
      }
    });
  }

  scaffold(size, textsize, h1, h2, sum) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      floatingActionButton: SizedBox(
        width: size.height * .2,
        height: size.height * .06,
        child: FloatingActionButton(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            if (selectedproducts.isNotEmpty) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Confirm();
              }));
            }
          },
          backgroundColor: Colors.white,
          child: Text('PROCEED', style: h2.copyWith(color: Colors.black)),
        ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: size.height * .08,
        title: Text('CART', style: h1),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.grey.shade800, Colors.black]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '<<< to remove item',
              style: GoogleFonts.koHo(color: Colors.grey.shade400),
            ),
            cartitems(size, textsize),
            Divider(
              thickness: 1,
              color: Colors.grey.shade500,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text('TOTAL:   ', style: h2),
                  Text('Rs ' + '$sum', style: h2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  cartitems(size, textsize) {
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: selectedproducts.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Dismissible(
                confirmDismiss: (direction) {
                  return showAlertDialog(context, i);
                },
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 30),
                  ),
                ),
                key: ValueKey(123),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(selectedproducts[i].i1)),
                      title: Text(selectedproducts[i].type, style: textsize),
                      trailing: Text('Rs ' + selectedproducts[i].price,
                          style: textsize),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, i) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      contentTextStyle: GoogleFonts.koHo(color: Colors.white),
      title: Text("REMOVE ITEM FROM CART?",
          style: GoogleFonts.koHo(fontWeight: FontWeight.bold)),
      content: Text("Would you like to remove this item from your Cart?"),
      actions: [
        TextButton(
          child: Text(
            "Yes, Remove this item",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            setState(() {
              selectedproducts.remove(selectedproducts[i]);
              Navigator.pop(context);
            });
          },
        ),
        TextButton(
          child: Text(
            "No",
            style: GoogleFonts.koHo(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
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

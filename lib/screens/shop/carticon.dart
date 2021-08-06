import 'package:completesoloswebsite/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      if (cart.selectedProducts.length == 0) {
        return Icon(Icons.shopping_cart_outlined);
      } else {
        return Stack(
          children: [
            Icon(Icons.shopping_cart_outlined),
            Positioned(
                bottom: 8,
                left: 8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    cart.selectedProducts.length.toString(),
                    style: GoogleFonts.koHo(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        );
      }
    });
  }
}

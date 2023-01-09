import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ying_beauty/model/product_detail.dart';
import 'package:ying_beauty/ui/item/item_detail_screen.dart';

class ItemScreen extends StatefulWidget {
  ItemScreen({required this.product});
  final ProductDetailt product;
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailScreen(
                product: widget.product,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 15.0 / 10.0,
              child: Image.network(
                widget.product.proAvatar,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                    .format(widget.product.proPrice),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text(widget.product.proName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false),
            ),
          ],
        ),
      ),
    );
  }
}

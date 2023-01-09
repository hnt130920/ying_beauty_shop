import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ying_beauty/ui/components/banner_view_model.dart';

class CarouselCustom extends StatefulWidget {
  const CarouselCustom({super.key});

  @override
  State<CarouselCustom> createState() => _CarouselCustomState();
}

class _CarouselCustomState extends State<CarouselCustom> {
  final banners = BannerViewModel().listBannerImg();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
      ),
      items: banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Image.network(
                i,
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

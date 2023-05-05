import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imageLinks;

  const CarouselImage({Key? key, required this.imageLinks}) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: widget.imageLinks.map(
            (link) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                margin: const EdgeInsets.all(5),
                child: GestureDetector(
                  child: Image.network(
                    link,
                    fit: BoxFit.contain,
                  ),
                  onTap: () {
                    print(link);
                  },
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        ),
        CarouselIndicator(
          width: 10,
          height: 10,
          cornerRadius: 17,
          count: widget.imageLinks.length,
          index: pageIndex,
        ),
      ],
    );
  }
}

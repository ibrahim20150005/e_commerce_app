import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Carouselpor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Carousel(
      boxFit: BoxFit.cover,
      autoplay: false,
      animationCurve: Curves.easeInCubic,
      animationDuration: Duration(milliseconds: 300),
      dotSize: 8.0,
      dotIncreasedColor: Color(0xFFFF335C),
      dotBgColor: Colors.transparent,
      dotPosition: DotPosition.bottomCenter,
      dotVerticalPadding: 2.0,
      showIndicator: true,
      indicatorBgPadding: 7.0,
      images: [
        NetworkImage(
            'https://dbi-blog.s3.amazonaws.com/uploads/2020/12/COMBO_SHOT_17_36-700x875.jpg'),
        NetworkImage(
            'https://i.pinimg.com/564x/e1/24/93/e12493289bda8077810dfd5ffa6aeeef.jpg'),
        NetworkImage(
            "https://i.pinimg.com/736x/51/3e/5e/513e5efb8f89897fa648de00cc4fdef1.jpg"),
        NetworkImage(
            "https://ae01.alicdn.com/kf/HTB1G3PyQCzqK1RjSZPcq6zTepXaM/Male-Shoes-Men-Casual-Shoes-Fashion-Sneakers-Men-Shoes-Casual-Sneakers-Slip-on-Male-Comfortable-Shoes.jpg_q50.jpg"),
      ],
    );
  }
}

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF5B9EE1);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

const urlImage = "assets/images/";
const urlIcon = "assets/icon/";
const urlFonts = "assets/fonts/";


const BorderRadius customBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(16),
  topRight: Radius.circular(16),
  bottomLeft: Radius.circular(16),
  bottomRight: Radius.circular(16),
);

final List<String> bannerList = [
  'https://giaycuhanghieu.vn/thumbs/1366x720x1/upload/photo/slider-bnanner-44080.png',
  'https://vsneakershop.weebly.com/uploads/6/3/3/8/63388329/vsneaker-banner-gi-y_orig.png',
  'https://giaysneaker.store/media/wysiwyg/slidershow/home-12/banner_NEW_BALANCE.jpg',
];
final List<Map<String, String>> brandImages = [
  {'name': 'Nike', 'image': 'https://i.imghippo.com/files/FNqeF1720768332.png'},
  {'name': 'Puma', 'image': 'https://i.imghippo.com/files/iXXMx1720768355.png'},
  {
    'name': 'Adidas',
    'image': 'https://i.imghippo.com/files/j3e1M1720768443.png'
  },
  {
    'name': 'Converse',
    'image': 'https://i.imghippo.com/files/4xKwU1720768473.png'
  }
];

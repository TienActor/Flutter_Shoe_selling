import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tien/Config/const.dart';

class Intro_page_3Widget extends StatelessWidget {
  const Intro_page_3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 412,
        height: 892,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: Color.fromRGBO(248, 249, 250, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 150,
              left: 36,
              child: SizedBox(
                  width: 313,
                  height: 311,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 298,
                        left: 0,
                        child: Container(
                            width: 13,
                            height: 13,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(91, 158, 225, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(13, 13)),
                            ))),
                    Positioned(
                        top: 298,
                        left: 300,
                        child: Container(
                            width: 13,
                            height: 13,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(91, 158, 225, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(13, 13)),
                            ))),
                    Positioned(
                        top: 0,
                        left: 27,
                        child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(164, 205, 246, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(16, 16)),
                            ))),
                  ]))),
          Positioned(
              top: 791,
              left: 28,
              child: SizedBox(
                  width: 343,
                  height: 54,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: SizedBox(
                            width: 343,
                            height: 54,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 230,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: customBorderRadius,
                                      color: Color.fromRGBO(91, 158, 225, 1),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Tiếp',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.zillaSlab(
                                              color: Colors.white,
                                              fontSize: 24,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  top: 24.99982261657715,
                                  left: 0,
                                  child: SizedBox(
                                      width: 67,
                                      height: 5,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 32,
                                            child: Container(
                                                width: 35,
                                                height: 5,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      customBorderRadius,
                                                  color: Color.fromRGBO(
                                                      91, 158, 225, 1),
                                                ))),
                                        Positioned(
                                            left: 0,
                                            child: Container(
                                                width: 8,
                                                height: 5,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      customBorderRadius,
                                                  color: Color.fromRGBO(
                                                      229, 238, 247, 1),
                                                ))),
                                        Positioned(
                                            left: 16,
                                            child: Container(
                                                width: 8,
                                                height: 5,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        customBorderRadius,
                                                    color: Colors.white))),
                                      ]))),
                            ]))),
                  ]))),
          Positioned(
              top: 476,
              left: 28,
              child: SizedBox(
                  width: 350,
                  height: 142,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          'Bắt đầu cuộc hành trình nào!',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.pacifico(
                              color: const Color.fromRGBO(26, 36, 47, 1),
                              fontSize: 40,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.4),
                        )),
                  ]))),
          Positioned(
              top: 82,
              left: 42,
              child: Container(
                  width: 329,
                  height: 343,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitWidth),
                  ))),
        ]));
  }
}

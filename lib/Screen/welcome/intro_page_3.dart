import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tien/Config/const.dart';
import 'package:tien/Screen/Login/login_page.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
                        top: 471,
                        left: 41,
                        child: SizedBox(
                            width: 343,
                            height: 360,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 10,
                                  child: SizedBox(
                                      width: 302,
                                      height: 184,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: SizedBox(
                                                width: 302,
                                                height: 184,
                                                child: Stack(children: <Widget>[
                                                  Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      right: 20,
                                                      child: Text(
                                                        'Bắt đầu cuộc hành trình nào !!',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .pacifico(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 30,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                height: 1.6),
                                                      )),
                                                 
                                                ]))),
                                      ]))),
                              Positioned(
                                  top: 280,
                                  left: 0,
                                  child: SizedBox(
                                      width: 400,
                                      height: 85,
                                      child: Stack(children: <Widget>[
                                        Positioned(
                                          top: 0,
                                          left: 170,
                                          width: 170,
                                          height: 80,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              ),
                                              color: Color.fromRGBO(
                                                  91, 158, 225, 1),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 16),
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          91, 158, 225, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginPage()),
                                                  );
                                                },
                                                child: Text(
                                                  'Tiếp',
                                                  style: GoogleFonts.zillaSlab(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ),
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

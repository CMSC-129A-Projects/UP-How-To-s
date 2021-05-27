import "package:flutter/material.dart";

Key admin = UniqueKey();

//Pseudo Admin Key
Key adminPseudoKey() => admin;

TextStyle subHeader01(Color c) => TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 15,
      color: c,
    );

TextStyle subHeader02(Color c) => TextStyle(
      fontFamily: 'Helvetica-Oblique',
      fontSize: 15,
      color: c,
    );

TextStyle bodyText(Color c) => TextStyle(
      fontFamily: 'Helvetica-Light',
      fontSize: 15,
      color: c,
    );

TextStyle header01(Color c) => TextStyle(
      fontFamily: 'Helvetica-Bold',
      fontSize: 30,
      color: c,
    );

TextStyle header02(Color c) => TextStyle(
      fontFamily: 'Helvetica-Bold',
      fontSize: 20,
      color: c,
    );

TextStyle subHeader03(Color c) => TextStyle(
      fontFamily: 'Helvetica-Bold',
      fontSize: 10,
      color: c,
    );

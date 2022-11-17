import 'package:flutter/material.dart';
import 'package:enigmobile/pages/home.dart';

void main() =>
    runApp(MaterialApp(initialRoute: '/', routes: {'/': (context) => Home()}));

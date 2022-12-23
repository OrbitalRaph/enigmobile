import 'package:flutter/material.dart';
import 'package:enigmobile/pages/home.dart';
import 'package:enigmobile/pages/login.dart';
import 'package:enigmobile/pages/create_defi.dart';
import 'package:enigmobile/pages/defi.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const Login(),
      '/home': (context) => const Home(),
      '/create_defi': (context) => const CreateDefi(),
      '/defi': (context) => const DefiForm(),
    }));

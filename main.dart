import 'package:encr/control/encryptConfig.dart';
import 'package:encr/control/lightMode.dart';
import 'package:encr/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EncryptionConfig(),
        ),
        ChangeNotifierProvider(
          create: (context) => LightMode(),
        ),
      ],
      child: Consumer<LightMode>(
        builder: (BuildContext context, cons, Widget? child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: cons.themeData,
              home: MainScreen());
        },
      ),
    ));

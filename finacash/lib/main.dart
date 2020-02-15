
import 'package:finacash/screen/InicialPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.indigo[400], // navigation bar color
    statusBarColor: Colors.indigo[400],
    statusBarIconBrightness: Brightness.light // status bar color
  ));

  initializeDateFormatting().then((_){
    runApp(MaterialApp(
    home: InicialPage(),
    debugShowCheckedModeBanner: false,
  ));
  });
  
}
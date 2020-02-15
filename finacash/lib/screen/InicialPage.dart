import 'package:finacash/Helper/Movimentacoes_helper.dart';
import 'package:finacash/Widgets/AnimatedBottomNavBar.dart';
import 'package:finacash/Widgets/CardMovimentacoesItem.dart';
import 'package:finacash/screen/AddReceita.dart';
import 'package:finacash/screen/DespesasResumo.dart';
import 'package:finacash/screen/HomePage.dart';
import 'package:finacash/screen/ReceitasResumo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

class InicialPage extends StatefulWidget {

  final List<BarItem> barItems = [
    
    BarItem(
      text: "Despesas",
      iconData: Icons.remove_circle_outline,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: "Home",
      iconData:  Icons.home,
      color: Colors.indigo,
    ),
    
    BarItem(
      text: "Receitas",
      iconData: Icons.add_circle_outline,
      color: Colors.teal,
    ),
    /*BarItem(
      text: "Search",
      iconData: Icons.search,
      color: Colors.yellow.shade900,
    ),
    */
  ];

  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  
  int selectedBarIndex = 1;
  
  
  

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    

    List<Widget> telas =[
      
      DespesasResumo(),
      HomePage(),
      ReceitasResumo()   
    ];

    //_allMov();
    //print("\nMes atual: " + DateTime.now().month.toString());
    return Scaffold(
      body: telas[selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
        barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(
            fontSize: width * 0.045,
            iconSize: width * 0.07
          ),
          onBarTap: (index){
            setState(() {
              selectedBarIndex = index;
            });
          },
      ),

    );
  }
}

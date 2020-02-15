import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AddReceita extends StatefulWidget {
  @override
  _AddReceitaState createState() => _AddReceitaState();
}

class _AddReceitaState extends State<AddReceita> {

  var width ;
  var height ;  

  var dataAtual = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  String dataFormatada; 

  @override
  void initState() {
    
    super.initState();
    dataFormatada = formatter.format(dataAtual);
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text("Nova Receita"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.green
              ),
              width: width,
              height: height * 0.2,
              child: Text("RS 0,00", textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.2
              ),),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(dataFormatada),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
      ),
    );
  }
}
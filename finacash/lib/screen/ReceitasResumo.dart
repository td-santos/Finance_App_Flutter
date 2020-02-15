import 'package:finacash/Helper/Movimentacoes_helper.dart';
import 'package:finacash/Widgets/TimeLineItem.dart';
import 'package:flutter/material.dart';

class ReceitasResumo extends StatefulWidget {
  @override
  _ReceitasResumoState createState() => _ReceitasResumoState();
}

class _ReceitasResumoState extends State<ReceitasResumo> {

  MovimentacoesHelper movimentacoesHelper = MovimentacoesHelper();
  List<Movimentacoes> listmovimentacoes = List();

  _allMovPorTipo() {
    movimentacoesHelper.getAllMovimentacoesPorTipo("r").then((list) {
      setState(() {
        listmovimentacoes = list;
      });
      print("All Mov: $listmovimentacoes");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allMovPorTipo();
  }
  
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.8),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.05,top: width * 0.2),
              child: Text("Receitas",style: TextStyle(
                color: Colors.white ,//Colors.grey[400],
                fontWeight: FontWeight.bold,
                fontSize: width * 0.08
              ),),
              
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: width * 0.08),
              child: SizedBox(
                width: width,
                height: height * 0.74,
                child: ListView.builder(
                  itemCount: listmovimentacoes.length,
                  itemBuilder: (context, index){
                    List movReverse = listmovimentacoes.reversed.toList();
                    Movimentacoes mov = movReverse[index];

                    
                    if(movReverse[index] == movReverse.last){
                      return TimeLineItem(mov: mov, colorItem: Colors.green[900],isLast: true,);
                    }else{
                      return TimeLineItem(mov: mov,colorItem: Colors.green[900],isLast: false,);
                    }
                    
                  },
                ),
              ),
              
            ),
            
          ],
        ),
      ),
      
    );
  }
}
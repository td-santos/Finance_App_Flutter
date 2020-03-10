

import 'package:finacash/Helper/Movimentacoes_helper.dart';
import 'package:flutter/material.dart';

import 'CustomDialog.dart';

class CardMovimentacoesItem extends StatelessWidget {

  final Movimentacoes mov;
  final bool lastItem;


  const CardMovimentacoesItem({Key key, this.mov,this.lastItem=false}) : super(key: key);

  _dialogConfimacao(BuildContext context, double width){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Remover Movimentação",textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue[700]),),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
          content: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20,),
              
              Text("${mov.descricao}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width * 0.045,color:mov.tipo.toString() =="r" ?Colors.green[600] : Colors.red[600])),
              Text("R\$ ${mov.valor}",style: TextStyle(fontWeight: FontWeight.bold,color: mov.tipo.toString() =="r" ?Colors.green[600] : Colors.red[600])),
                
              
              SizedBox(height: 40,),
              Divider(color: Colors.grey[400],height: 2,),
              SizedBox(height: 40,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        MovimentacoesHelper movHelper = MovimentacoesHelper();
                        movHelper.deleteMovimentacao(mov);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: width * 0.02, 
                            bottom: width * 0.02, 
                            left: width * 0.03, 
                            right: width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red[700],
                        ),
                        child: Center(
                          child: Text(
                            "Confirmar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
          )
        );
      }
    );
  }
  
  _dialogEdit(BuildContext context, double width, Movimentacoes movimentacao){
    print(movimentacao.toString());
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(mov: movimentacao,);
        });
  }
  @override  
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    
    
    return Column(
      children: <Widget>[
        GestureDetector(
      onTap: (){
        _dialogEdit(context, width, mov);
        //_dialogConfimacao(context, width);
        
      },
      child: Container(
      //padding: EdgeInsets.all(width * 0.005),
      width: width,
      height: height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(            
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(
                color: Colors.grey[300],
                blurRadius: 10,
                offset: Offset(2, 3)
              )]
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.03),
              child:mov.tipo == "r" 
              ? Icon(Icons.arrow_downward,color: Colors.green,size: width * 0.06,)
              : Icon(Icons.arrow_upward,color: Colors.red, size:width * 0.06)
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: width * 0.03),
            child: Container(
              width: width * 0.4,
              child: Text(mov.descricao,overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(
              color:mov.tipo == "r" ? Colors.green[700]:Colors.red[700],
              fontWeight: FontWeight.bold,
              fontSize: width * 0.044,            
            ),),
            )
          ),
            ],
          ),
          Text(mov.tipo == "r" ? "+ ${mov.valor}" :" ${mov.valor}", style: TextStyle(
            color: mov.tipo == "r" ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.bold,
            fontSize: width * 0.044,
            
          ),),
        ],
      ),
    ),
    ),
    lastItem ==true ? Container(height:80,) : Container()
      ],
    );
    
  }
}
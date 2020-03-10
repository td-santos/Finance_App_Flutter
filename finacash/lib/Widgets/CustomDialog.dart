import 'package:finacash/Helper/Movimentacoes_helper.dart';
import 'package:finacash/screen/HomePage.dart';
import 'package:finacash/screen/InicialPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDialog extends StatefulWidget {

  final Movimentacoes mov;
  const CustomDialog({Key key, this.mov}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  var formatter = new DateFormat('dd-MM-yyyy');
  bool edit;
  
  int _groupValueRadio = 1;
  Color _colorContainer = Colors.green[400];
  Color _colorTextButtom = Colors.green;
  TextEditingController _controllerValor = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();

  MovimentacoesHelper _movHelper = MovimentacoesHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.mov != null){
      print(widget.mov.toString());

      edit = true;
      if(widget.mov.tipo == "d"){ 
        _groupValueRadio =2;
        _colorContainer = Colors.red[300];
        _colorTextButtom = Colors.red[300];
        }
      
      _controllerValor.text = widget.mov.valor.toString().replaceAll("-", "");
      _controllerDesc.text = widget.mov.descricao;
    }else{
      edit = false;
    }
    print(" edit -> $edit");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
        title: Text(
          "Adicionar Valores",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: _colorContainer,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "R\$ ",
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.06),
                  ),
                  Flexible(
                    child: TextField(
                        controller: _controllerValor,
                        maxLength: 7,
                        style: TextStyle(fontSize: width * 0.05),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                        decoration: new InputDecoration(
                          hintText: "0.00",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding:  EdgeInsets.only(
                              left: width * 0.04, 
                              top: width * 0.041, 
                              bottom: width * 0.041, 
                              right: width * 0.04),//15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        )),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.green[900],
                    value: 1,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.green[400];
                        _colorTextButtom = Colors.green;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("receita"),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.red[900],
                    value: 2,
                    groupValue: _groupValueRadio,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _groupValueRadio = value;
                        _colorContainer = Colors.red[300];
                        _colorTextButtom = Colors.red[300];
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.01),
                    child: Text("despesa"),
                  )
                ],
              ),
              TextField(
                  controller: _controllerDesc,
                  maxLength: 20,
                  style: TextStyle(fontSize: width * 0.05),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    //hintText: "descrição",
                    labelText: "Descrição",
                    labelStyle: TextStyle(color: Colors.white54),
                    //hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding:  EdgeInsets.only(
                        left: width * 0.04, 
                        top: width * 0.041, 
                        bottom: width * 0.041, 
                        right: width * 0.04),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: width * 0.09),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        
                        if(_controllerValor.text.isNotEmpty && _controllerDesc.text.isNotEmpty){
                          Movimentacoes mov = Movimentacoes();
                          String valor;
                          if(_controllerValor.text.contains(",")){
                             valor = _controllerValor.text.replaceAll( RegExp(","), ".");
                            }else{
                              valor = _controllerValor.text; 
                            }

                          mov.data = formatter.format(DateTime.now());
                          mov.descricao = _controllerDesc.text;
                          
                          if(_groupValueRadio == 1){
                            
                            mov.valor = double.parse(valor);
                            mov.tipo ="r";
                            if(widget.mov != null){ mov.id = widget.mov.id;}
                            edit == false ? _movHelper.saveMovimentacao(mov) : _movHelper.updateMovimentacao(mov);
                          }
                          if(_groupValueRadio == 2){
                            mov.valor = double.parse("-" + valor);
                            mov.tipo ="d";
                            if(widget.mov != null){ mov.id = widget.mov.id;}
                            edit == false ? _movHelper.saveMovimentacao(mov) : _movHelper.updateMovimentacao(mov);
                          }
                          Navigator.pop(context);
                          //initState();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: width * 0.02, 
                            bottom: width * 0.02, 
                            left: width * 0.03, 
                            right: width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            edit == false ?"Confirmar" : "Editar",
                            style: TextStyle(
                                color: _colorTextButtom,
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

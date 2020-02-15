import 'package:finacash/Helper/Movimentacoes_helper.dart';
import 'package:finacash/Widgets/AnimatedBottomNavBar.dart';
import 'package:finacash/Widgets/CardMovimentacoesItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'AddReceita.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String saldoAtual = "";
  var total;
  var width;
  var height;
  TextEditingController _valorController = TextEditingController();
  CalendarController calendarController;
  MovimentacoesHelper movimentacoesHelper = MovimentacoesHelper();
  List<Movimentacoes> listmovimentacoes = List();
  

  var dataAtual = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  var formatterCalendar = new DateFormat('MM-yyyy');
  String dataFormatada;

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  _addValor() {
    String valor = _valorController.text;
    setState(() {
      saldoAtual = valor;
    });
  }

  _saldoTamanho(String conteudo) {
    if (conteudo.length > 5) {
      return width * 0.2;
    } else {
      return width * 0.3;
    }
  }

  _salvar() {
    dataFormatada = formatter.format(dataAtual);
    Movimentacoes mov = Movimentacoes();
    mov.valor = 20.50;
    mov.tipo = "r";
    mov.data = "10-03-2020"; //dataFormatada;
    mov.descricao = "CashBack";
    MovimentacoesHelper movimentacoesHelper = MovimentacoesHelper();
    movimentacoesHelper.saveMovimentacao(mov);
    mov.toString();
  }

  _allMov() {
    movimentacoesHelper.getAllMovimentacoes().then((list) {
      setState(() {
        listmovimentacoes = list;
      });
      print("All Mov: $listmovimentacoes");
    });
  }

  _allMovMes(String data) {
    movimentacoesHelper.getAllMovimentacoesPorMes(data).then((list) {
      if (list.isNotEmpty) {
        setState(() {
          listmovimentacoes = list;
          //total =listmovimentacoes.map((item) => item.valor).reduce((a, b) => a + b);
        });
        total =
            listmovimentacoes.map((item) => item.valor).reduce((a, b) => a + b);
        saldoAtual = format(total).toString();
         
      } else {
        setState(() {
          listmovimentacoes.clear();
          total = 0;
          saldoAtual = total.toString();
        });
      }

      print("TOTAL: $total");
      print("All MovMES: $listmovimentacoes");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarController = CalendarController();
    if (DateTime.now().month != false) {
      //saldoAtual = "1259";
    }
    //_salvar();
    dataFormatada = formatterCalendar.format(dataAtual);
    print(dataFormatada);
    _allMovMes(dataFormatada);

    //_allMov();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    

    return Scaffold(      
      body: SingleChildScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        //height: height,
        //width: width,
        child: Column(
          
          children: <Widget>[
            Stack(
              children: <Widget>[
                
                Container(
                  width: double.infinity,
                  height: height * 0.334,//300,
                  color: Colors.white,
                ),
                
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.infinity,
                      height:height * 0.28 ,//250,
                      decoration: BoxDecoration(
                        color:Colors.lightBlue[700], //Colors.indigo[400],
                      )),
                ),
                Positioned(
                  top: width * 0.18,//70
                  left: width * 0.07,//30,
                  child: Text("FinaCash",style: TextStyle(
                    color: Colors.white,
                    fontSize:width * 0.074//30
                  ),),
                ),
                Positioned(
                  bottom: 0,
                  left: width *0.07,// 30,
                  right: width *0.07,// 30,
                  child: Container(
                    height:height * 0.16, //150,
                    width: width * 0.1,// 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400],
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.05,top: width * 0.04,bottom: width * 0.02,),
                          child: Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: width * 0.05),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:  EdgeInsets.only(left: width * 0.05),
                              child: Text(
                                saldoAtual,
                                style: TextStyle(
                                    color: Colors.lightBlue[700], //Colors.indigo[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.1 //_saldoTamanho(saldoAtual)
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddReceita()));
                                },
                                child: Container(
                                  width: width * 0.12,
                                  height: width * 0.12, //65,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue[700], //Colors.indigo[400],
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Icon(
                                    Icons.add,
                                    size: width * 0.07,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height *0.008,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            TableCalendar(
              calendarController: calendarController,
              locale: "pt_BR",
              headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
                formatButtonVisible: false,
                centerHeaderTitle: true,
              ),
              calendarStyle: CalendarStyle(outsideDaysVisible: false),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.transparent),
                weekendStyle: TextStyle(color: Colors.transparent),
              ),
              rowHeight: 0,
              initialCalendarFormat: CalendarFormat.month,
              onVisibleDaysChanged: (dateFirst, dateLast, CalendarFormat cf) {
                print(dateFirst);

                dataFormatada = formatterCalendar.format(dateFirst);
                _allMovMes(dataFormatada);

                print("DATA FORMATADA CALENDAR $dataFormatada");

                //print("Data Inicial: $dateFirst ....... Data Final: $dateLast");
              },
            ),
            Padding(
                padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Movimentações",
                      style: TextStyle(
                          color: Colors.grey[600], fontSize: width * 0.04),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.02),
                      child: Icon(
                        Icons.sort,
                        size: width * 0.07,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04, top: 0),
              child: SizedBox(
                width: width,
                height: height * 0.47,
                child: ListView.builder(
                  itemCount: listmovimentacoes.length,
                  itemBuilder: (context, index) {
                    Movimentacoes mov = listmovimentacoes[index];
                    return CardMovimentacoesItem(
                      mov: mov,
                    );
                    /*return ListTile(
                      title: Text(mov.valor.toString()),
                      subtitle: Text(mov.tipo),
                    );*/
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

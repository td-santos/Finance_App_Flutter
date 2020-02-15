import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  final BarStyle barStyle;

  AnimatedBottomBar(
      {this.barItems,
      this.animationDuration = const Duration(milliseconds: 500),
      this.onBarTap, this.barStyle});

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 1;

  

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      elevation: 10,
      child: Padding(
        padding:  EdgeInsets.only(
          bottom: width * 0.07, //32.0,
          top: width * 0.04,//16.0,
          left:width * 0.04,// 16.0,
          right:width * 0.04,// 16.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildBarItems(context, width),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems(BuildContext contex,double largura) {
    List<Widget> _barItems = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding:  EdgeInsets.symmetric(horizontal: largura * 0.03 , vertical: largura * 0.008),
          duration: widget.animationDuration,
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                item.iconData,
                color: isSelected ? item.color : Colors.black,
                size: widget.barStyle.iconSize,
              ),
              SizedBox(
                width: largura * 0.01,
              ),
              AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                vsync: this,
                child: Text(
                  isSelected ? item.text : "",
                  style: TextStyle(
                      color: item.color,
                      fontWeight: widget.barStyle.fontWeight,
                      fontSize: widget.barStyle.fontSize),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}

class BarStyle {
  final double fontSize, iconSize;
  final FontWeight fontWeight;
  
  

  BarStyle({this.fontSize = 16.0, this.iconSize = 32, this.fontWeight = FontWeight.w600});
}

class BarItem {
  String text;
  IconData iconData;
  Color color;

  BarItem({this.text, this.iconData, this.color});
}
import 'package:flutter/material.dart';
import 'package:flutter_appdfd/provider/Count.dart';
import 'package:provide/provide.dart';


class ShopPages extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return ShopPagesState();
  }

}
class ShopPagesState extends State<ShopPages>{
  @override
  Widget build(BuildContext context) {

     return Scaffold(
       appBar: AppBar(
         title: Text("购物车"),
       ),
       body: Column(
         children: [
           Number(),
           Btn()
         ],
       ),
     );
  }

}

//
class Number extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Provide<Count>(builder: (context,ch,Count){
      return Text("${Count.num}");
    });
  }
}

class Btn extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return RaisedButton(onPressed: (){
      Provide.value<Count>(context).add();

    });
  }
}
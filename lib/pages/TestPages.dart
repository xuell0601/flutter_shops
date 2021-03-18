import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestPageState();
  }
}

class TestPageState extends State<TestPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body:Container(

        child:  Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: 400,
                    color: Colors.blue,
                    child: Text("sd"),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 400,
                    color: Colors.red,
                    child: Text("sd"),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 400,
                    color: Colors.blue,
                    child: Text("sd"),
                  ),
                ),


                //wrap组件
              ],

            ),
            Wrap(

              spacing: 20,
              children: <Widget>[
                RaisedButton(
                  child: Text("点击"),
                ),
                RaisedButton(
                  child: Text("点击"),
                ),
                RaisedButton(
                  child: Text("点击"),
                ),
                RaisedButton(
                  child: Text("点击"),
                ),
                RaisedButton(
                  child: Text("点击"),
                ),
                RaisedButton(
                  child: Text("点击"),
                ),

             
              ],
            ),

          ],
        ),
      ),
    );
  }
}

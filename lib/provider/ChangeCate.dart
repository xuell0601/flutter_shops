import 'package:flutter/material.dart';
import 'package:flutter_appdfd/model/CateModel.dart';
class ChangeCate with ChangeNotifier{
  List<Children> children=[];
  int pageindex=0;
  int leftindex=0;
  getCateData(List<Children> children){
    this.children=children;
   notifyListeners();
  }

  onClick(index){
    this.pageindex=index;
  notifyListeners();
  }
  onLeftClick(index){
    this.leftindex=index;
    notifyListeners();
  }
}
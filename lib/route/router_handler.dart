import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_appdfd/pages/DetailsPage.dart';



Handler detailsHanderl =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String goodsId = params['id'].first;
      print('index>details goodsID is ${goodsId}');
      return DetailsPage(goodsId);

    }
);
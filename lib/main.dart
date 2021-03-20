import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appdfd/provider/ChangeCate.dart';
import 'package:flutter_appdfd/provider/Count.dart';
import 'package:flutter_appdfd/route/Application.dart';
import 'package:flutter_appdfd/route/Routes.dart';
import 'package:flutter_appdfd/tabview/MainTbaview.dart';
import 'package:provide/provide.dart';


void main() {
      var count=Count();
      var changeCate=ChangeCate();
       var providers=Providers();
       providers..provide(Provider<Count>.value(count))
      ..provide(Provider<ChangeCate>.value(changeCate))
      ;
     
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "sd",
      onGenerateRoute: Application.router.generator,
      home: MainTabView(),
    );
  }
}

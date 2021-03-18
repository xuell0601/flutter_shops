import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appdfd/model/CateModel.dart';
import 'package:flutter_appdfd/net/HttpManger.dart';
import 'package:flutter_appdfd/provider/ChangeCate.dart';
import 'package:flutter_appdfd/route/Application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CatePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CatePagesState();
  }
}

class CatePagesState extends State<CatePages>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("分类"),
        ),
        body: Container(
            child: Row(
          children: [
            //左侧导航栏的创建
            LeftNav(),
            Column(
              children: <Widget>[
                RightNav(),
                RightContent()

              ],
            )
          ],
        )));
  }

  @override
  bool get wantKeepAlive => true;
}

//创建左侧导航条
class LeftNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeftNavState();
  }
}

class LeftNavState extends State<LeftNav> {
  List<Message> message = [];
  CateModel CateModels = null;
  //
  int lastindex=0;

  @override
  void initState() {
    super.initState();
    //请求数据分类数据
    getCate();
    //传值


  }

  void getCate() async {
    await getCateContent().then((value) {
      setState(() {
        CateModels = CateModel.fromJson(value);
        message = CateModels.message;
        var child=message[lastindex].children;
        //Provider<ChangeCate>.value(context).get(context);
        Provide.value<ChangeCate>(context).getCateData(child);

      });
    });
  }

   // toRightData(child ){
   //  if(child!=null){
   //    Provide.value<ChangeCate>(context).getCateData(child);
   //  }
   //
   // }

  // 左侧导航栏的创建
  Widget leftInkell(index) {


    return Container(
         color: lastindex==index?Colors.lightBlue:Colors.white,
        child: InkWell(
          onTap: (){
            setState(() {
              lastindex=index;
              var child=message[index].children;
              //Provider<ChangeCate>.value(context).get(context);
              Provide.value<ChangeCate>(context).getCateData(child);
              Provide.value<ChangeCate>(context).onLeftClick(lastindex);
              Provide.value<ChangeCate>(context).onClick(0);
            });

          },

          child: Container(
            height: ScreenUtil().setHeight(100),
            padding: EdgeInsets.fromLTRB(
                ScreenUtil().setHeight(30), ScreenUtil().setHeight(30), 0, 0),
            decoration: BoxDecoration(
                color: Colors.black12,
                border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Text(
              "${message[index].catName}",
              style: TextStyle(),
            ),
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return leftInkell(index);
        },
        itemCount: message.length,
      ),
    );
  }
}

//创建右侧列表
class RightNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RightNavState();
  }
}

class RightNavState extends State<RightNav> {

  var scrollController= new ScrollController();

  //创建数据列表
  //List<String> titles = ['茅台', '五粮液', '老榆林', '西凤酒', '五粮液', '老榆林', '西凤酒'];
  int lastindx=0;
  //创建item列表
  Widget itemsListview(index,String item) {
    return Container(

      child:  InkWell(
        onTap: (){
          setState(() {
            Provide.value<ChangeCate>(context).onClick(index);
            lastindx=index;
          });

        },
        child: Container(
          height: ScreenUtil().setHeight(80),
          margin: EdgeInsets.fromLTRB(ScreenUtil().setSp(10), 10, 10, 10),
          padding: EdgeInsets.all(2),
          color: lastindx==index?Colors.lightBlue:Colors.white,
          child: Text(
            item,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Provide<ChangeCate>(

           builder: (context,child,childCategory){
             lastindx=childCategory.pageindex;
             if(lastindx!=0){
                scrollController.jumpTo(0.0);
             }
             var children=childCategory.children;
             if(children==null||children.length==0){
               return Text("空");
             }else{
               return Container(
                 height: ScreenUtil().setHeight(80),
                 width: ScreenUtil().setWidth(570),
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                     border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
                 child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   itemCount: childCategory.children.length,
                   controller: scrollController,
                   itemBuilder: (context, index) {
                     return itemsListview(index,childCategory.children[index].catName);
                   },
                 ),
               );
             }

           },
    );
  }
}

class RightContent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RightContentState();
  }

}

class RightContentState extends State<RightContent>{

  List<Map> data=[];
  List childrens=[];
  int leftIndex=0;
  int  pageIndex=0;
  List childs=[];
  Widget _items(index,  children){

      return InkWell(
        onTap: (){
          Application.router.navigateTo(context,"/detail?id=${children[index]['cat_id']}");
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child:Container(
                child: Image.network("${children[index]['cat_icon']}"),
              ),
            ),
            Expanded(
              child:Container(
                child: Text("${children[index]['cat_name']}"),
              ),
            )


          ],
        ),
      );


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCateContent().then((value){
      data=(value['message'] as List).cast();

     setState(() {

       //List m= (data[0]['children'] as List).cast();
       childrens= (((data[0]['children'] as List).cast())[0]['children'] as List).cast();
     });

      //print("sssssssssssssss${ms.toString()}");
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(data.length==0){
      return Text("sddddd");
    }else{
      return Expanded(
        child: Provide<ChangeCate>(
          builder: (context,child,childCategory){
            leftIndex= childCategory.leftindex;
            pageIndex=childCategory.pageindex;
            var datas=((data[leftIndex]['children'] as List).cast())[pageIndex]['children'];
             if(datas==null){
               return Text("没有数据");
             }else{
               childs= (((data[leftIndex]['children'] as List).cast())[pageIndex]['children'] as List).cast();
               return Container(
                 width: ScreenUtil().setWidth(550),
                 margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), ScreenUtil().setWidth(5), ScreenUtil().setWidth(5), 0),
                 child: ListView.builder(
                     itemCount: childs.length,
                     itemBuilder: (context,index){
                       return _items(index,childs);
                     }),
               );
             }



          },
        ),
      );
    }

  }



}

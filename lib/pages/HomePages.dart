import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appdfd/net/HttpManger.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePagesState();
  }
}

class HomePagesState extends State<HomePages>
    with AutomaticKeepAliveClientMixin {
  //使用下拉加载页面数据
  int page = 1;

  //接受请求数据
  var hotList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //getHot();
  }

  void getHot() {
    print("再次执行");
    getHotContent(page).then((value) {
      List<Map> data = (value['data']['datas'] as List).cast();

      setState(() {
        //hotList
        hotList.addAll(data);
        page++;
      });
    });
  }

  Widget wrapList() {
    if (hotList.length != 0) {
      List<Widget> list = hotList.map((item) {
        print("000000000000000${item.toString()}");
        return InkWell(
          child: Container(
            width: ScreenUtil().setWidth(372),
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
            child: Column(
              children: [Text("0000000$item")],
            ),
          ),
        );
      }).toList();
      return Container(
        child: Wrap(
          spacing: 2,
          children: list,
        ),
      );
    } else {
      return Text("返回值为空");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("重新加载");
    return Scaffold(
        appBar: AppBar(
          title: Text("首页面"),
        ),
        body: Container(
          child: FutureBuilder(
            future: getHomePageContent(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                // case ConnectionState.none:
                //   return new Text(
                //       'Press button to start'); //如果_calculation未执行则提示：请点击开始
                // case ConnectionState.waiting:
                //   return new Text(
                //       'Awaiting result...'); //如果_calculation正在执行则提示：加载中
                default: //如果_calculation执行完毕
                  if (snapshot.hasError) //若_calculation执行出现异常
                    return new Text('Error: ${snapshot.error}');
                  else //若_calculation执行正常完成
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    List<Map> swiperDataList =
                        (data['message'] as List).cast(); // 顶部轮播组件数

                    var list_p = swiperDataList[1]['product_list'];
                    String src = list_p[0]['image_src'];
                    var list_t = swiperDataList[2]['product_list'];
                    //list_p.addAll(list_t);
                    //print("$list_p");
                    String phone = "15902906739";
                    String title = "火爆专区";
                    String recom = "商品推荐";
                    return EasyRefresh(
                      child: ListView(
                        children: [
                          Column(
                            children: <Widget>[
                              SwiperDiy(swiperDataList: swiperDataList),
                              //lou
                              TopNav(navList: list_p),
                              //广告页面
                              AdBanner(
                                src: src,
                              ),
                              //打电话

                              //推荐
                              Recomm(Recommlist: list_p),
                              //楼层
                              FoolorTitle(
                                title: recom,
                              ),
                              FoolorContent(
                                foolList: list_p,
                              ),
                              //
                              FoolorTitle(title: title),
                              wrapList()
                              //  Text("==")
                            ],
                          )
                        ],
                      ),
                      loadMore: () async {
                        await getHotContent(page).then(
                          (value) {
                            List<Map> data =
                                (value['data']['datas'] as List).cast();

                            setState(() {
                              //hotList
                              hotList.addAll(data);
                              page++;
                            });
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('加载中'),
                    );
                  }
              }
            },
          ),
        ));

    //创建火爆专区的请求数据
  }

  @override

  bool get wantKeepAlive => true;
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(334),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
              "${swiperDataList[1]['product_list'][index]['image_src']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
        onTap: (index) {
          print("${swiperDataList[index]['imagePath']}");
        },
      ),
    );
  }
}

//首页顶部导航
class TopNav extends StatelessWidget {
  List navList = [];

  Widget GridUi(context, item) {
    return InkWell(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "${item['image_src']}",
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(95),
              fit: BoxFit.cover,
            ),
            Text(
              "${item['name']}",
            )
          ],
        ),
      ),
    );
  }

  //接受一个List
  TopNav({Key key, this.navList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: navList.map((item) {
          //print("000000000$e");
          return GridUi(context, item);
        }).toList(),
      ),
    );
  }
}

//广告页面
class AdBanner extends StatelessWidget {
  String src;

  AdBanner({Key key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(100),
      padding: EdgeInsets.all(10),
      child: InkWell(
        child: Image.network(
          src,
          fit: BoxFit.cover,
          width: ScreenUtil().setWidth(750),
        ),
      ),
    );
  }
}

//拨打电话
// class LeadPhone extends StatelessWidget {
//   String phone;
//   String imageSrc;
//
//   LeadPhone({Key key, this.phone, this.imageSrc}) : super(key: key);
//
//   void _makePhoneCall() async {
//     // String _phone = "15902906739";
//     // String url='tel:$_phone';
//     String url = "taobao://item.taobao.com/item.html?id=41700658839";
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 20,
//       child: InkWell(
//         onTap: () {
//           _makePhoneCall();
//         },
//         child: Text("${phone}"),
//       ),
//     );
//   }
// }

//商品推荐
class Recomm extends StatelessWidget {
  List Recommlist;

  Recomm({Key key, this.Recommlist}) : super(key: key);

  //创建顶部导航
  Widget titleHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
      child: Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //创建推荐列表
  Widget recomList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
          itemCount: Recommlist.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _items(context, index);
          }),
    );
  }


  //创建条目数据
  Widget _items(context, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(350),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(ScreenUtil().setHeight(8.0)),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
                    width: ScreenUtil().setHeight(0.5), color: Colors.pink))),
        child: Column(
          children: [
            Image.network(
              Recommlist[index]['image_src'],
              fit: BoxFit.fill,
              height: ScreenUtil().setHeight(300),
            ),
            Text(
              "${Recommlist[index]['name']}",
              style: TextStyle(fontSize: ScreenUtil().setHeight(10)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(500),
      child: Column(
        children: [titleHeader(), recomList()],
      ),
    );
  }
}

//创建标题

class FoolorTitle extends StatefulWidget {
  String pic = null;
  String title = null;

  FoolorTitle({Key key, this.pic, this.title}) : super(key: key);

  @override
  FoolorTitleState createState() => FoolorTitleState();
}

class FoolorTitleState extends State<FoolorTitle> {
  @override
  Widget build(BuildContext context) {
    if (widget.pic == null) {
      return Text(
        widget.title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(70.0),
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(ScreenUtil().setHeight(8.0)),
        child: Image.network(
          "${widget.pic}",
          fit: BoxFit.fill,
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(200),
        ),
      );
    }
  }
}

//请求楼层内容
class FoolorContent extends StatelessWidget {
  List foolList;

  FoolorContent({Key key, this.foolList}) : super(key: key);

  Widget ImageUi(index) {
    return InkWell(
      child: Container(
        width: ScreenUtil().setWidth(360),
        child: Image.network(
          "${foolList[index]['image_src']}",
          width: ScreenUtil().setWidth(360),
        ),
      ),
    );
  }

  Widget _fistUi() {
    return Container(
      child: Row(
        children: [
          ImageUi(0),
          Column(
            children: [
              ImageUi(1),
              ImageUi(2),
            ],
          )
        ],
      ),
    );
  }

  Widget TwoUi() {
    return InkWell(
      child: Container(
        child: Row(
          children: [
            ImageUi(2),
            ImageUi(3),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(ScreenUtil().setHeight(8.0)),
        child: Column(
          children: [_fistUi(), TwoUi()],
        ));
  }
}

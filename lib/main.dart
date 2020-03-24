import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; //Used to decode jSON

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasty App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: tasty(),
    );
  }
}

var BannerItems = ["Burger", "Cheese chilly", "Noodles", "Pizza"];
var BannerItemsImages = [
  "assets/burger.jpg",
  "assets/cheesechilly.jpg",
  "assets/noodles.jpg",
  "assets/pizza.jpg"
];

class tasty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height; //nothing happened upon changing
    var screenwidth = MediaQuery.of(context).size.width; //nothing happened upon changing

    Future<List<Widget>> createlist() async {
      List<Widget> items = new List<Widget>();
      String dataString = await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJson = jsonDecode(dataString); //Parsing json data's

      dataJson.forEach((object) {

        String finalString = " ";
        List<dynamic> dataList = object["placeItems"];
        dataList.forEach((items){
          finalString = finalString + items + " | ";
        });
        items.add(Padding(padding: EdgeInsets.all(2.0),
          child: Container(

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 2.0, blurRadius: 5,)]),
            margin: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                  borderRadius:BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                  child: Image.asset(object["placeImage"], width: 80, height: 80,fit: BoxFit.cover,),),
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(object["placeName"]),
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 2),
                          child: Text(finalString,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12,color: Colors.black54),maxLines: 1,),
                        ),
                        Text('min order: ${object["minOrder"]}',style: TextStyle(fontSize: 12,color: Colors.black54),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      });
       return items;

          }


    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
          height: screenheight, //nothing happened upon changing
          width: screenwidth, //nothing happened upon changing
          child: SafeArea(
          child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //nothing happened upon changing
          children: <Widget>[
      Padding(
      padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu,size: 30,),onPressed: () {},),
          Text('Tasty',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,fontFamily: 'samantha'),),
          IconButton(icon: Icon(Icons.person,size: 30,),onPressed: () {},),
        ],
      ),
    ),
    BannerWidgetArea(),
    Container(child: FutureBuilder(
      initialData: <Widget>[Text("")],
    future: createlist(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
     return Padding(
    padding: EdgeInsets.all(8),
    child: ListView(
      primary: false,
      shrinkWrap: true,//above two lines are used to fix the issue when we have multiple things in single scrollview
      children: snapshot.data,
    ),);
    } else {
      return CircularProgressIndicator();
    }
    }),


    )
    ]
    ),

    ),
    ),
    ),
      floatingActionButton: FloatingActionButton( onPressed: (){},
        backgroundColor: Colors.black,
      child: Icon(Icons.fastfood, color: Colors.white,),
      )
      
   
      
    );
    }
  }

  class BannerWidgetArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var bannerscreenwidth = MediaQuery
      .of(context)
      .size
      .width;

  PageController controller =
  PageController(viewportFraction: 0.8, initialPage: 1);
  List<Widget> banners = new List<Widget>();

  for (int x = 0; x < BannerItems.length; x++) {
  var bannersview = Padding(
  padding: EdgeInsets.all(10),
  child: Container(
  child: Stack(
  fit: StackFit.expand,
  children: <Widget>[
  Container(
  decoration: BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  boxShadow: [
  BoxShadow(
  color: Colors.black38,
  offset: Offset(2.0, 2.0),
  spreadRadius: 1.0,
  blurRadius: 5,
  ),
  ]),
  ),
  ClipRRect(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  child: Image.asset(
  BannerItemsImages[x],
  fit: BoxFit.cover,
  ),
  ),
  Container(
  decoration: BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(20)),
  gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.transparent, Colors.black],
  )),
  ),
  Padding(
  padding: EdgeInsets.all(12),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Text(
  BannerItems[x],
  style: TextStyle(
  fontSize: 25,
  color: Colors.grey[200],
  ),
  ),
  Text(
  "More than 40% off",
  style: TextStyle(fontSize: 10, color: Colors.white),
  )
  ],
  ),
  )
  ],
  ),
  ),
  );
  banners.add(bannersview);
  }
  return Container(
  width: bannerscreenwidth,
  height: bannerscreenwidth * 9 / 16,
  child: PageView(
  controller: controller,
  scrollDirection: Axis.horizontal,
  children: banners,
  ),
  );
  }
  }

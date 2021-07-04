import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/models/company.dart';
import 'package:thetreeapptest/app/models/product.dart';
import 'package:thetreeapptest/app/utils/constants.dart';
import 'package:thetreeapptest/app/utils/strings.dart';
import 'package:thetreeapptest/app/widgets/myImage.dart';
import 'package:thetreeapptest/app/widgets/mygrid.dart';

class MyCard extends StatefulWidget {
  final Company company;
  const MyCard(this.company);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with TickerProviderStateMixin{
  List<Product> listProductsBig = [];
  List<Product> listProductsSmall = [];
  List<Product> listProductsBigAux = [];
  List<Product> listProductsSmallAux = [];

  List<Widget> listWidgets = [];

  int countHeroGrids = 0;
  int countDefaultGrids = 0;
  int slotsCount = 3;

  String buttonText = Strings.seeMore;
  bool flagExpanded = false;

  @override
  void initState() {
    this.separateListProducts();
    this.calculateFirstImages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.only(left: 4.0, right: 4.0, top: 10, bottom: 10),
        child: Column(children: [
            Container(
              margin: EdgeInsets.only(left: 5.0),
                alignment: Alignment.topLeft,
                child: MyImage(
                    imageUrl: this.widget.company.logo,
                    width: 70,
                    fit: BoxFit.cover
                )
            ),
            SizedBox(height: 10,),
            Stack(
              children: <Widget>[
                AnimatedSize(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 2),
                  vsync: this,
                  child: Column(
                    children: listWidgets,
                  ),
                ),
                Positioned(
                  child: showMoreButton(context),
                  bottom: 8,
                  right: 10,
                )
              ],
            ),
          ],
        )
      )
    );
  }

  void separateListProducts(){
    this.listProductsBig = this.widget.company.products.where((row) => (row.type == IMAGE_TYPE_BIG_SQUARE)).toList();
    this.listProductsBig.shuffle();
    this.listProductsSmall = this.widget.company.products.where((row) => (row.type == IMAGE_TYPE_SMALL_SQUARE)).toList();
    this.listProductsSmall.shuffle();
  }

  void calculateFirstImages(){
    this.listWidgets.add(MyGrid(type: GRID_TYPE_HERO_RIGHT, list: this.getBannerImages()));
  }

  List<Product> getBannerImages(){
    List<Product> list = [];
    if(listProductsBig.isNotEmpty){
      list.add(listProductsBig.first);
      listProductsBig.removeAt(0);
    } else{
      Product p = new Product(0, IMAGE_TYPE_BIG_SQUARE, this.widget.company.logo);
      list.add(p);
    }

    if(listProductsSmall.isNotEmpty){
      list.add(listProductsSmall.first);
      listProductsSmall.removeAt(0);
    } else {
      Product p = new Product(0, IMAGE_TYPE_SMALL_SQUARE, this.widget.company.logo);
      list.add(p);
    }

    if(listProductsSmall.isNotEmpty){
      list.add(listProductsSmall.first);
      listProductsSmall.removeAt(0);
    } else {
      Product p = new Product(0, IMAGE_TYPE_SMALL_SQUARE, this.widget.company.logo);
      list.add(p);
    }

    listProductsBigAux.addAll(this.listProductsBig);
    listProductsSmallAux.addAll(this.listProductsSmall);

    return list;
  }

  Widget showMoreButton(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        seeMoreLess();
      },
      child: Text(
        this.buttonText.toUpperCase(),
        style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 1.0,
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 12.0, left: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
        alignment: Alignment.center,
      )
    );
  }

  void seeMoreLess(){
    setState(() {
      if(flagExpanded){
        this.cleanWidgets();
        this.flagExpanded = false;
        this.buttonText = Strings.seeMore;
      } else {
        this.resetLists();
        this.calculateCountTypeExpandedList();
        this.generateGrids();
        this.flagExpanded = true;
        this.buttonText = Strings.seeLess;
      }
    });
  }

  void resetLists(){
    listProductsBig.clear();
    listProductsSmall .clear();
    listProductsBig.addAll(this.listProductsBigAux);
    listProductsSmall.addAll(this.listProductsSmallAux);
  }

  void calculateCountTypeExpandedList(){
    int bigProducts = this.listProductsBig.length;
    int smallProducts = this.listProductsSmall.length;

    if(smallProducts == 0 || bigProducts == 0){
      this.countDefaultGrids = this.slotsCount;
      this.countHeroGrids = 0;
    } else {
      int total = bigProducts + smallProducts;
      double percentageBigProducts = bigProducts / total;
      this.countHeroGrids = (percentageBigProducts * this.slotsCount).toInt();
      this.countDefaultGrids = this.slotsCount - countHeroGrids;
    }
  }

  void generateGrids(){
    var random = new Random();
    int randomN = 0;
    List<Product> listProds = [];
    for(int i = 0; i < this.slotsCount; i++){
      if((this.countHeroGrids + this.countDefaultGrids) == 0){
        break;
      }
      randomN = 1 + random.nextInt(4 - 1);
      switch (randomN) {
        case 1:
          if(countDefaultGrids != 0){
            listProds = this.getProductsForDefaultGrid();
            this.listWidgets.add(MyGrid(type: GRID_TYPE_DEFAULT, list: listProds));
            this.countDefaultGrids--;
          } else {
            i--;
          }
          break;
        case 2:
          if(countHeroGrids != 0){
            listProds = this.getProductsForHeroGrid();
            this.listWidgets.add(MyGrid(type: GRID_TYPE_HERO_RIGHT, list: listProds));
            this.countHeroGrids--;
          } else {
            i--;
          }
          break;
        case 3:
          if(countHeroGrids != 0){
            listProds = this.getProductsForHeroGrid();
            this.listWidgets.add(MyGrid(type: GRID_TYPE_HERO_LEFT, list: listProds));
            this.countHeroGrids--;
          } else {
            i--;
          }
          break;
      }
    }
  }

  List<Product> getProductsForDefaultGrid(){
    List<Product> list = [];
    for(int i = 0; i < 6; i++){
      if(listProductsSmall.isNotEmpty){
        list.add(listProductsSmall.first);
        listProductsSmall.removeAt(0);
      }
    }

    return list;
  }

  List<Product> getProductsForHeroGrid(){
    List<Product> list = [];

    if(listProductsBig.isEmpty || listProductsSmall.length < 2){
      return list;
    }

    if(listProductsBig.isNotEmpty){
      list.add(listProductsBig.first);
      listProductsBig.removeAt(0);
    }

    if(listProductsSmall.isNotEmpty){
      list.add(listProductsSmall.first);
      listProductsSmall.removeAt(0);
    }

    if(listProductsSmall.isNotEmpty){
      list.add(listProductsSmall.first);
      listProductsSmall.removeAt(0);
    }

    return list;
  }

  void cleanWidgets(){
    Widget w = this.listWidgets.first;
    listWidgets.clear();
    listWidgets.add(w);
  }
}
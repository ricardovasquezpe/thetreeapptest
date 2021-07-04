import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/models/product.dart';
import 'package:thetreeapptest/app/utils/constants.dart';
import 'package:thetreeapptest/app/widgets/myImage.dart';

class MyGrid extends StatelessWidget {
  String type = GRID_TYPE_DEFAULT;
  List<Product> list = [];

  MyGrid({
    required this.type,
    required this.list});

  @override
  Widget build(BuildContext context) {
    return getGridByType(context);
  }

  Widget getGridByType(BuildContext context){
    if(type == GRID_TYPE_HERO_LEFT){
      return getHeroLeftGrid(context);
    } else if(type == GRID_TYPE_HERO_RIGHT){
      return getHeroRightGrid(context);
    }

    return getDefaultGrid(context);
  }

  Widget getHeroRightGrid(BuildContext context){
    List<Product> bigImage = list.where((row) => (row.type == IMAGE_TYPE_BIG_SQUARE)).toList();
    List<Product> smallImage = list.where((row) => (row.type == IMAGE_TYPE_SMALL_SQUARE)).toList();

    return Align(
      child: Wrap(
        runSpacing: -130,
        children: [
          if(smallImage.isNotEmpty)
            FractionallySizedBox(
              widthFactor: 0.333,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                height: 130,
                child: MyImage(
                  borderRadius: 4,
                  imageUrl: smallImage.first.imageUrl,
                  fit: BoxFit.cover,
                  elevation: 3.0,
                ),
              ),
            ),
          if(bigImage.isNotEmpty)
            FractionallySizedBox(
              widthFactor: 0.667,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                height: 260,
                child: MyImage(
                  imageUrl: bigImage.first.imageUrl,
                  fit: BoxFit.cover,
                  borderRadius: 4,
                  elevation: 3.0,
                ),
              ),
            ),
          if(smallImage.length >= 2)
            FractionallySizedBox(
              widthFactor: 0.333,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                height: 130,
                child: MyImage(
                  imageUrl: smallImage[1].imageUrl,
                  fit: BoxFit.cover,
                  borderRadius: 4,
                  elevation: 3.0,
                ),
              ),
            )
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }

  Widget getHeroLeftGrid(BuildContext context){
    List<Product> bigImage = list.where((row) => (row.type == IMAGE_TYPE_BIG_SQUARE)).toList();
    List<Product> smallImage = list.where((row) => (row.type == IMAGE_TYPE_SMALL_SQUARE)).toList();

    return Align(
        child: Wrap(
            runSpacing: -130,
            alignment: WrapAlignment.end,
            children: [
              if(bigImage.isNotEmpty)
                FractionallySizedBox(
                  widthFactor: 0.667,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 260,
                    child: MyImage(
                      imageUrl: bigImage.first.imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: 4,
                        elevation: 3.0
                    ),
                  ),
                ),

              if(smallImage.isNotEmpty)
                FractionallySizedBox(
                  widthFactor: 0.333,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 130,
                    child: MyImage(
                      imageUrl: smallImage.first.imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: 4,
                        elevation: 3.0
                    ),
                  ),
                ),

              if(smallImage.length >= 2)
                FractionallySizedBox(
                  widthFactor: 0.333,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 130,
                    child: MyImage(
                      imageUrl: smallImage[1].imageUrl,
                      fit: BoxFit.cover,
                      borderRadius: 4,
                        elevation: 3.0
                    ),
                  ),
                )
            ],
          ),
        alignment: Alignment.topLeft,
      );
  }

  Widget getDefaultGrid(BuildContext context){
    List<Widget> widgets = [];

    list.forEach((element) {
      widgets.add(
        FractionallySizedBox(
          widthFactor: 0.333,
          child: Container(
            height: 130,
            padding: const EdgeInsets.all(5.0),
            child: MyImage(
              imageUrl: element.imageUrl,
              fit: BoxFit.cover,
              borderRadius: 4,
                elevation: 3.0
            ),
          ),
        )
      );
    });

    return Align(
        child: Wrap(
          children: widgets,
        ),
        alignment: Alignment.topLeft,
      );
  }
}
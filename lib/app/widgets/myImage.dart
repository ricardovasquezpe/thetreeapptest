import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/theme/custom_colors.dart';

class MyImage extends StatelessWidget {
  String imageUrl;
  double width;
  BoxFit fit;
  double borderRadius;
  double elevation;

  MyImage({
    required this.imageUrl,
    this.width = double.infinity,
    this.fit = BoxFit.none,
    this.borderRadius = 0,
    this.elevation = 0
  });

  @override
  Widget build(BuildContext context) {
    return this.getImage(context);
  }

  Widget getImage(BuildContext context){
    return
      Material(
        child: ClipRRect(
              child: CachedNetworkImage(
                  imageUrl: this.imageUrl,
                  width: this.width,
                  fit: this.fit,
                  progressIndicatorBuilder: (context, child, loadingProgress) {
                    return Center(
                        child: new CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation(CustomColors.gray)
                        )
                    );
                  },
                  errorWidget: (context, error, stackTrace) => Text('Some errors occurred!')),
              borderRadius: BorderRadius.circular(this.borderRadius)
          ),
          elevation: this.elevation
      );
  }
}
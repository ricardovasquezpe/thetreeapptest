import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thetreeapptest/app/models/company.dart';
import 'package:thetreeapptest/app/pages/home/presenter/homePresenter.dart';
import 'package:thetreeapptest/app/pages/home/view/homeView.dart';
import 'package:thetreeapptest/app/theme/custom_colors.dart';
import 'package:thetreeapptest/app/widgets/mycard.dart';
import 'package:thetreeapptest/app/widgets/myscaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeView{
  HomePresenter? _homePresenter;
  List<Widget> listCards = [];
  bool loadingMoreFlag = false;

  @override
  void initState() {
    _homePresenter = new HomePresenter(this);
    _homePresenter?.tryGetCompanyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        body: NotificationListener<ScrollNotification>(
              onNotification: (t) {
                if (t.metrics.pixels > 0 && t.metrics.atEdge && !this.loadingMoreFlag) {
                  loadingMore();
                  this.loadingMoreFlag = true;
                }
                return true;
              },
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: listCards,
                  )
              )
          )
    );
  }

  @override
  onSuccessGetCompanies(List<Company> listCompany) {
    setState(() {
      (listCards.isNotEmpty) ? listCards.removeLast() : null;
      listCompany.forEach((element) {
        listCards.add(MyCard(element));
        listCards.add(SizedBox(height: 10,));
      });
      loadingMoreFlag = false;
    });
  }

  void loadingMore(){
    setState(() {
      listCards.add(
          Container(
            height: 40,
            alignment: Alignment.center,
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: new CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(CustomColors.gray),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Loading More Sponsors")
                ],
              )
          )
      );
    });

    Timer(Duration(seconds: 3), () => _homePresenter?.tryGetCompanyList());
  }
}
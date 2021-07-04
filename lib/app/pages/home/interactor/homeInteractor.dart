import 'dart:convert';

import 'package:thetreeapptest/app/models/company.dart';
import 'package:thetreeapptest/app/pages/home/presenter/ihomePresenter.dart';
import 'package:thetreeapptest/app/utils/dependencies.dart';
import 'package:thetreeapptest/app/utils/network.dart';

class HomeInteractor{
  iHomePresenter? _iHomePresenter;
  final _network = getIt.get<Network>();
  int _limit = 10;
  int _offSet = 0;

  HomeInteractor(iHomePresenter presenter){
    _iHomePresenter = presenter;
  }

  void getListCompany(){
    this._network.dio.get("/bin/e0eb8f3b-a5b1-49dd-83a2-fb41dac817e6").then((response) {
      List<Company> list = List<Company>.from(json.decode(response.toString()).map((x) => Company.fromJson(x)));
      _offSet++;
      _iHomePresenter?.onSuccessGetCompanies(list);
    }).catchError((onError){
      _iHomePresenter?.onSuccessGetCompanies([]);
    });
  }
}
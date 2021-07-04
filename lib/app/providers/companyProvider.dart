import 'package:flutter/cupertino.dart';
import 'package:thetreeapptest/app/models/company.dart';

class PhotoProvider {
  List<Company> _companyList = <Company>[];
  int _limit = 10;
  int _offSet = 0;

  List<Company> get companyList => _companyList;
  int get limit => _limit;
  int get offSet => _offSet;

  set companyList(List<Company> list) {
    companyList = list;
  }
}
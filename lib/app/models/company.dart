import 'dart:convert';

import 'package:thetreeapptest/app/models/product.dart';

class Company{
  String name;
  String logo;
  List<Product> products;

  Company(this.name, this.logo, this.products);

  factory Company.fromJson(Map<String, dynamic> json) => new Company(
      json["companyName"] == null ? null : json["companyName"],
      json["logoImageNoPadding"] == null ? null : json["logoImageNoPadding"],
      json["productImages"] == null ? [] : new List<Product>.from(json["productImages"].map((x) => Product.fromJson(x)))
  );

  List<Company> CompaniesFromJson(String str) {
    return List<Company>.from(json.decode(str).map((x) => Company.fromJson(x)));
  }
}
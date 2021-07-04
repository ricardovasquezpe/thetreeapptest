class Product{
  int id;
  String type;
  String imageUrl;

  Product(this.id, this.type, this.imageUrl);

  factory Product.fromJson(Map<String, dynamic> json) => new Product(
    json["id"] == null ? null : json["id"],
    json["type"] == null ? null : json["type"],
    json["bigImgUrl"] == null ? null : json["bigImgUrl"],
  );
}
class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.cover,
    required this.desc,
    required this.price,
  });

  final int id;
  final String name;
  final String cover;
  final String desc;
  final int price;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        cover: json["cover"],
        desc: json["desc"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
        "desc": desc,
        "price": price,
      };
}

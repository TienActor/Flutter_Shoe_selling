class CategoryModel {
  int? id;
  String? name;
  String? imageURL;
  String? description;

  CategoryModel({this.id, this.name, this.imageURL, this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageURL = json['imageURL'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageURL'] = imageURL;
    data['description'] = description;
    return data;
  }
}

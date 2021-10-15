class BannerModel{

  int ? id;
  String ? image;
  String ? category;
  String ? product;
  BannerModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    image=json['image'];
    category=json['category'];
    product=json['product'];
  }
}
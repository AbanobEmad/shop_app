import 'package:shop/models/banner_model.dart';
import 'package:shop/models/product_model.dart';

class HomeModel{

  bool ? status;
  String ? message;
  HomeDataModel ? data;
  HomeModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=HomeDataModel.fromJson(json['data']);
  }

}

class HomeDataModel{

  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    }
    );
    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    }
    );
  }
}





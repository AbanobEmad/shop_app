import 'package:shop/models/product_model.dart';

class ChangeFavoritesModel{

  bool ? status;
  String ? message;
  ChangeFavoritesModel.fromjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }

}


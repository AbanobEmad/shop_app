import 'package:shop/models/userdata.dart';

class LoginModel
{
  bool ? status;
  String ? message;
  UserData ? data;

  LoginModel(this.data,this.message,this.status);

  LoginModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json['message'];
    data= json['data']!=null ? UserData.fromjson(json['data']) : null;
  }

}
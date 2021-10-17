import 'package:shop/models/loginmodel.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{

  final LoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{

  final error;

  ShopRegisterErrorState( this.error);

}

class ShopChangePasswordVisibilityRegisterState extends ShopRegisterStates{}
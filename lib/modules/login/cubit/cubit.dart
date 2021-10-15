

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/loginmodel.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());


  
  
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  LoginModel ? loginModel;

  void UserLogin({
    @required String ? email,
    @required String ? password,
})
  {
    emit(ShopLoginLoadingState());
    print('asd1');
    DioHelper.PostData(
        url: LOGIN,
        data:{
          'email': email,
          'password' : password
        }).then((value){
      print('asd2');
      loginModel= LoginModel.fromJson(value.data);
          emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  IconData suffix =Icons.visibility_outlined;
  bool isPassword=true;

  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }

}
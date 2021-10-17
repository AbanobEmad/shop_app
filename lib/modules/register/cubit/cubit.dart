
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/loginmodel.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());


  
  
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  LoginModel ? registerModel;

  void UserRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
})
  {
    emit(ShopRegisterLoadingState());
    print('asd1');
    DioHelper.PostData(
        url: REGISTER,
        data:{
          'name': name,
          'email': email,
          'password' : password,
          'phone' :phone

        }).then((value){
      registerModel= LoginModel.fromJson(value.data);
          emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData suffix =Icons.visibility_outlined;
  bool isPassword=true;

  void ChangePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityRegisterState());
  }

  IconData suffixConfirm =Icons.visibility_outlined;
  bool isConfirmPassword=true;

  void ChangeConfirmPasswordVisibility()
  {
    isConfirmPassword=!isConfirmPassword;
    suffixConfirm = isConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityRegisterState());
  }

}
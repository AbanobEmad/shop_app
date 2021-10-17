import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/shoplayout.dart';
import 'package:shop/modules/login/loginscreen.dart';
import 'package:shop/modules/register/cubit/cubit.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/components/buttoncustome.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/components/showtoast.dart';
import 'package:shop/shared/components/textfromfieldcusotme.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static const id='RegisterScreen';
  @override
  Widget build(BuildContext context) {
    var screenWidth =MediaQuery.of(context).size.width;
    var screenheight =MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.registerModel.status==true)
            {
              ShowToast(text: state.registerModel.message, state: ToastStates.SUCCESS);
              CacheHelper.SaveData(key: TOKEN, value: state.registerModel.data!.token).then((value) {

                token = state.registerModel.data!.token!;
                Navigator.pushReplacementNamed(context,HomeLayout.id );
              });

            }
            else{
              ShowToast(text: state.registerModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: defaultColor,
            appBar: AppBar(
              backgroundColor: defaultColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenheight/10,
                    width: double.infinity,
                  ),
                  Container(
                    height:800,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight: Radius.circular(50) ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Register',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            TextFormCustome(
                                lable: 'User Name',
                                prefix: Icons.person,
                                controller: userNameController,
                                typeText: TextInputType.text,
                                validate:(String? value)
                                {
                                  print(value);
                                  if(value!.isEmpty)
                                  {
                                    print(value);
                                    return 'The user Name must not empty';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormCustome(
                                lable: 'Email',
                                prefix: Icons.email,
                                controller: emailController,
                                typeText: TextInputType.text,
                                validate:(String? value)
                                {
                                  print(value);
                                  if(value!.isEmpty)
                                  {
                                    print(value);
                                    return 'The Email must not empty';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormCustome(
                                lable: 'confirm Password',
                                prefix: Icons.lock_open,
                                controller: confirmPasswordController,
                                typeText: TextInputType.visiblePassword,
                                isPassword: ShopRegisterCubit.get(context).isPassword,
                                suffix: ShopRegisterCubit.get(context).suffix,
                                suffixPressed: (){
                                  ShopRegisterCubit.get(context).ChangePasswordVisibility();
                                },
                                validate:(String? value)
                                {
                                  if(value!.isEmpty&&value.length<8)
                                  {
                                    print(value);
                                    return 'The Password must be atleast 8 character or number';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormCustome(
                                lable: 'Password',
                                prefix: Icons.lock_open,
                                controller: passwordController,
                                typeText: TextInputType.visiblePassword,
                                isPassword: ShopRegisterCubit.get(context).isConfirmPassword,
                                suffix: ShopRegisterCubit.get(context).suffixConfirm,
                                suffixPressed: (){
                                  ShopRegisterCubit.get(context).ChangeConfirmPasswordVisibility();
                                },
                                validate:(String? value)
                                {
                                  if(passwordController.text!=confirmPasswordController.text)
                                  {
                                    print(value);
                                    return 'Not confirm password';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormCustome(
                                lable: 'Phone',
                                prefix: Icons.phone,
                                controller: phoneController,
                                typeText: TextInputType.phone,
                                validate:(String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'The phone must not empty';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              fallback:(context)=> Center(child: CircularProgressIndicator(),),
                              builder: (context)=>ButtonCustome(
                                  onpassed: (){

                                    if(formKey.currentState!.validate())
                                    {
                                      ShopRegisterCubit.get(context).UserRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: userNameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  context: context,
                                  title: 'register'
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                    'Have An Account ?'
                                ),

                                TextButton(
                                    onPressed: (){
                                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                                    },
                                    child: Text('login'.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),)),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

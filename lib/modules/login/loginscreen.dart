import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shoplayout.dart';
import 'package:shop/modules/login/cubit/cubit.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/modules/register/registerscreen.dart';
import 'package:shop/shared/components/buttoncustome.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/components/showtoast.dart';
import 'package:shop/shared/components/textfromfieldcusotme.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  static const String id='LoginScreen';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var screenWidth =MediaQuery.of(context).size.width;
    var screenheight =MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status==true)
                {
                  ShowToast(text: state.loginModel.message, state: ToastStates.SUCCESS);
                  CacheHelper.SaveData(key: TOKEN, value: state.loginModel.data!.token);
                  Navigator.pushReplacementNamed(context,HomeLayout.id );
                }
              else{
                ShowToast(text: state.loginModel.message, state: ToastStates.ERROR);
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
                    height:screenheight- (screenheight/5),
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
                              'Login',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40),
                            ),
                            SizedBox(
                              height: 50,
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
                                lable: 'Password',
                                prefix: Icons.lock_open,
                                controller: passwordController,
                                typeText: TextInputType.visiblePassword,
                                isPassword: ShopLoginCubit.get(context).isPassword,
                                suffix: ShopLoginCubit.get(context).suffix,
                                suffixPressed: (){
                                  ShopLoginCubit.get(context).ChangePasswordVisibility();
                                },
                                validate:(String? value)
                                {
                                  print(value);
                                  if(value!.isEmpty&&value.length<8)
                                  {
                                    print(value);
                                    return 'The Password must be atleast 8 character or number';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              fallback:(context)=> Center(child: CircularProgressIndicator(),),
                                builder: (context)=>ButtonCustome(
                                    onpassed: (){
                                      if(formKey.currentState!.validate())
                                      {
                                        ShopLoginCubit.get(context).UserLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    context: context,
                                    title: 'LOGIN'
                                ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                    'Don\'t Have An Account ?'
                                ),

                                  TextButton(
                                      onPressed: (){
                                        Navigator.pushReplacementNamed(context, RegisterScreen.id);
                                      },
                                      child: Text('register'.toUpperCase(),
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

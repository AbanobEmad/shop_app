import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/modules/login/loginscreen.dart';
import 'package:shop/shared/components/buttoncustome.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/components/showtoast.dart';
import 'package:shop/shared/components/textfromfieldcusotme.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/styles/colors.dart';

class SettingScreen extends StatefulWidget {

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  List<bool> readOnly=[
    true,
    true,
    true
  ];
  @override
  Widget build(BuildContext context) {
    double hight=MediaQuery.of(context).size.height;
    var emailController =TextEditingController();
    var userNameController =TextEditingController();
    var phoneController =TextEditingController();

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessUpdataUserDataStates)
          {
            if(state.loginModel.status==false)
              {
                ShowToast(text: state.loginModel.message, state: ToastStates.ERROR);
              }
            else
              {
                ShowToast(text: state.loginModel.message, state: ToastStates.SUCCESS);
              }
          }
      },
      builder: (context,state){
        var shopcuibt = ShopCubit.get(context);
        userNameController.text =shopcuibt.userData!.data!.name!;
        emailController.text =shopcuibt.userData!.data!.email!;
        phoneController.text =shopcuibt.userData!.data!.phone!;
        return Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.purple.withOpacity(.4), defaultColor],
                          )
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 4*(hight/5),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,90,20,20 ),
                        child: Column(
                          children: [
                            TextFormCustome(
                                lable: 'UserName',
                                prefix: Icons.person,
                                controller: userNameController,
                                typeText: TextInputType.text,
                                validate: null,
                              readOnly: readOnly[0],
                              suffix: Icons.edit,
                              suffixPressed: (){
                                  setState(() {
                                    readOnly[0]=!readOnly[0];
                                  });
                              }
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormCustome(
                                lable: 'Email',
                                prefix: Icons.email,
                                controller: emailController,
                                typeText: TextInputType.text,
                                validate: null,
                                readOnly: readOnly[1],
                                suffix: Icons.edit,
                                suffixPressed: (){
                                  setState(() {
                                    readOnly[1]=!readOnly[1];
                                  });
                                }
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormCustome(
                                lable: 'Phone',
                                prefix: Icons.phone,
                                controller: phoneController,
                                typeText: TextInputType.text,
                                validate: null,
                                readOnly: readOnly[0],
                                suffix: Icons.edit,
                                suffixPressed: (){
                                  setState(() {
                                    readOnly[0]=!readOnly[0];
                                  });
                                }
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Points ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: defaultColor.withOpacity(.8),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text(
                                    '${shopcuibt.userData!.data!.points}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonCustome(
                                onpassed: !readOnly[0]||!readOnly[1]||!readOnly[2]  ? ()=> shopcuibt.updataData(
                                    name: userNameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text
                                ) : null,
                                context: context,
                                title: 'Update data'),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: ()=>SignOut(),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'LOGOUT',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 170-60,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('${shopcuibt.userData!.data!.image}'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 17,
                            child: Icon(
                              Icons.camera_alt,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        );
      },
    );
  }
  void SignOut()
  {
    CacheHelper.RemoveData(key: token).then((value) {
      if(value)
        {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }

    } );
  }
}

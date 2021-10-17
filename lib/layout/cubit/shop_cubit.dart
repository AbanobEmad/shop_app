import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/changefavorites_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/loginmodel.dart';
import 'package:shop/modules/categories/cateogries_screen.dart';
import 'package:shop/modules/favorites/favorites_screen.dart';
import 'package:shop/modules/productes/productes_screen.dart';
import 'package:shop/modules/setting/setting_screen.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super (ShopInitialStates());

  static ShopCubit get(context) =>BlocProvider.of(context);
  
  var pagecontroller =PageController();
  
  List<Widget> PageViews=[
    ProductesScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingScreen()
  ];
  
  void ChangeBottomNavBar(int index)
  {
    pagecontroller.animateToPage(
        index,
        duration: Duration(milliseconds:600),
        curve: Curves.bounceOut
    );
    emit(ShopChangeIndexStates());
  }
  HomeModel ? homeModel;

  Map<int,bool> favorites={};
  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!:element.in_favorites!
        });
      });
      emit(ShopSuccessHomeDataStates());
    }).catchError((Erorr) {
      emit(ShopErrorHomeDataStates(Erorr));
    });
  }

    CategoryModel ? categoryModel;
    void getCategories(){
      emit(ShopLoadingGetCategoriesStates());

      DioHelper.getData(
          url: GET_CATEGORIES,
      ).then((value) {
        categoryModel=CategoryModel.fromJson(value.data);
        emit(ShopSuccessGetCategoriesStates());
      }).catchError((Erorr){
        print(Error);
        emit(ShopErrorGetCategoriesStates(Erorr));
      });
  }
  
  void ChangeFavorites(int productId)
  {
    favorites[productId]=!favorites[productId]!;
    emit(ShopLoadingChangeFavoritesStates());
    
    DioHelper.PostData(
        url: FAVORITES,
        data: {
          'product_id' : productId
        },
        token: token
    ).then((value){
      ChangeFavoritesModel favoritesModel=ChangeFavoritesModel.fromjson(value.data);
      if(!favoritesModel.status!)
        {
          favorites[productId]=!favorites[productId]!;
        }
      else
        {
          getFavorites();
        }
      emit(ShopSuccessChangeFavoritesStates(favoritesModel));
    }).catchError((error){
      favorites[productId]=!favorites[productId]!;
      emit(ShopErrorChangeFavoritesStates(error));
    });
    
  }

  FavoritesModel ? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesStates());

    DioHelper.getData(
      url: FAVORITES,
      token: token
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((Erorr){
      print(Error);
      emit(ShopErrorGetFavoritesStates(Erorr));
    });
  }


  LoginModel ? userData;
  void getUserData(){
    emit(ShopLoadingGetUserDataStates());

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userData=LoginModel.fromJson(value.data);
      loginModelConst=userData;
      emit(ShopSuccessGetUserDataStates());
    }).catchError((Erorr){
      print(Error);
      emit(ShopErrorGetUserDataStates(Erorr));
    });
  }

  LoginModel ? updataUserData;
  void updataData({
  required String name,
    required String email,
    required String phone,

}){
    emit(ShopLoadingUpdataUserDataStates());
    print(token);
    DioHelper.PutData(
        url: EDIT_PROFILE,
        token: token,
      data:{
          'name' : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value) {
      updataUserData=LoginModel.fromJson(value.data);
      if(!updataUserData!.status!)
        userData=loginModelConst;
      else
        userData=updataUserData;
      emit(ShopSuccessUpdataUserDataStates(updataUserData!));
    }).catchError((Erorr){
      print(Error);
      emit(ShopErrorUpdataUserDataStates(Erorr));
    });
  }

}
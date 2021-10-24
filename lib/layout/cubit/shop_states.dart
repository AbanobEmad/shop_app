import 'package:shop/models/changefavorites_model.dart';
import 'package:shop/models/loginmodel.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates{}

class ShopChangeIndexStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{

  final  error;

  ShopErrorHomeDataStates(this.error);

}

class ShopLoadingGetCategoriesStates extends ShopStates{}

class ShopSuccessGetCategoriesStates extends ShopStates{}

class ShopErrorGetCategoriesStates extends ShopStates{

  final  error;

  ShopErrorGetCategoriesStates(this.error);

}

class ShopLoadingChangeFavoritesStates extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoritesModel favoritesModel;

  ShopSuccessChangeFavoritesStates(this.favoritesModel);

}

class ShopErrorChangeFavoritesStates extends ShopStates{

  final  error;

  ShopErrorChangeFavoritesStates(this.error);

}

class ShopLoadingGetFavoritesStates extends ShopStates{}

class ShopSuccessGetFavoritesStates extends ShopStates{}

class ShopErrorGetFavoritesStates extends ShopStates{

  final  error;

  ShopErrorGetFavoritesStates(this.error);

}

class ShopLoadingGetUserDataStates extends ShopStates{}

class ShopSuccessGetUserDataStates extends ShopStates{}

class ShopErrorGetUserDataStates extends ShopStates{

  final  error;

  ShopErrorGetUserDataStates(this.error);

}

class ShopLoadingUpdataUserDataStates extends ShopStates{}

class ShopSuccessUpdataUserDataStates extends ShopStates{
  final LoginModel loginModel;

  ShopSuccessUpdataUserDataStates(this.loginModel);
}

class ShopErrorUpdataUserDataStates extends ShopStates{

  final  error;

  ShopErrorUpdataUserDataStates(this.error);

}

class ShopLoadingProductOfCategoryStates extends ShopStates{}

class ShopSuccessProductOfCategoryStates extends ShopStates{}

class ShopErrorProductOfCategoryStates extends ShopStates{

  final  error;

  ShopErrorProductOfCategoryStates(this.error);

}
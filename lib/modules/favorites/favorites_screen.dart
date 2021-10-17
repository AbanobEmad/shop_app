import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var shopCubit=ShopCubit.get(context);
        return SafeArea(
          top: true,
          child: ConditionalBuilder(
            condition: state is! ShopLoadingChangeFavoritesStates,
            builder: (context){
              return Scaffold(
                body: ListView.separated(
                    itemBuilder: (context,index)=>BuiltFavoriteItem(shopCubit.favoritesModel!.data!.data![index],context),
                    separatorBuilder:(context,index)=> Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    itemCount: shopCubit.favoritesModel!.data!.data!.length
                ),
              );
            },
            fallback: (context)=>Center(child: CircularProgressIndicator(),),
          ),
        );
      }
    );
  }

  Widget BuiltFavoriteItem(Data model,context)=>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    width: 120,
                    height: 120,
                  ),
                  if(model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          color: Colors.black
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          'Price / ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${model.product!.price} \$',
                          style: TextStyle(
                              fontSize: 14,
                              color: defaultColor
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if(model.product!.discount != 0)
                          Text(
                            '${model.product!.oldPrice} \$',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                            ),
                          ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            ShopCubit.get(context).ChangeFavorites(model.product!.id!);
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 20,
                            color: Colors.purple
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

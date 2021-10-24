import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/models/porducts_of_category.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductsOfCategory extends StatelessWidget {
  static const String id='ProductsOfCategory';
  var productId;
  ProductsOfCategory(this.productId);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var shopCubit=ShopCubit.get(context);
          return SafeArea(
            top: true,
            child: Scaffold(
              body: ConditionalBuilder(
                condition: shopCubit.productsOfCategory!.data!.data!.length!=0,
                builder: (context){
                  print(shopCubit.productsOfCategory!.data!.data!.length);
                  return ListView.separated(
                        itemBuilder: (context,index){
                          print(shopCubit.productsOfCategory!.data!.data![index].name);
                          return BuiltFavoriteItem(shopCubit.productsOfCategory!.data!.data![index],context);},
                        separatorBuilder:(context,index)=> Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                        itemCount: shopCubit.productsOfCategory!.data!.data!.length
                  );
                },
                fallback: (context)=>Center(child: CircularProgressIndicator(),),
              ),
            ),
          );
        }
    );
  }
  Widget BuiltFavoriteItem(ProductModel model,context)=>
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
                    image: NetworkImage('${model.image}'),
                    width: 120,
                    height: 120,
                  ),
                  if(model.discount != 0)
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
                      model.name!,
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
                          '${model.price} \$',
                          style: TextStyle(
                              fontSize: 14,
                              color: defaultColor
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if(model.discount != 0)
                          Text(
                            '${model.old_price} \$',
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
                            ShopCubit.get(context).ChangeFavorites(model.id!);
                          },
                          child: Icon(
                            ShopCubit
                                .get(context)
                                .favorites[model.id]! ? Icons.favorite : Icons
                                .favorite_border,
                            size: 20,
                            color:ShopCubit
                                .get(context)
                                .favorites[model.id]!? Colors.purple : Colors
                                .grey,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/modules/products_of_category/products_of_category.dart';

class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var shopCubit = ShopCubit.get(context);
        return Scaffold(
          body: ListView.separated(
              itemBuilder: (context,index)=>BuildCategory(shopCubit.categoryModel!.data!.data![index],context,shopCubit),
              separatorBuilder: (context,index)=> Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              itemCount: shopCubit.categoryModel!.data!.data!.length
          ),
        );
      },
    );
  }

  Widget BuildCategory(DataModel model,context,ShopCubit shopCubit)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: GestureDetector(
      onTap: (){
        shopCubit.getProductOfCategory(model.id.toString()).then(
                (value) => Navigator.pushNamed(context, ProductsOfCategory.id,arguments:model.id));
        ;
      },
      child: Container(
        height: 130,
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 120,
                width: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
                '${model.name}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            )
          ],
        ),
      ),
    ),
  );
}

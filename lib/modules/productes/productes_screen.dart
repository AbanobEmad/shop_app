import 'dart:math';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/shared/components/showtoast.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductesScreen extends StatefulWidget {
  @override
  _ProductesScreenState createState() => _ProductesScreenState();
}

class _ProductesScreenState extends State<ProductesScreen> {

  var indexIndicator=0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopSuccessChangeFavoritesStates)
            {
              if(!state.favoritesModel.status!)
                {
                  ShowToast(
                      text: state.favoritesModel.message,
                      state: ToastStates.ERROR
                  );
                }
            }
        },
        builder:(context,state){
          var shopCubit=ShopCubit.get(context);
          return ConditionalBuilder(
              condition: shopCubit.homeModel!=null&&shopCubit.categoryModel!=null,
              builder: (context)=>ProductsBuilder(shopCubit.homeModel!,shopCubit.categoryModel!,context),
            fallback: (context){
                return Center(
                  child: CircularProgressIndicator(),
                );},
          );
        } ,
      ),
    );
  }

  Widget ProductsBuilder(HomeModel model , CategoryModel categoryModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: _controller,
            items: model.data!.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index,reason)
              {
                setState(() {
                  indexIndicator=index;
                });
              }
            ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: model.data!.banners.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : defaultColor)
                          .withOpacity(indexIndicator == entry.key ?1.0 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>BuildCategoryItem(categoryModel.data!.data![index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 3,),
                    itemCount: categoryModel.data!.data!.length
                )
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.grey,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1/1.2,
            children: List.generate(model.data!.products.length,
                    (index) => BuildGridProduct(model.data!.products[index],context)),
          ),
        ),

      ],
    ),
  );

  Widget BuildCategoryItem(DataModel dataModel)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${dataModel.image}'),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(
          '${dataModel.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );

  Widget BuildGridProduct(ProductModel model,context) {
    double hight=MediaQuery.of(context).size.width;
    hight/=2;
    hight*=1.2;
    hight-=64;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: hight,
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
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        color: Colors.black
                    ),
                  ),
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
                          color: ShopCubit
                              .get(context)
                              .favorites[model.id]! ? Colors.purple : Colors
                              .grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

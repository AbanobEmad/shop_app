import 'package:flutter/material.dart';
import 'package:shop/models/boarding.dart';
import 'package:shop/modules/login/loginscreen.dart';
import 'package:shop/shared/components/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {

  static const String id='OnBoardingScrren';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast=false;

  List<BoardingModel> boardings = [
    BoardingModel(
        urlImage: 'assets/images/1.jpg',
        title: 'Brows App And Order Now',
        body: 'We have many choise for you Go and select what you want .'),
    BoardingModel(
        urlImage: 'assets/images/2.jpg',
        title: 'Best Donut In Your Area',
        body:
            'We provide best prouduct to our customer healthy and hygienic .'),
    BoardingModel(
        urlImage: 'assets/images/3.jpg',
        title: 'You Can Order From Anywhere',
        body: 'We provide home delivery you can order from anywhere .'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: Submit,
                child: Text('SKIP',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: pageController,
                  itemBuilder: (context, index) =>
                      BuildBoardingItem(boardings[index], context),
                  itemCount: 3,
                  onPageChanged: (index){
                    if(index==boardings.length-1)
                      {
                        setState(() {
                          isLast=true;
                        });
                      }
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                    effect: SwapEffect(
                      type: SwapType.yRotation,
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      radius: 7,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast)
                        {
                          Submit();
                        }
                      else
                        {
                          pageController.nextPage(duration: Duration(
                            seconds: 1,
                          ), curve: Curves.bounceOut);
                        }
                    },
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget BuildBoardingItem(BoardingModel boardingModel, context) => Column(
        children: [
          Expanded(
              child: Image(
            image: AssetImage('${boardingModel.urlImage}'),
          )),
          SizedBox(
            height: 20,
          ),
          Text(
            '${boardingModel.title}',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text('${boardingModel.body}',
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center),
          SizedBox(
            height: 20,
          ),
        ],
      );
  
  void Submit()
  {
    CacheHelper.SaveData(key: ONBOARDING, value: true).then((value) {
      if(value)
        {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:shop/shared/styles/colors.dart';

Widget ButtonCustome({
  @required void Function()? onpassed,
  @required BuildContext? context,
  @required String ? title,
}) =>
    Center(
      child: Container(
        width: 200,
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.withOpacity(.4), defaultColor],
          ),
        ),
        child: MaterialButton(
          onPressed: onpassed,
          shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title!,
              style: Theme.of(context!)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 25),
            ),
          ),
        ),
      ),
    );

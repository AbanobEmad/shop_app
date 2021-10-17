import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/shared/styles/colors.dart';

Widget TextFormCustome({
  @required String ? lable,
  @required IconData ? prefix,
  @required TextEditingController ? controller,
  @required TextInputType ? typeText,
  @required String? Function(String?)? validate,
  bool  isPassword  = false,
  IconData ? suffix,
  bool  readOnly=false,
  void Function() ? suffixPressed,
}) =>
    TextFormField(
      readOnly: readOnly,
      controller: controller,
      obscureText: isPassword,
      keyboardType: typeText,
      validator : validate,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        labelText: lable,
        suffixIcon:suffix!=null ?
       IconButton(
           onPressed: suffixPressed,
           icon: Icon(suffix)
       ): null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: defaultColor)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: defaultColor)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: defaultColor)
        ),
      ),
    );

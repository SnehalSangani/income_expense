import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:income_expense/screen/income/view/income_screen.dart';
import 'package:income_expense/screen/transection/view/transection_screen.dart';
void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => incomescreen()),
        GetPage(name: '/transection', page: () => transectionscreen()),
      ]
    )
  );
}
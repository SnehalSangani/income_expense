import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/transection_controller.dart';

class transectionscreen extends StatefulWidget {
  const transectionscreen({Key? key}) : super(key: key);

  @override
  State<transectionscreen> createState() => _transectionscreenState();
}

class _transectionscreenState extends State<transectionscreen> {
  Transactioncontroller controller = Get.put(Transactioncontroller());

  @override
  void initState() {
    super.initState();
    controller.readtransection();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
         () =>  ListView.builder(itemBuilder: (context, index) {
           return ListTile(
              title: Text("${controller.transectionlist[index]['category']}"),
            );
          },itemCount: controller.transectionlist.length,),
        )
      ),
    );
  }
}

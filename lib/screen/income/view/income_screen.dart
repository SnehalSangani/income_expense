import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screen/transection/controller/transection_controller.dart';
import 'package:income_expense/utils/db_helper.dart';

class incomescreen extends StatefulWidget {
  const incomescreen({Key? key}) : super(key: key);

  @override
  State<incomescreen> createState() => _incomescreenState();
}

class _incomescreenState extends State<incomescreen> {
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpaytype = TextEditingController();
  TextEditingController txtstatus = TextEditingController();
  TextEditingController txtdate = TextEditingController(text: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  Transactioncontroller transactioncontroller = Get.put(Transactioncontroller());
  @override
  void initState() {
    // TODO: implement initState
    Dbhelper dbhelper = Dbhelper();
    dbhelper.checkdb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Income Expense"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(controller: txtcate,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Category"),fillColor: Colors.black),

                ),
                SizedBox(height: 10,),
                TextField(controller: txtamount,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Amount"),fillColor: Colors.black),
                ),
                SizedBox(height: 10,),
                TextField(controller: txtnote,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Note"),fillColor: Colors.black),
                ),
                SizedBox(height: 10,),
                TextField(controller: txtpaytype,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Paytype"),fillColor: Colors.black),
                ),
                SizedBox(height: 10,),
                TextField(controller: txtdate,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Date"),fillColor: Colors.black),
                ),
                SizedBox(height: 10,),
                TextField(controller: txttime,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Time"),fillColor: Colors.black),
                ),
                SizedBox(height: 10,),
                TextField(controller: txtstatus,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Status"),fillColor: Colors.black),
                ),
                SizedBox(height: 10,),

                ElevatedButton(
                  child: Text("Insert"),
                  onPressed: () {
                    Dbhelper dbhelper = Dbhelper();
                    dbhelper.insertdata(
                        category:txtcate.text,
                        amount: txtamount.text,
                        status: txtstatus.text,
                        notes: txtnote.text,
                        date: txtdate.text,
                        time: txttime.text,
                        paytype: txtpaytype.text);
                    print(dbhelper.database);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                ),
                ElevatedButton(onPressed: () {
                  transactioncontroller.readtransection();
                  Get.toNamed('/transection');
                }, style:ElevatedButton.styleFrom(backgroundColor: Colors.black),child: Text("Read"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

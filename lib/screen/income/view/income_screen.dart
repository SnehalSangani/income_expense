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
  TextEditingController txtdate = TextEditingController(text: "Date");
  TextEditingController txttime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  Transactioncontroller transactioncontroller =
      Get.put(Transactioncontroller());

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        content: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) => categoryList[index],
                          shrinkWrap: true,
                          itemCount: 6,
                        ),
                        title: 'Category');
                  },
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Category',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 17)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtamount,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Amount"),
                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtnote,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      label: Text("Note"),
                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtpaytype,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      label: Text("Paytype"),
                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtdate,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async => transactioncontroller
                            .current.value = (await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2012),
                          lastDate: DateTime(2122),
                        ))!,
                        icon: Icon(Icons.calendar_month),
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      label: Text("Date"),






                      fillColor: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txttime,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(
                                    hour: DateTime.now().hour,
                                    minute: DateTime.now().minute));
                          },
                          icon: Icon(Icons.access_time_rounded)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder(),
                      label: Text("Time"),
                      fillColor: Colors.black),
                ),
                Obx(() => Text("${transactioncontroller.current}")),
                SizedBox(
                  height: 120,
                ),
                Align(alignment: Alignment.bottomCenter, child: addButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Dbhelper dbhelper = Dbhelper();
                dbhelper.insertdata(
                    category: txtcate.text,
                    amount: txtamount.text,
                    status: '1',
                    notes: txtnote.text,
                    date: txtdate.text,
                    time: txttime.text,
                    paytype: txtpaytype.text);
                print(dbhelper.database);
                int i = 0;
                for (i = 0;
                    i < transactioncontroller.transectionlist.length;
                    i++) {
                  int status = int.parse(
                      transactioncontroller.transectionlist[i]['status']);
                  if (status == 1) {
                    int amount = int.parse(
                        transactioncontroller.transectionlist[i]['amount']);
                    transactioncontroller.total.value =
                        transactioncontroller.total.value + amount;
                    transactioncontroller.income.value =
                        transactioncontroller.income.value + amount;
                  }
                }
                print(
                    '${transactioncontroller.total.value}==============================');
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text('Income',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Dbhelper dbhelper = Dbhelper();
                dbhelper.insertdata(
                    category: txtcate.text,
                    amount: txtamount.text,
                    status: '0',
                    notes: txtnote.text,
                    date: txtdate.text,
                    time: txttime.text,
                    paytype: txtpaytype.text);
                print(dbhelper.database);
                int i = 0;
                for (i = 0;
                    i < transactioncontroller.transectionlist.length;
                    i++) {
                  int status = int.parse(
                      transactioncontroller.transectionlist[i]['status']);
                  if (status == 0) {
                    int amount = int.parse(
                        transactioncontroller.transectionlist[i]['amount']);
                    transactioncontroller.total.value =
                        transactioncontroller.total.value - amount;
                    transactioncontroller.expense.value =
                        transactioncontroller.expense.value + amount;
                  }
                }
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text('Expanse',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> categoryList = [
    CircleAvatar(child: Icon(Icons.add_call), radius: 30),
    CircleAvatar(child: Icon(Icons.add_call), radius: 30),
    CircleAvatar(child: Icon(Icons.add_call), radius: 30),
    CircleAvatar(child: Icon(Icons.add_call), radius: 30),
    CircleAvatar(child: Icon(Icons.add_call), radius: 30),
    CircleAvatar(child: Icon(Icons.add_call), radius: 30),
  ];
}

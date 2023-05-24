import 'package:get/get.dart';
import 'package:income_expense/utils/db_helper.dart';

class Transactioncontroller extends GetxController {
  RxString? dropDropDown;
  RxList<Map> transectionlist = <Map>[].obs;
  RxInt total = 0.obs;
  RxInt income = 0.obs;
  RxInt expense = 0.obs;

  Future<void> readtransection() async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.readdata();
  }

  Future<void> readIncomeExpense(int status) async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.incomeexpensefilter(s1: status);
  }

  Future<void> readCategory() async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.decendingfilter();
  }
  Future<void> readassending() async {
    Dbhelper dbhelper = Dbhelper();
    transectionlist.value = await dbhelper.assending();
  }
  Future<void> cashfilter(String payType)
  async {
    Dbhelper dbhelper=Dbhelper();
    transectionlist.value = await dbhelper.payTypeFilter(payType: payType);
    print(transectionlist);
  }
  RxList<Map> tincome=<Map>[].obs;
  RxList<Map> texpanse=<Map>[].obs;
  Future<void> totalincome()
  async {
    Dbhelper dbhelper=Dbhelper();
  tincome.value=await dbhelper.totalIncome();
  print(tincome);
  }
  Future<void> totalexpanse()
  async {
    Dbhelper dbhelper=Dbhelper();
    texpanse.value=await dbhelper.totalExpanse();
    print(texpanse);
  }

  void deletetransaction(int id) {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.deletedata(id: id);
    readtransection();
  }

  void updatetransaction(String category,
      String amount,
      int status,
      String notes,
      String date,
      String time,
      String paytype, int id) {
    Dbhelper dbhelper = Dbhelper();
    dbhelper.updatedata(category: category,
        amount: amount,
        status: status,
        notes: notes,
        date: date,
        time: time,
        paytype: paytype,
        id: id);
    readtransection();
  }
 Rx<DateTime> current = DateTime.now().obs;
  Rx<DateTime> date=DateTime.now().obs;
  Rx<DateTime> Date=DateTime.now().obs;

  RxList<String> category=<String>[
    "💲 Salary",
    "🍴 Food",
    "📱 Recharge",
    "⛽ Category",
    "🏠 Home Rent",
    "🎓 Education",
    "🍴 Glocery",
    "🛍️ Shopping",
    "🏥 Health Care",
    "✈ Travel",
  ].obs;
  var selectcategory="⛽ Category".obs;
  RxList<String> paytype=<String>[
    "💸 Cash",
    "📲 Online",
  ].obs;
  var selectpay="💸 Cash".obs;

}
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/employee_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/data_table_source.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<EmployeeData> myEmpData = [
    EmployeeData(name: "خالد", phone: 09876543, age: 28),
    EmployeeData(name: "الياس", phone: 6464646, age: 30),
    EmployeeData(name: "اسماعيل", phone: 987654556, age: 23),
    EmployeeData(name: "اوسان", phone: 46464664, age: 24),
    EmployeeData(name: "شفيع", phone: 5353535, age: 36),
    EmployeeData(name: "حسام", phone: 8888, age: 32),
    EmployeeData(name: "مروان", phone: 3333333, age: 33),
    EmployeeData(name: "خالد", phone: 09876543, age: 28),
    EmployeeData(name: "الياس", phone: 6464646, age: 30),
    EmployeeData(name: "اسماعيل", phone: 987654556, age: 23),
    EmployeeData(name: "اوسان", phone: 46464664, age: 24),
    EmployeeData(name: "شفيع", phone: 5353535, age: 36),
    EmployeeData(name: "حسام", phone: 8888, age: 32),
    EmployeeData(name: "مروان", phone: 3333333, age: 33),
    EmployeeData(name: "خالد", phone: 09876543, age: 28),
    EmployeeData(name: "الياس", phone: 6464646, age: 30),
    EmployeeData(name: "اسماعيل", phone: 987654556, age: 23),
    EmployeeData(name: "اوسان", phone: 46464664, age: 24),
    EmployeeData(name: "شفيع", phone: 5353535, age: 36),
    EmployeeData(name: "حسام", phone: 8888, age: 32),
    EmployeeData(name: "مروان", phone: 3333333, age: 33),
  ];

  List<EmployeeData>? filterData;
  bool sort = true;
  TextEditingController controller = TextEditingController();

  onsortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        filterData!.sort((a, b) => a.name!.compareTo(b.name!));
      } else {
        filterData!.sort((a, b) => b.name!.compareTo(a.name!));
      }
    }
  }

  @override
  void initState() {
    filterData = myEmpData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        // end: 30,
        bottom: 50,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: PaginatedDataTable2(
        autoRowsToHeight: true,
        headingRowColor: MaterialStatePropertyAll(MyColors.primaryColor),
        // sortColumnIndex: 0,
        // sortAscending: sort,
        showFirstLastButtons: true,
        headingRowDecoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10), topEnd: Radius.circular(10))),
        actions: [
          myButton(
            onPressed: () {},
            text: 'إضــافة مـوظــف جـديــد',
            textStyle: MyTextStyles.font14WhiteBold,
          ),
        ],
        header: myTextField(
          hintText: 'اكتــب هنــا للبحـــث',
          prefixIcon: Icons.search,
          controller: controller,
          keyboardType: TextInputType.text,
          onChanged: (value) {
            setState(() {
              myEmpData = filterData!
                  .where((element) => element.name!.contains(value))
                  .toList();
            });
          },
        ),
        source: RowSource(
          myData: myEmpData,
          count: myEmpData.length,
        ),
        rowsPerPage: 8,
        columnSpacing: 8,
        columns: [
          DataColumn(
            label: Text(
              "الاســــم",
              style: MyTextStyles.font16WhiteBold,
            ),
            // onSort: (columnIndex, ascending) {
            //   setState(() {
            //     sort = !sort;
            //   });
            //   onsortColum(columnIndex, ascending);
            // },
          ),
          DataColumn(
            label: Text(
              "رقم الجـــوال",
              style: MyTextStyles.font16WhiteBold,
            ),
          ),
          DataColumn(
            label: Text(
              "العمـــر",
              style: MyTextStyles.font16WhiteBold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        end: 30,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              myTextField(
                hintText: 'أدخــل اســم المـوظــف',
                keyboardType: TextInputType.text,
                fillColor: MyColors.primaryColor,
                onChanged: (value) {},
                prefixIcon: Icons.search_rounded,
                width: 400,
              ),
              SizedBox(
                width: 15,
              ),
              myButton(
                onPressed: () {},
                text: 'بحـــث',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 120,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),

          // Expanded(
          //   child: DataTable2(

          //     columnSpacing: 12,
          //     showHeadingCheckBox: true,
          //     showCheckboxColumn: true,

          //     headingRowColor: MaterialStatePropertyAll(MyColors.primaryColor),
          //     horizontalMargin: 12,
          //     border: TableBorder.all(
          //       borderRadius: BorderRadius.circular(20),
          //       color: MyColors.greyColor.withOpacity(0.3),
          //     ),
          //     // minWidth: MediaQuery.of(context).size.width,
          //     dataTextStyle: MyTextStyles.font14BlackMedium,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     headingRowDecoration: BoxDecoration(
          //       borderRadius: BorderRadiusDirectional.only(
          //         topStart: Radius.circular(10),
          //         topEnd: Radius.circular(10),
          //       ),
          //     ),
          //     headingTextStyle: MyTextStyles.font16WhiteBold,
          //     showBottomBorder: true,
          //     columns: [
          //       DataColumn2(
          //         label: Text(
          //           'الرقم',
          //           textAlign: TextAlign.center,
          //         ),
          //         size: ColumnSize.S,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'اسم الموظف',
          //           textAlign: TextAlign.center,
          //         ),
          //         fixedWidth: 250,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'تاريخ الميلاد',
          //           textAlign: TextAlign.center,
          //         ),
          //         size: ColumnSize.L,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'الجنس',
          //           textAlign: TextAlign.center,
          //         ),
          //         size: ColumnSize.S,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'رقم الجوال',
          //           textAlign: TextAlign.center,
          //         ),
          //         size: ColumnSize.L,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'العنوان',
          //           textAlign: TextAlign.center,
          //         ),
          //         fixedWidth: 250,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'اسم المستخدم',
          //           textAlign: TextAlign.center,
          //         ),
          //         size: ColumnSize.M,
          //       ),
          //       DataColumn2(
          //         label: Text(
          //           'الصلاحية',
          //           textAlign: TextAlign.center,
          //         ),
          //         size: ColumnSize.S,
          //       ),
          //     ],
          //     rows: List<DataRow>.generate(
          //       20,
          //       (index) => DataRow(
          //         cells: [
          //           DataCell(
          //             Text(
          //               '0001',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               'شفيع احمد سعيد قائد',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               '15-01-2002',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               'ذكر',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               '772957881',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               'تعز',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               'shafee',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //           DataCell(
          //             Text(
          //               'admin',
          //               textAlign: TextAlign.center,
          //             ),
          //             onDoubleTap: () {},
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myButton(
                onPressed: () {},
                text: 'إضـــافـــة',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 130,
              ),
              SizedBox(
                width: 15,
              ),
              myButton(
                onPressed: () {},
                text: 'حـــذف',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 130,
                backgroundColor: MyColors.redColor,
              ),
              SizedBox(
                width: 15,
              ),
              myButton(
                onPressed: () {},
                text: 'خـــروج',
                textStyle: MyTextStyles.font16WhiteBold,
                width: 130,
                backgroundColor: MyColors.greyColor,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

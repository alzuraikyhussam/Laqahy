import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/users_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/user_data_table.dart';
import 'package:laqahy/view/widgets/successfully_add_state.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    UsersController uc = Get.put(UsersController());

    return Container(
      padding: const EdgeInsetsDirectional.only(
        bottom: 50,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx(
        () {
          return PaginatedDataTable2(
            autoRowsToHeight: true,
            empty: Center(
              child: Container(
                alignment: AlignmentDirectional.center,
                child: SvgPicture.asset('assets/images/No data.svg'),
              ),
            ),
            horizontalMargin: 15,
            headingRowColor: MaterialStatePropertyAll(MyColors.primaryColor),
            sortColumnIndex: 1,
            sortAscending: uc.sort.value,
            showFirstLastButtons: true,
            columnSpacing: 5,
            // rowsPerPage: 8,
            headingRowDecoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            header: Container(
              width: double.infinity,
              // padding: EdgeInsetsDirectional.all(5),
              child: myTextField(
                onTap: () {},
                hintText: 'اكتــب هنــا للبحـــث',
                prefixIcon: Icons.search,
                controller: uc.userSearchController,
                keyboardType: TextInputType.text,
                onChanged: uc.filterUserData,
              ),
            ),
            columns: [
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "م",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 40,
                // numeric: true,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "اسـم المـوظـف",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                onSort: (columnIndex, ascending) {
                  uc.sort.value = ascending;
                  uc.onSortColum(columnIndex, ascending);
                },
                fixedWidth: 220,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "الجنـس",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 50,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "تاريـخ الميـلاد",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 120,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "الصـلاحيـة",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 60,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "رقـم الجـوال",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 100,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "اسـم المستخـدم",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 130,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "كلمـة المـرور",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 130,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "العنـوان",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                // fixedWidth: 180,
              ),
              DataColumn2(
                label: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "العمليـات",
                    style: MyTextStyles.font14WhiteBold,
                  ),
                ),
                fixedWidth: 100,
              ),
            ],
            source: UserRowSource(
              myData: uc.myUserFilteredData,
              count: uc.myUserFilteredData.length,
            ),
            actions: [
              myButton(
                onPressed: () {
                  myShowDialog(
                      context: context, widgetName: SuccessfullyAddState());
                },
                text: 'إضــافة مـوظــف جـديــد',
                textStyle: MyTextStyles.font16WhiteBold,
              ),
            ],
          );
        },
      ),
    );
  }
}

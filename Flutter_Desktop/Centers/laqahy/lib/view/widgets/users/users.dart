import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/users/user_data_table_source.dart';

import 'add_user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserController uc = Get.put(UserController());
  StaticDataController sdc = Get.put(StaticDataController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return uc.isLoading.value
            ? Center(
                child: myLoadingIndicator(),
              )
            : Container(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 50,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: PaginatedDataTable2(
                  autoRowsToHeight: true,
                  empty: ApiExceptionWidgets().myDataNotFound(
                    onPressedRefresh: () {
                      uc.fetchUsers(uc.centerId);
                    },
                  ),
                  horizontalMargin: 15,
                  headingRowColor:
                      MaterialStatePropertyAll(MyColors.primaryColor),
                  // sortColumnIndex: 1,
                  // sortAscending: uc.sort.value,
                  showFirstLastButtons: true,
                  columnSpacing: 5,
                  // rowsPerPage: 5,
                  controller: uc.tableController,
                  headingRowDecoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                    ),
                  ),
                  header: Container(
                    width: double.infinity,
                    // padding: EdgeInsetsD)irectional.all(5),
                    child: myTextField(
                      onTap: () {
                        uc.tableController.goToFirstPage();
                        print(uc.tableController.currentRowIndex);
                      },
                      hintText: 'اكتــب هنــا للبحـــث',
                      prefixIcon: Icons.search,
                      controller: uc.userSearchController,
                      keyboardType: TextInputType.text,
                      onChanged: uc.filterUsers,
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
                      // onSort: (columnIndex, ascending) {
                      //   uc.sort.value = ascending;
                      //   uc.onSortColum(columnIndex, ascending);
                      // },
                      fixedWidth: 150,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "الجنـس",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 50,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "تاريـخ الميـلاد",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 120,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "الصـلاحيـة",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 60,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "رقـم الجـوال",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 100,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "اسـم المستخـدم",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 130,
                    ),
                    DataColumn2(
                      label: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "كلمـة المـرور",
                          style: MyTextStyles.font14WhiteBold,
                        ),
                      ),
                      // fixedWidth: 130,
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
                      // fixedWidth: 100,
                    ),
                  ],
                  source: UserRowSource(
                    myData: uc.filteredUsers,
                    count: uc.filteredUsers.length,
                  ),
                  actions: [
                    myButton(
                      onPressed: () {
                        sdc.selectedGenderId.value = null;
                        sdc.selectedPermissionId.value = null;
                        uc.clearTextFields();
                        myShowDialog(context: context, widgetName: const AddUser());
                      },
                      text: 'إضــافة مستخـدم جـديــد',
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                  ],
                ),
              );
      },
    );
  
  }
}

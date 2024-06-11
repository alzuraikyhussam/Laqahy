import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/controllers/user_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/models/model.dart';
import 'package:laqahy/services/api/api_exception.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/users/user_data_table_source.dart';
import 'package:laqahy/view/widgets/users/edit_user.dart';
import 'package:lottie/lottie.dart';

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
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: PaginatedDataTable2(
                  autoRowsToHeight: true,
                  empty: ApiException().myDataNotFound(
                    onPressedRefresh: uc.fetchUsers,
                  ),
                  horizontalMargin: 15,
                  headingRowColor:
                      MaterialStatePropertyAll(MyColors.primaryColor),
                  // sortColumnIndex: 1,
                  // sortAscending: uc.sort.value,
                  showFirstLastButtons: true,
                  columnSpacing: 5,
                  // rowsPerPage: 8,
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
                      onTap: () {},
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
                        myShowDialog(context: context, widgetName: AddUser());
                      },
                      text: 'إضــافة مستخــدم جـديــد',
                      textStyle: MyTextStyles.font16WhiteBold,
                    ),
                  ],
                ),
              );
      },
    );
  }

  // List<UserData> myEmpData = [
  //   UserData(name: "خالد", phone: 09876543, age: 28),
  //   UserData(name: "الياس", phone: 6464646, age: 30),
  //   UserData(name: "اسماعيل", phone: 987654556, age: 23),
  //   UserData(name: "اوسان", phone: 46464664, age: 24),
  //   UserData(name: "شفيع", phone: 5353535, age: 36),
  //   UserData(name: "حسام", phone: 8888, age: 32),
  //   UserData(name: "مروان", phone: 3333333, age: 33),
  //   UserData(name: "خالد", phone: 09876543, age: 28),
  //   UserData(name: "الياس", phone: 6464646, age: 30),
  //   UserData(name: "اسماعيل", phone: 987654556, age: 23),
  //   UserData(name: "اوسان", phone: 46464664, age: 24),
  //   UserData(name: "شفيع", phone: 5353535, age: 36),
  //   UserData(name: "حسام", phone: 8888, age: 32),
  //   UserData(name: "مروان", phone: 3333333, age: 33),
  //   UserData(name: "خالد", phone: 09876543, age: 28),
  //   UserData(name: "الياس", phone: 6464646, age: 30),
  //   UserData(name: "اسماعيل", phone: 987654556, age: 23),
  //   UserData(name: "اوسان", phone: 46464664, age: 24),
  //   UserData(name: "شفيع", phone: 5353535, age: 36),
  //   UserData(name: "حسام", phone: 8888, age: 32),
  //   UserData(name: "مروان", phone: 3333333, age: 33),
  // ];

  // List<UserData>? filterData;
  // bool sort = true;
  // TextEditingController controller = TextEditingController();

  // onsortColum(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     if (ascending) {
  //       filterData!.sort((a, b) => a.name!.compareTo(b.name!));
  //     } else {
  //       filterData!.sort((a, b) => b.name!.compareTo(a.name!));
  //     }
  //   }
  // }

  // @override
  // void initState() {
  //   filterData = myEmpData;
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsetsDirectional.only(
  //       // end: 30,
  //       bottom: 50,
  //     ),
  //     width: double.infinity,
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //     ),
  //     child: PaginatedDataTable2(
  //       autoRowsToHeight: true,
  //       headingRowColor: MaterialStatePropertyAll(MyColors.primaryColor),
  //       // sortColumnIndex: 0,
  //       // sortAscending: sort,
  //       showFirstLastButtons: true,
  //       headingRowDecoration: const BoxDecoration(
  //           borderRadius: BorderRadiusDirectional.only(
  //               topStart: Radius.circular(10), topEnd: Radius.circular(10))),
  //       actions: [
  //         myButton(
  //           onPressed: () {
  //             myShowDialog(context: context, widgetName: const AddUser());
  //           },
  //           text: 'إضـافة مستخــدم جـديـد',
  //           textStyle: MyTextStyles.font16WhiteBold,
  //         ),
  //       ],
  //       header: myTextField(
  //         hintText: 'اكتــب هنــا للبحـــث',
  //         prefixIcon: Icons.search,
  //         controller: controller,
  //         keyboardType: TextInputType.text,
  //         onChanged: (value) {
  //           setState(() {
  //             myEmpData = filterData!
  //                 .where((element) => element.name!.contains(value))
  //                 .toList();
  //           });
  //         },
  //       ),
  //       source: RowSource(
  //         myData: myEmpData,
  //         count: myEmpData.length,
  //       ),
  //       rowsPerPage: 8,
  //       columnSpacing: 8,
  //       columns: [
  //         DataColumn(
  //           label: Text(
  //             "الاســــم",
  //             style: MyTextStyles.font16WhiteBold,
  //           ),
  //           // onSort: (columnIndex, ascending) {
  //           //   setState(() {
  //           //     sort = !sort;
  //           //   });
  //           //   onsortColum(columnIndex, ascending);
  //           // },
  //         ),
  //         DataColumn(
  //           label: Text(
  //             "رقم الجـــوال",
  //             style: MyTextStyles.font16WhiteBold,
  //           ),
  //         ),
  //         DataColumn(
  //           label: Text(
  //             "العمـــر",
  //             style: MyTextStyles.font16WhiteBold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:laqahy/controllers/mother_visit_controller.dart';
// import 'package:laqahy/controllers/static_data_controller.dart';
// import 'package:laqahy/controllers/user_controller.dart';
// import 'package:laqahy/core/constants/constants.dart';
// import 'package:laqahy/core/shared/styles/color.dart';
// import 'package:laqahy/core/shared/styles/style.dart';
// import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// // ignore: must_be_immutable
// class EditMotherStatement extends StatefulWidget {
//   EditMotherStatement({super.key, required this.data, required this.adminId});

//   dynamic data;
//   int? adminId;

//   @override
//   State<EditMotherStatement> createState() => _EditMotherStatementState();
// }

// class _EditMotherStatementState extends State<EditMotherStatement> {
//   late TextEditingController motherNameController;
//   late TextEditingController healthyCenterController;
//   late TextEditingController userNameController;
//   TextEditingController dosageTakingDateController = TextEditingController();
//   TextEditingController returnDateController = TextEditingController();
//   late TextEditingController phoneController;


//   @override
//   void initState() {
//     super.initState();
//     sdc.selectedMothersId.value = widget.data.mother_data_id;
//     sdc.selectedDosageLevelId.value = widget.data.dosage_level_id;
//     sdc.selectedDosageTypeId.value = widget.data.dosage_type_id;
//     userNameController = TextEditingController(text: widget.data.userName);
//     // passwordController = TextEditingController(text: widget.data.password);
//     dosageTakingDateController.text =
//         DateFormat('MMM d, yyyy').format(widget.data.date_taking_dose);
//     returnDateController.text =
//         DateFormat('MMM d, yyyy').format(widget.data.return_date);
//     ;
//   }

//   MotherVisitController mvc = Get.put(MotherVisitController());
//   StaticDataController sdc = Get.put(StaticDataController());

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       alignment: AlignmentDirectional.center,
//       contentPadding: const EdgeInsets.all(20),
//       actionsAlignment: MainAxisAlignment.center,
//       content: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 3,
//             color: MyColors.primaryColor,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         height: 520,
//         child: Form(
//           key: mvc.editMotherStatementDataFormKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'تــعديـــل بــيــان الأم',
//                 textAlign: TextAlign.center,
//                 style: MyTextStyles.font18PrimaryBold,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'الاسم الرباعي',
//                         style: MyTextStyles.font14BlackBold,
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 3),
//                         width: 300,
//                         child: myTextField(
//                             controller: motherNameController,
//                             validator: mvc.nameValidator,
//                             prefixIcon: Icons.person_outline_sharp,
//                             hintText: 'الاسم الرباعي',
//                             keyboardType: TextInputType.text,
//                             onChanged: (value) {}),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'رقم الجوال',
//                         style: MyTextStyles.font14BlackBold,
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(top: 3),
//                         child: myTextField(
//                           width: 200,
//                           controller: phoneController,
//                           validator: uc.phoneNumberValidator,
//                           prefixIcon: Icons.phone_outlined,
//                           hintText: 'رقم الجوال',
//                           keyboardType: TextInputType.text,
//                           onChanged: (value) {},
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'الجنس ',
//                         style: MyTextStyles.font14BlackBold,
//                       ),
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       Constants().gendersDropdownMenu(),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 // width: 500,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'اسم المستخدم ',
//                           style: MyTextStyles.font14BlackBold,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 3),
//                           child: myTextField(
//                               controller: userNameController,
//                               validator: uc.userNameValidator,
//                               width: 230,
//                               prefixIcon: Icons.person_pin_outlined,
//                               hintText: 'اسم المستخدم',
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) {}),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'كلمة المرور ',
//                           style: MyTextStyles.font14BlackBold,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 3),
//                           child: myTextField(
//                               controller: passwordController,
//                               validator: uc.passwordValidator,
//                               width: 230,
//                               prefixIcon: Icons.password_outlined,
//                               hintText: 'كلمة المرور',
//                               keyboardType: TextInputType.visiblePassword,
//                               onChanged: (value) {}),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       width: widget.data.id == widget.adminId ? 0 : 20,
//                     ),
//                     widget.data.id != widget.adminId
//                         ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'تحديد الصلاحية',
//                                 style: MyTextStyles.font14BlackBold,
//                               ),
//                               const SizedBox(
//                                 height: 3,
//                               ),
//                               Constants().permissionsDropdownMenu(),
//                             ],
//                           )
//                         : const SizedBox()
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 // width: 500,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'تاريخ الميلاد',
//                           style: MyTextStyles.font14BlackBold,
//                         ),
//                         const SizedBox(
//                           height: 3,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 3),
//                           child: myTextField(
//                             validator: uc.birthDateValidator,
//                             controller: birthDateController,
//                             hintText: 'تاريــخ الميـلاد',
//                             prefixIcon: Icons.date_range_outlined,
//                             keyboardType: TextInputType.text,
//                             readOnly: true,
//                             width: 250,
//                             onTap: () {
//                               showDatePicker(
//                                       context: context,
//                                       firstDate: DateTime(1950),
//                                       lastDate: DateTime.now())
//                                   .then(
//                                 (value) {
//                                   if (value == null) {
//                                     return;
//                                   } else {
//                                     birthDateController.text =
//                                         DateFormat.yMMMd().format(value);
//                                   }
//                                 },
//                               );
//                             },
//                             onChanged: (value) {},
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'العنوان',
//                           style: MyTextStyles.font14BlackBold,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 3),
//                           child: myTextField(
//                               controller: addressController,
//                               validator: uc.addressValidator,
//                               width: 300,
//                               prefixIcon: Icons.location_on_outlined,
//                               hintText: 'العنوان',
//                               keyboardType: TextInputType.text,
//                               onChanged: (value) {}),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Obx(() {
//                     return uc.isUpdateLoading.value
//                         ? myLoadingIndicator()
//                         : myButton(
//                             width: 150,
//                             onPressed: uc.isUpdateLoading.value
//                                 ? null
//                                 : () {
//                                     if (uc.editUserAccountFormKey.currentState!
//                                         .validate()) {
//                                       uc.updateUser(
//                                         widget.data.id,
//                                         nameController.text,
//                                         addressController.text,
//                                         userNameController.text,
//                                         passwordController.text,
//                                         sdc.selectedPermissionId.value,
//                                         phoneController.text,
//                                         sdc.selectedGenderId.value,
//                                         birthDateController.text,
//                                       );
//                                     }
//                                   },
//                             text: 'تعـــديل',
//                             textStyle: MyTextStyles.font16WhiteBold);
//                   }),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   myButton(
//                       width: 150,
//                       backgroundColor: MyColors.greyColor,
//                       onPressed: () {
//                         Get.back();
//                       },
//                       text: 'الغـــاء اللأمــر',
//                       textStyle: MyTextStyles.font16WhiteBold),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

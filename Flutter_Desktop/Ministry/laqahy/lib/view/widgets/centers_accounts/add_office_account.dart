import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/centers_accounts_controller.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/vaccines/add_donor.dart';

class AddOfficeAccount extends StatefulWidget {
  AddOfficeAccount({
    super.key,
  });

  @override
  State<AddOfficeAccount> createState() => _AddOfficeAccountState();
}

class _AddOfficeAccountState extends State<AddOfficeAccount> {
  CentersAccountsController cac = Get.put(CentersAccountsController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cac.addOfficeAccountFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 280,
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myAppBarLogo(
                        width: 250,
                      ),
                    ],
                  ),
                ),
                Text(
                  'إضــافة مكــتب جـديــد',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: cac.unregisteredOfficesDropdownMenu(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    myTextField(
                      controller: cac.phoneNumberController,
                      validator: cac.phoneNumberValidator,
                      width: 220,
                      prefixIcon: Icons.phone_outlined,
                      hintText: 'رقم الهاتف',
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  hintText: 'العنـــوان',
                  controller: cac.addressController,
                  validator: cac.addressValidator,
                  prefixIcon: Icons.location_on_outlined,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return cac.isUpdateLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: cac.isUpdateLoading.value
                        ? null
                        : () {
                            if (cac.addOfficeAccountFormKey.currentState!
                                .validate()) {
                              cac.updateOfficeAccount(
                                officeId:
                                    cac.selectedUnRegisteredOfficeId.value,
                                phone: cac.phoneNumberController.text,
                                address: cac.addressController.text,
                              );
                            }
                          },
                    width: 150,
                    text: 'إضـــافة',
                    textStyle: MyTextStyles.font16WhiteBold,
                  );
          }),
          myButton(
            width: 150,
            onPressed: () {
              Get.back();
            },
            text: 'إلـغــاء الأمـــر',
            textStyle: MyTextStyles.font16WhiteBold,
            backgroundColor: MyColors.greyColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/centers_accounts_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class EditOfficeAccount extends StatefulWidget {
  EditOfficeAccount({super.key, required this.data});

  var data;

  @override
  State<EditOfficeAccount> createState() => _EditOfficeAccountState();
}

class _EditOfficeAccountState extends State<EditOfficeAccount> {
  CentersAccountsController cac = Get.put(CentersAccountsController());

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController officeNameController = TextEditingController();

  @override
  void initState() {
    officeNameController.text = widget.data.name;
    addressController.text = widget.data.address;
    phoneNumberController.text = widget.data.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cac.editOfficeAccountFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 280,
          width: 500,
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
                  'تعـــديل بيـــانات المـــكتب',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: myTextField(
                        controller: officeNameController,
                        hintText: 'اسم المكتب',
                        prefixIcon: Icons.house_outlined,
                        readOnly: true,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    myTextField(
                      controller: phoneNumberController,
                      validator: cac.phoneNumberValidator,
                      width: 200,
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
                  controller: addressController,
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
                            if (cac.editOfficeAccountFormKey.currentState!
                                .validate()) {
                              cac.updateOfficeAccount(
                                officeId: widget.data.id,
                                phone: phoneNumberController.text,
                                address: addressController.text,
                                alertType: 'edit',
                              );
                            }
                          },
                    width: 150,
                    text: 'تعـــديل',
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

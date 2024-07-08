import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/accounts_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

// ignore: must_be_immutable
class EditCenterAccount extends StatefulWidget {
  EditCenterAccount({super.key, required this.data});

  var data;

  @override
  State<EditCenterAccount> createState() => _EditCenterAccountState();
}

class _EditCenterAccountState extends State<EditCenterAccount> {
  AccountsController cac = Get.put(AccountsController());
  StaticDataController sdc = Get.find<StaticDataController>();

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController centerNameController = TextEditingController();

  @override
  void initState() {
    centerNameController.text = widget.data.name;
    addressController.text = widget.data.address;
    phoneNumberController.text = widget.data.phone;
    sdc.selectedDirectorateId.value = widget.data.directorateId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cac.editCenterAccountFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
          height: 290,
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
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
                  'تعـــديل بيـــانات المـــركز',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    myTextField(
                      validator: cac.centerNameValidator,
                      hintText: 'اسـم المـركز',
                      controller: centerNameController,
                      width: 280,
                      prefixIcon: Icons.house_outlined,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: myTextField(
                        controller: phoneNumberController,
                        validator: cac.phoneNumberValidator,
                        hintText: 'رقم الهاتف',
                        prefixIcon: Icons.call_outlined,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    cac.directoratesDropdownMenu(),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: myTextField(
                        hintText: 'العنوان',
                        controller: addressController,
                        validator: cac.addressValidator,
                        prefixIcon: Icons.location_on_outlined,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return cac.isUpdateLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: cac.isUpdateLoading.value
                        ? null
                        : () {
                            if (cac.editCenterAccountFormKey.currentState!
                                .validate()) {
                              cac.updateCenterAccount(
                                id: widget.data.id,
                                centerName: centerNameController.text,
                                phone: phoneNumberController.text,
                                address: addressController.text,
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

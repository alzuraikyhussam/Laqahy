import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/accounts_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddCenterAccount extends StatefulWidget {
  const AddCenterAccount({
    super.key,
  });

  @override
  State<AddCenterAccount> createState() => _AddCenterAccountState();
}

class _AddCenterAccountState extends State<AddCenterAccount> {
  AccountsController cac = Get.put(AccountsController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cac.addCenterAccountFormKey,
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
                  'إضــافة مــركز جـديــد',
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
                      controller: cac.centerNameController,
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
                        controller: cac.phoneNumberController,
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
                        controller: cac.addressController,
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
            return cac.isAddLoading.value
                ? myLoadingIndicator(width: 150)
                : myButton(
                    onPressed: cac.isAddLoading.value
                        ? null
                        : () {
                            if (cac.addCenterAccountFormKey.currentState!
                                .validate()) {
                              cac.addCenterAccount();
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

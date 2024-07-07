import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddDonor extends StatefulWidget {
  const AddDonor({
    super.key,
  });

  @override
  State<AddDonor> createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  VaccineController vc = Get.put(VaccineController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: vc.addDonorFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 220,
          width: 350,
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
                  'إضــافة جهـة مانحـة جـديـدة',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 20,
                ),
                myTextField(
                  autofocus: true,
                  width: 320,
                  controller: vc.donorController,
                  validator: vc.addDonorValidator,
                  prefixIcon: Icons.source_outlined,
                  hintText: 'اسـم الجهـة المانحة',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return vc.isAddDonorLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: vc.isAddDonorLoading.value
                        ? null
                        : () {
                            if (vc.addDonorFormKey.currentState!.validate()) {
                              vc.addDonor();
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddVaccineQuantity extends StatefulWidget {
  AddVaccineQuantity({super.key, required this.id});

  int id;

  @override
  State<AddVaccineQuantity> createState() => _AddVaccineQuantityState();
}

class _AddVaccineQuantityState extends State<AddVaccineQuantity> {
  VaccineController vc = Get.put(VaccineController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: vc.addQtyVaccineFormKey,
      child: AlertDialog(
        alignment: AlignmentDirectional.center,
        actionsAlignment: MainAxisAlignment.center,
        content: Container(
          height: 280,
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
                  'إضــافة كمــية جـديــدة',
                  style: MyTextStyles.font18PrimaryBold,
                ),
                SizedBox(
                  height: 20,
                ),
                myTextField(
                  width: 300,
                  controller: vc.sourceController,
                  validator: vc.sourceValidator,
                  prefixIcon: Icons.source_outlined,
                  hintText: 'الجهة المانحة',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  controller: vc.qtyController,
                  validator: vc.qtyValidator,
                  width: 300,
                  prefixIcon: Icons.numbers,
                  hintText: 'الكميـة',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            return vc.isAddLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: vc.isAddLoading.value
                        ? null
                        : () {
                            if (vc.addQtyVaccineFormKey.currentState!
                                .validate()) {
                              vc.addVaccineQty(widget.id);
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/add_qty_vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddVaccineQuantity extends StatefulWidget {
  const AddVaccineQuantity({super.key});

  @override
  State<AddVaccineQuantity> createState() => _AddVaccineQuantityState();
}

class _AddVaccineQuantityState extends State<AddVaccineQuantity> {
  AddQtyVaccineController aqvc = Get.put(AddQtyVaccineController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: aqvc.addQtyVaccineFormKey,
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
                  controller: aqvc.sourceController,
                  validator: aqvc.sourceValidator,
                  prefixIcon: Icons.source_outlined,
                  hintText: 'الجهة المانحة',
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  controller: aqvc.qtyController,
                  validator: aqvc.qtyValidator,
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
          myButton(
            onPressed: () {
              if (aqvc.addQtyVaccineFormKey.currentState!.validate()) {
                Get.back();
              }
            },
            width: 150,
            text: 'مـوافــق',
            textStyle: MyTextStyles.font16WhiteBold,
          ),
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

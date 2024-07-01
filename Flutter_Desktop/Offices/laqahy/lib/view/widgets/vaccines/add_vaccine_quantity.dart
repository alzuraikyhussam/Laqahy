import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/vaccines/add_donor.dart';

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: vc.donorsDropdownMenu(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        myShowDialog(context: context, widgetName: AddDonor());
                        vc.donorController.clear();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.primaryColor,
                              MyColors.secondaryColor,
                            ],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.greyColor.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadiusDirectional.circular(100),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // myTextField(
                //   width: 300,
                //   controller: vc.donorController,
                //   validator: vc.donorValidator,
                //   prefixIcon: Icons.source_outlined,
                //   hintText: 'الجهة المانحة',
                //   keyboardType: TextInputType.text,
                //   onChanged: (value) {},
                // ),
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  controller: vc.qtyController,
                  validator: vc.qtyValidator,
                  // width: 300,
                  prefixIcon: Icons.numbers,
                  hintText: 'الكميـة',
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
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

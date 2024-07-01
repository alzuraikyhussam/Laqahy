import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/vaccine_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:laqahy/view/widgets/vaccines/add_donor.dart';

class EditVaccineQuantity extends StatefulWidget {
  EditVaccineQuantity({super.key, required this.data});

  var data;

  @override
  State<EditVaccineQuantity> createState() => _EditVaccineQuantityState();
}

class _EditVaccineQuantityState extends State<EditVaccineQuantity> {
  VaccineController vc = Get.put(VaccineController());

  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    vc.selectedDonorId.value = null;
    vc.selectedDonorId.value = widget.data.donorId;
    quantityController.text = widget.data.quantity.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: vc.editVaccineQtyFormKey,
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
                  'تعـــديل البيـــان',
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
                SizedBox(
                  height: 10,
                ),
                myTextField(
                  controller: quantityController,
                  validator: vc.qtyValidator,
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
            return vc.isUpdateLoading.value
                ? myLoadingIndicator()
                : myButton(
                    onPressed: vc.isUpdateLoading.value
                        ? null
                        : () {
                            if (vc.editVaccineQtyFormKey.currentState!
                                .validate()) {
                              vc.updateVaccineStatement(
                                widget.data.id,
                                quantityController.text,
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

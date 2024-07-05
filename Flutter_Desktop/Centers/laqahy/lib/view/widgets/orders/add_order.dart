import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/constants/constants.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class AddOrder extends StatefulWidget {
  const AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        padding: const EdgeInsetsDirectional.only(start: 5),
        child: Column(
          children: [
            Form(
              key: oc.addOrderFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'إرسـال طلب جـديد',
                    style: MyTextStyles.font18PrimaryBold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: Text(
                      'من هنا يمكنكم إرسال طلب الى مكتب الصحة والسكان في المحافظة لإمدادكم بكمية من اللقاح المطلوب.',
                      style: MyTextStyles.font16GreyBold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'اســم اللقــاح',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Constants().vaccinesDropdownMenu(),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الكميـة المطلـوبـة',
                            style: MyTextStyles.font16BlackBold,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          myTextField(
                            controller: oc.quantityController,
                            validator: oc.qtyValidator,
                            width: 200,
                            prefixIcon: Icons.numbers,
                            hintText: 'حدد الكمية',
                            keyboardType: TextInputType.number,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مـلاحظــات',
                        style: MyTextStyles.font16BlackBold,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      myTextField(
                        controller: oc.notesController,
                        validator: oc.notesValidator,
                        width: 515,
                        maxLines: 3,
                        maxLength: 150,
                        prefixIcon: Icons.message_outlined,
                        hintText: 'اكتب ملاحظتك هنا',
                        keyboardType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    return oc.isAddLoading.value
                        ? myLoadingIndicator()
                        : myButton(
                            onPressed: () {
                              if (oc.addOrderFormKey.currentState!.validate()) {
                                oc.addOrder();
                              }
                            },
                            text: 'إرســــال الطلـــب',
                            textStyle: MyTextStyles.font16WhiteBold,
                          );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

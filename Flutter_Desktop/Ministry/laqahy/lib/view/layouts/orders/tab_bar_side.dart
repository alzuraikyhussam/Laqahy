import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/core/shared/styles/style.dart';

class OrderTabBarSide extends StatefulWidget {
  const OrderTabBarSide({super.key});

  @override
  State<OrderTabBarSide> createState() => _OrderTabBarSideState();
}

class _OrderTabBarSideState extends State<OrderTabBarSide> {
  OrdersController oc = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColors.greyColor.withOpacity(0.1)),
      ),
      width: double.infinity,
      height: 60,
      padding: const EdgeInsetsDirectional.all(3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() {
            return Expanded(
              child: InkWell(
                onTap: () {
                  oc.onChangeOrder('incoming');
                  oc.fetchIncomingOrders();
                },
                child: Container(
                  decoration: oc.orderTapChange.value == 'incoming'
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.greyColor.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        )
                      : null,
                  child: Center(
                    child: Text(
                      'الــــواردة',
                      style: oc.orderTapChange.value == 'incoming'
                          ? MyTextStyles.font16WhiteBold
                          : MyTextStyles.font16SecondaryBold,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(
            width: 10,
          ),
          Obx(() {
            return Expanded(
              child: InkWell(
                onTap: () {
                  oc.onChangeOrder('in_delivery');
                  oc.fetchInDeliveryOrders();
                },
                child: Container(
                  decoration: oc.orderTapChange.value == 'in_delivery'
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.greyColor.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        )
                      : null,
                  child: Center(
                    child: Text(
                      'قيـــد التــسليـــم',
                      style: oc.orderTapChange.value == 'in_delivery'
                          ? MyTextStyles.font16WhiteBold
                          : MyTextStyles.font16SecondaryBold,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(
            width: 10,
          ),
          Obx(() {
            return Expanded(
              child: InkWell(
                onTap: () {
                  oc.onChangeOrder('delivered');
                  oc.fetchDeliveredOrders();
                },
                child: Container(
                  decoration: oc.orderTapChange.value == 'delivered'
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.greyColor.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        )
                      : null,
                  child: Center(
                    child: Text(
                      'تـــم التــسليـــم',
                      style: oc.orderTapChange.value == 'delivered'
                          ? MyTextStyles.font16WhiteBold
                          : MyTextStyles.font16SecondaryBold,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(
            width: 10,
          ),
          Obx(() {
            return Expanded(
              child: InkWell(
                onTap: () {
                  oc.onChangeOrder('rejected');
                  oc.fetchRejectedOrders();
                },
                child: Container(
                  decoration: oc.orderTapChange.value == 'rejected'
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.greyColor.withOpacity(0.3),
                              blurRadius: 10,
                            ),
                          ],
                        )
                      : null,
                  child: Center(
                    child: Text(
                      'المــرفوضـــة',
                      style: oc.orderTapChange.value == 'rejected'
                          ? MyTextStyles.font16WhiteBold
                          : MyTextStyles.font16SecondaryBold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

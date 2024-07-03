import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/orders_controller.dart';
import 'package:laqahy/view/widgets/orders/cancelled_order.dart';
import 'package:laqahy/view/widgets/orders/delivered_order.dart';
import 'package:laqahy/view/widgets/orders/in_delivery_order.dart';
import 'package:laqahy/view/widgets/orders/incoming_order.dart';

class OrderBodySide extends StatefulWidget {
  const OrderBodySide({super.key});

  @override
  State<OrderBodySide> createState() => _OrderBodySideState();
}

class _OrderBodySideState extends State<OrderBodySide> {
  OrdersController oc = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: oc.orderTapChange.value == 'incoming'
            ? const IncomingOrder()
            : oc.orderTapChange.value == 'in_delivery'
                ? const InDeliveryOrder()
                : oc.orderTapChange.value == 'delivered'
                    ? const DeliveredOrder()
                    : oc.orderTapChange.value == 'cancelled'
                        ? const CancelledOrder()
                        : const SizedBox(),
      );
    });
  }
}

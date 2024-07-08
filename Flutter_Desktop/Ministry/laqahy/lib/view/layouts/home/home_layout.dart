import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laqahy/controllers/home_layout_controller.dart';
import 'package:laqahy/controllers/static_data_controller.dart';
import 'package:laqahy/view/layouts/home/body_side.dart';
import 'package:laqahy/view/layouts/home/menu_side.dart';
import 'package:laqahy/view/layouts/home/top_bar_side.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with WindowListener {
  HomeLayoutController hlc = Get.put(HomeLayoutController());
  StaticDataController controller = Get.find<StaticDataController>();

  @override
  void initState() {
    WindowOptions homeWindowOptions = const WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(homeWindowOptions, () async {
      await windowManager.setFullScreen(true);
      await windowManager.setResizable(false);
      await windowManager.setTitle('Laqahy | لقـاحي');
      await windowManager.show();
      await windowManager.focus();
    });
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      return await hlc.onTapExitButton(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Obx(() {
            return hlc.choose.value == 'الرئيسية'
                ? Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/home-layout-bg.png',
                    ),
                  )
                : const SizedBox();
          }),
          myCopyRightText(),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeMenuSide(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeTopBarSide(),
                    HomeBodySide(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

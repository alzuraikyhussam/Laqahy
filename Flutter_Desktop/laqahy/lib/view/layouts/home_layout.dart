
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';
import 'package:window_manager/window_manager.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WindowOptions homeWindowOptions = const WindowOptions(
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(homeWindowOptions, () async {
      await windowManager.setResizable(false);
      await windowManager.setFullScreen(true);
      await windowManager.setTitle('Laqahy | لقـاحي');
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          myBackgroundWindows(),
          Positioned(
            left: 20,
            bottom: 0,
            top: 0,
            child: SvgPicture.asset(
              'assets/images/image_create_account.svg',
              width: 300,
            ),
          ),
          myCopyRightText(),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [],
                  ),
                ),
                Container(
                  child: Column(
                    children: [],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

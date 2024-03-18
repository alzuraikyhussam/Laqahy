import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/desktop_screens_background.svg'),
            alignment: AlignmentDirectional.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                myButton(
                  onPressed: () {},
                  text: 'مرحبا بكم',
                  textStyle: MyTextStyles.font18BlackBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextField(
                  hintText: 'رقم الهـــاتف',
                  keyboardType: TextInputType.text,
                  onChanged: (String) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                myTextButton(
                  text: 'نسيت كلمة المرور!',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                myCircleAvatar(icon: Icons.person),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

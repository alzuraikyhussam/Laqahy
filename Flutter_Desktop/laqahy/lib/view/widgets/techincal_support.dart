import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqahy/core/shared/styles/style.dart';

import '../../core/shared/styles/color.dart';
import 'basic_widgets/basic_widgets.dart';

class TechnicalSupport extends StatelessWidget {
  const TechnicalSupport({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: -180,
          top: 0,
          child: SvgPicture.asset(
            'assets/images/support.svg',
            width: 600,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تواصــــل معــــــنا',
                      style: MyTextStyles.font18PrimaryBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' هل لديك سؤال؟',
                      style: MyTextStyles.font14GreyBold,
                    ),
                    Text(
                      ' نحن سعداء بتواصلك معنا.',
                      style: MyTextStyles.font14GreyBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  الأســـم الكامـــل   ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 350,
                          child: myTextField(
                            color: MyColors.whiteColor,
                            prefixIcon: Icons.person_2_outlined,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            onChanged: (String) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  بريدك الألكتـــروني  ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 350,
                          child: myTextField(
                            prefixIcon: Icons.mail_outlined,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            onChanged: (String) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  نص الرســــالة   ',
                          style: MyTextStyles.font14BlackBold,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 350,
                          child: myTextField(
                            maxLength: 500,
                            prefixIcon: Icons.mail_outlined,
                            hintText: '',
                            keyboardType: TextInputType.text,
                            onChanged: (String) {},
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 130,
                              child: myButton(
                                  onPressed: () {},
                                  text: 'ارســـــــــال',
                                  textStyle: MyTextStyles.font16WhiteBold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              width: 130,
                              child: myButton(
                                  backgroundColor: MyColors.greyColor,
                                  onPressed: () {},
                                  text: 'خروج',
                                  textStyle: MyTextStyles.font16WhiteBold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'package:laqahy/view/widgets/successfully_add_state.dart';
import 'basic_widgets/basic_widgets.dart';

class AddChildState extends StatefulWidget {
  AddChildState({super.key});

  @override
  State<AddChildState> createState() => _AddChildStateState();
}

class _AddChildStateState extends State<AddChildState> {
  final List<String> items = [
    'مملكه الفول',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String? cityselectedValue;
  String? areaselectedValue;

  bool state = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: 350,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: MyColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 165,
                        height: 42,
                        child: Center(
                          child: Text(
                            'بيانات الأم',
                            style: MyTextStyles.font14PrimaryBold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              MyColors.primaryColor,
                              MyColors.secondaryColor,
                            ],
                            begin: AlignmentDirectional.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                          ),
                        ),
                        width: 165,
                        height: 42,
                        child: Center(
                          child: Text(
                            'بيانات الطفــل',
                            style: MyTextStyles.font16WhiteBold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   اسم ألأم   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  width: 300,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.home_work_outlined,
                                            size: 16,
                                            color: MyColors.greyColor,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                      items: items
                                          .map(
                                            (String item) =>
                                                DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: MyTextStyles
                                                    .font14BlackBold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      value: cityselectedValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          cityselectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.greyColor
                                                  .withOpacity(0.3)),
                                          color: MyColors.whiteColor,
                                        ),
                                        elevation: 0,
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: MyColors.greyColor,
                                        iconDisabledColor: MyColors.greyColor,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColors.whiteColor,
                                        ),
                                        // offset: const Offset(-29, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '    اسم الطفل   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 3),
                                  width: 300,
                                  child: myTextField(
                                    prefixIcon: Icons.person_2_outlined,
                                    hintText: '',
                                    keyboardType: TextInputType.text,
                                    onChanged: (String) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '    محل الميلاد   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  width: 200,
                                  child: myTextField(
                                    prefixIcon: Icons.home,
                                    hintText: '',
                                    keyboardType: TextInputType.text,
                                    onChanged: (String) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '    تاريخ الميلاد   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  width: 200,
                                  child: myTextField(
                                    prefixIcon: Icons.date_range,
                                    hintText: '',
                                    keyboardType: TextInputType.text,
                                    onChanged: (String) {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   الجنس   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 3),
                                  width: 150,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.male_outlined,
                                            size: 16,
                                            color: MyColors.greyColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                      items: items
                                          .map(
                                            (String item) =>
                                                DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: MyTextStyles
                                                    .font14BlackBold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      value: areaselectedValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          areaselectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.greyColor
                                                  .withOpacity(0.3)),
                                          color: MyColors.whiteColor,
                                        ),
                                        elevation: 0,
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: MyColors.greyColor,
                                        iconDisabledColor: MyColors.greyColor,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColors.whiteColor,
                                        ),
                                        // offset: const Offset(-29, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   المحافظة   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 3),
                                  width: 150,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.male_outlined,
                                            size: 16,
                                            color: MyColors.greyColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                      items: items
                                          .map(
                                            (String item) =>
                                                DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: MyTextStyles
                                                    .font14BlackBold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      value: areaselectedValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          areaselectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.greyColor
                                                  .withOpacity(0.3)),
                                          color: MyColors.whiteColor,
                                        ),
                                        elevation: 0,
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: MyColors.greyColor,
                                        iconDisabledColor: MyColors.greyColor,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColors.whiteColor,
                                        ),
                                        // offset: const Offset(-29, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   المديرية   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 3),
                                  width: 150,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Row(
                                        children: [
                                          Icon(
                                            Icons.male_outlined,
                                            size: 16,
                                            color: MyColors.greyColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                      items: items
                                          .map(
                                            (String item) =>
                                                DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: MyTextStyles
                                                    .font14BlackBold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      value: areaselectedValue,
                                      onChanged: (String? value) {
                                        setState(() {
                                          areaselectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 160,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MyColors.greyColor
                                                  .withOpacity(0.3)),
                                          color: MyColors.whiteColor,
                                        ),
                                        elevation: 0,
                                      ),
                                      iconStyleData: IconStyleData(
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                        ),
                                        iconSize: 14,
                                        iconEnabledColor: MyColors.greyColor,
                                        iconDisabledColor: MyColors.greyColor,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColors.whiteColor,
                                        ),
                                        // offset: const Offset(-29, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 130,
                              child: myButton(
                                  onPressed: () {
                                    return myShowDialog(
                                      context: context,
                                      widgetName: SuccessfullyAddState(),
                                    );
                                  },
                                  text: 'jj',
                                  textStyle: MyTextStyles.font16WhiteBold),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 130,
                              child: myButton(
                                  backgroundColor: MyColors.greyColor,
                                  onPressed: () {},
                                  text: 'الغــاء الأمــر',
                                  textStyle: MyTextStyles.font16WhiteBold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Image.asset("assets/images/add_status.png")
                  ],
                ),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'جميع الحقوق محفوظة ${DateTime.now().year} ©',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyColors.greyColor,
                          ),
                        )
                      ],
                    ),
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

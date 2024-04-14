import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/core/shared/styles/color.dart';
import 'basic_widgets/basic_widgets.dart';

class AddMotherState extends StatefulWidget {
  AddMotherState({super.key});

  @override
  State<AddMotherState> createState() => _AddMotherStateState();
}

class _AddMotherStateState extends State<AddMotherState> {
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
                            'بيانات الأم',
                            style: MyTextStyles.font14WhiteBold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 165,
                        height: 42,
                        child: Center(
                          child: Text(
                            'بيانات الطفــل',
                            style: MyTextStyles.font14PrimaryBold,
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
                                  '   الأسم   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
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
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   رقم الهاتف   ',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 20, top: 3),
                                  width: 200,
                                  child: myTextField(
                                    prefixIcon: Icons.call_outlined,
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
                                  '   تاريخ الميلاد   ',
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
                                            Icons.home_work_outlined,
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
                                            Icons.location_on_outlined,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '  العزلة    ',
                              style: MyTextStyles.font14BlackBold,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20, top: 3),
                              width: 200,
                              child: myTextField(
                                prefixIcon: Icons.woman,
                                hintText: '',
                                keyboardType: TextInputType.text,
                                onChanged: (String) {},
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 185,
                              child: CheckboxListTile(
                                fillColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                side: BorderSide(
                                  color: MyColors.primaryColor,
                                ),
                                checkColor: MyColors.primaryColor,
                                value: state,
                                onChanged: (val) {
                                  setState(() {
                                    state = val!;
                                  });
                                },
                                title: Text(
                                  'هل لديك طفل؟',
                                  style: MyTextStyles.font14BlackBold,
                                ),
                              ),
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
                                  onPressed: () {},
                                  text: 'اضــــافة',
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
                    Image.asset("assets/images/add_status.png")
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

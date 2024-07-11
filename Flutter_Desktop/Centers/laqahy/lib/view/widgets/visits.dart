import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:laqahy/core/shared/styles/style.dart';
import 'package:laqahy/view/widgets/basic_widgets/basic_widgets.dart';

import '../../core/shared/styles/color.dart';

class VisitsSearch extends StatefulWidget {
  const VisitsSearch({super.key});

  @override
  State<VisitsSearch> createState() => _VisitsSearchState();
}

class _VisitsSearchState extends State<VisitsSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              image: const DecorationImage(
                image: AssetImage("assets/images/image1.png"),
                // fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  child: SearchAnchor(
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        shape: MaterialStatePropertyAll(
                          BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        elevation: const MaterialStatePropertyAll(0),
                        hintText: 'أدخل أسم الأم',
                        backgroundColor: MaterialStatePropertyAll(
                            MyColors.secondaryColor.withOpacity(0.3)),
                        controller: controller,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(
                        searchlist.length,
                        (index) {
                          // final String item = 'item $index';
                          return ListTile(
                            title: Text(searchlist[index]),
                            onTap: () {
                              setState(
                                () {
                                  controller.closeView(searchlist[index]);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  child: myButton(
                      onPressed: () {},
                      text: 'بحـــــــث',
                      textStyle: MyTextStyles.font16WhiteBold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

List searchlist = [
  "زينب",
  "امل",
  "فاطمه",
  "رحمه",
];

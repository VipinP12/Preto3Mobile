import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/comman_textStyle.dart';

class ScheduleBottomSheet extends StatelessWidget {
    ScheduleBottomSheet({super.key});

  List<Days> dayList = [
    Days(
      title: 'Monday',
    ),
    Days(
      title: 'Tuesday',
    ),
    Days(
      title: 'Wednesday',
    ),
    Days(
      title: 'thursday',
    ),
    Days(
      title: 'friday',
    ),
    Days(
      title: 'saturday',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.centerRight,
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
              SvgPicture.asset(AppAssets.bottomBarCloseIcon)),
        ),
        Container(
          color: AppColor.white,
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.appPrimary,
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Creative Class",
                          style: TextStyles.textStyleFW500(AppColor.white, 16)),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.deleteIcon,
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20,),
                          SvgPicture.asset(
                            AppAssets.editIcon,
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.placeHolder,height: 42,width: 42,),
                            SizedBox(width: 15,),
                            Text("Amelia",
                              style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text("08/25/2022 - 10/30/2022",
                          style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),),
                      ),
                        Text("02:00PM - 04:00PM",
                        style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14),),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: dayList.map((day) {
                            final firstThreeLetters = day.title.substring(0, 3); // Extract the first three letters
                            return Container(
                              width: 80,
                              child: Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: 5,
                                    color: AppColor.paidColor,
                                  ),
                                  SizedBox(width: 8),
                                  Text(firstThreeLetters,
                                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 12),), // Display the first three letters
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Text("This schedule was created by the school admin.",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 12),),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.appPrimary,
                    ),
                    child: Text("Apply",
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                )
              ]),
        )
      ],
    );
  }
}
class Days {
  String title;


  Days({
    required this.title,
  });
}
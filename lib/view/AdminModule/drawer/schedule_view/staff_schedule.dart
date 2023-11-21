import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/comman_textStyle.dart';

class StaffSchedule extends StatelessWidget {
  const StaffSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext,index){
          return Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppAssets.placeHolder,height: 42,width: 42,),
                      SizedBox(width: 15,),
                      Text("Amelia",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                    ],
                  ),
                  Row(
                    children: [
                      Container(height: 40,width: 0.5,color: Colors.black,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Creative class ",
                            style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                          SizedBox(height: 5,),
                          Text("10:00AM-11:00PM",
                            style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 12),),
                        ],
                      ),
                    ],
                  ),
                  Divider(thickness: 1)

                ],
              ),
              Divider(thickness: 1)
            ],
          );
        });
  }
}

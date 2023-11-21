import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/utils/app_color.dart';

import '../../controller/room_controller.dart';
import '../../utils/app_routes.dart';
import '../../utils/argument_keys.dart';
import '../../utils/comman_textStyle.dart';

class RoomRatioPage extends StatelessWidget {
      RoomRatioPage({super.key});

  final roomController = Get.find<RoomController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets. symmetric(horizontal: 20,vertical: 20),
      child:   Column(
        children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Room",
              style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,),),
              SizedBox(width: 20,),
              Text("Students",
                style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,)),
              Text("Staff",
                  style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,)),
              Text("Ratio",
                  style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,)),
            ],
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                itemCount: roomController.allRoomRatio.length,
                itemBuilder: (BuildContext,int index){
                  var data = roomController.allRoomRatio[index]!;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: (){
                        Get.toNamed(AppRoute.roomSelect,arguments: {
                          ArgumentKeys.argumentRoleId: roomController.roleId.value,
                          ArgumentKeys.argumentSchoolId: roomController.schoolId.value,
                          ArgumentKeys.argumentClassId: roomController.allRoomList[index]!.classId,
                        });
                      },

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:MediaQuery.of(context).size.width*0.32,
                                child: Text(roomController.allRoomRatio[index]!.name,
                                    style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,),),
                              ),
                               Text(roomController.allRoomRatio[index]!.studentCount.toString(),
                                   style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,),),
                              Text(roomController.allRoomRatio[index]!.staffCount.toString(),
                                  style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,),),
                              Text("${data.studentCount.toString()}:${data.staffCount.toString()}",
                                  style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14.0,),)
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.6,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )

        ],
      ),
    );
  }
}

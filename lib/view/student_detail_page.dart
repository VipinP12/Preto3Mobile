import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/controller/student_controller.dart';
import 'package:preto3/model/room_list_model.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dimens.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

class StudentDetailPage extends StatelessWidget {
  StudentDetailPage({Key? key}) : super(key: key);

  final studentController = Get.find<StudentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.appPrimary,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          AppString.students,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions:   [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          InkWell(
            onTap: (){
              print("(((((((((((object)))))))))))");
              Get.toNamed(AppRoute.addStudentsProfile);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child:  Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              ),
            ),
          )
        ],
      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
            return [
              SliverToBoxAdapter(
                  child: Obx(()=>
                      Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 16),
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  color: AppColor.totalColor,
                                  border: Border.all(color: AppColor.borderColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Total",style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                    Text(studentController.studentTotal.value.toString(),style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 24,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 16),
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  color: AppColor.inColor,
                                  border: Border.all(color: AppColor.borderColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("In",style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                    Text(studentController.studentCheckedIn.value.toString(),style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 24,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 16),
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  color: AppColor.outColor,
                                  border: Border.all(color: AppColor.borderColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Out",style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                    Text(studentController.studentCheckedOut.value.toString(),style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 24,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 16),
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                  color: AppColor.absentColor,
                                  border: Border.all(color: AppColor.borderColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Absent",style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 14,fontWeight: FontWeight.w400),),
                                    Text(studentController.studentAbsent.value.toString(),style: GoogleFonts.poppins(
                                        color: AppColor.white,fontSize: 24,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.paddingVertical16,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 45,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: GetBuilder<StudentController>(builder: (controller) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: DropdownButton<RoomListModel>(
                                  //elevation: 5,
                                  hint: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Select Room',style: GoogleFonts.poppins(
                                        color: AppColor.lightTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ),
                                  isExpanded: true,
                                  icon: Visibility(
                                      visible: true,
                                      child: SvgPicture.asset(AppAssets.dropdownIcon)),
                                  dropdownColor: AppColor.white,
                                  borderRadius: BorderRadius.circular(10),
                                  iconEnabledColor: AppColor.appPrimary,
                                  underline: Container(),
                                  alignment: Alignment.topCenter,
                                  items: controller.allRoomList.map((
                                      RoomListModel? room) =>
                                      DropdownMenuItem<RoomListModel>(
                                          value: room, child: Text(room!.className.toString(),style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      ),)))
                                      .toList(),
                                  onChanged: (changed){
                                    controller.setRoom(changed!);
                                    print("verma");
                                    log("Selected Room:${controller.selectedClassRoom}");
                                  },
                                  value: controller.myRoom,
                                ),
                              ),)
                      ),
                    ],
                  )
                  ),)
            ];
          },
          body:
          GetBuilder<StudentController>(
            builder: (controller) => ListView.builder(
                itemCount: controller.allStudentList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                   child:  InkWell(
                     onTap: (){
                       Get.toNamed(AppRoute.studentProfile);
                     },
                     child: SizedBox(
                       height: 80,
                       width: double.maxFinite,
                       child: Padding(
                         padding:
                         const EdgeInsets.symmetric(
                             horizontal: 16.0),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.start,
                           crossAxisAlignment:
                           CrossAxisAlignment.center,
                           children: [
                             Stack(
                               children: [
                                 Container(
                                   height: 42,
                                   width: 42,
                                   decoration: BoxDecoration(
                                       color:
                                       AppColor.white,
                                       borderRadius:
                                       BorderRadius
                                           .circular(
                                           20)),
                                   child: ClipRRect(
                                     borderRadius:
                                     BorderRadius
                                         .circular(20),
                                     child: const Image(
                                       image: AssetImage(
                                           AppAssets
                                               .dummyDp),
                                       height: 50,
                                       width: 50,
                                     ),
                                   ),
                                 ),
                                 Positioned(
                                     top: 26,
                                     left: 26,
                                     right: 0,
                                     bottom: 0,
                                     child:
                                     SvgPicture.asset(
                                       AppAssets
                                           .activeIcon,
                                       height: 16,
                                       width: 16,
                                     ))
                               ],
                             ),
                             const SizedBox(
                               width: 8,
                             ),
                             Flexible(
                                 child: Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment
                                       .spaceBetween,
                                   crossAxisAlignment:
                                   CrossAxisAlignment
                                       .center,
                                   children: [
                                     Text(
                                       controller
                                           .allStudentList[
                                       index]!
                                           .studentFullName
                                           .toString(),
                                       style: GoogleFonts.poppins(
                                           color: AppColor
                                               .heavyTextColor,
                                           fontSize: 14,
                                           fontWeight:
                                           FontWeight
                                               .w500),
                                     ),
                                     const Icon(Icons
                                         .arrow_forward_ios,color: AppColor.mediumTextColor,size: 16,)
                                   ],
                                 ))
                           ],
                         ),
                       ),
                     ),
                   ),
                  );
                }),
          )
      ),
    );
  }
}

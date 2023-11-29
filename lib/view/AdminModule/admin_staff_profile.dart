import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';

import '../../components/rounded_button.dart';
import '../../controller/Admin/staff_management/admin_staff_profile.dart';
import '../../utils/comman_textStyle.dart';
import '../../utils/comman_textfield.dart';

class AdminStaffProfile extends StatefulWidget {
    const AdminStaffProfile({Key? key}) : super(key: key);

  @override
  State<AdminStaffProfile> createState() => _AdminStaffProfileState();
}

class _AdminStaffProfileState extends State<AdminStaffProfile> {

  final staffController = Get.find<AdminStaffProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isInnerScroll) {
            return [
              SliverAppBar(
                title: Text("Profile new***",
                  style: GoogleFonts.poppins(
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                expandedHeight: 320,
                floating: false,
                pinned: true,
                actions:   [
                  InkWell(
                    onTap: (){
                      // staffController.updateStaffProfileSession();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, top: 16),
                      child: Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: AppColor.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: const Image(
                    image: AssetImage(AppAssets.profileBg),
                    fit: BoxFit.fill,
                  ),
                  title: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 140,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(90)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: const Image(
                                  height: 75,
                                  width: 75,
                                  image: AssetImage(
                                    AppAssets.placeHolder,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Positioned(
                            //     top: 10,
                            //     right: 5,
                            //     child: InkWell(
                            //       onTap: () {
                            //         _bottomUploadImageSheet(context);
                            //       },
                            //       child: Container(
                            //         height: 24,
                            //         width: 24,
                            //         decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(24),
                            //         ),
                            //         child:
                            //         SvgPicture.asset(AppAssets.roundedAdd),
                            //       ),
                            //     )),
                            Positioned(
                               bottom: 8,
                              right: 15,
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(width: 1.5, color: Colors.white)
                                ),
                               ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "name",
                          style: GoogleFonts.poppins(
                              color: AppColor.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                         const Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(Icons.call,size: 20,color: AppColor.white,),
                             SizedBox(
                               width: 6,
                             ),
                             Icon(Icons.mail_outline,size: 20,color: AppColor.white,)
                           ],
                         )
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              )
            ];
          },
          body:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const CommonTextField(hintText: 'First Name', title: "First Name",),
                    const CommonTextField(hintText: 'Last Name', title: "Last Name",),
                  const CommonTextField(hintText: 'Example@gmail.com', title: "Email",),
                  const CommonTextField(hintText: '1234567890', title: "Phone Number",),
                  const CommonTextField(hintText: '---', title: "Bio",),
                  Text("Pay Information",style: TextStyles.textStyleFW500(AppColor.black, 12),),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColor. white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black,)
                      ),
                    child: const Padding(
                      padding:   EdgeInsets. symmetric(vertical: 10,horizontal: 20),
                      child: Row(
                        children: [
                          Icon(Icons.radio_button_off),
                          SizedBox(width: 10,),
                          Text("Salaried"),
                          SizedBox(width: 45,)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: AppColor. white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black,)
                    ),
                    child: const Padding(
                      padding:   EdgeInsets. symmetric(vertical: 10,horizontal: 20),
                      child: Row(
                        children: [
                          Icon(Icons.radio_button_off),
                          SizedBox(width: 10,),
                          Text("Salaried"),
                          SizedBox(width: 45,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Date Of Birth",style: TextStyles.fontSize12),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width*0.4,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.disableColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:   Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                child: InkWell(
                                  onTap: (){
                                    // selectDatePicker();
                                    // print(selectedDate != null
                                    //     ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                    //     : "Enter date");
                                  },
                                  child:  const Row(
                                    children: [
                                      Icon(Icons.calendar_month_sharp),
                                      SizedBox(width: 10,),
                                      Text(
                                        // selectedDate != null
                                        //   ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                        //   :
                                        "01/11/2023",
                                        style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Joining Date",style: TextStyles.fontSize12),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: MediaQuery.of(context).size.width*0.4,
                              // width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: AppColor.disableColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:   Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                child: InkWell(
                                  onTap: (){
                                    // selectDatePicker();
                                    // print(selectedDate != null
                                    //     ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                    //     : "Enter date");
                                  },
                                  child:  const Row(
                                    children: [
                                      Icon(Icons.calendar_month_sharp),
                                      SizedBox(width: 10,),
                                      Text(
                                        // selectedDate != null
                                        //   ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                        //   :
                                        "--/--/----",
                                        style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(height: 10,),
                  Text("Spoken Languages",style: TextStyles.textStyleFW500(AppColor.black, 12)),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: staffController.selectedValue,
                            items: <String>['Hindi', 'English',]
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                staffController.selectedValue = newValue!;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text("Select Role",style: TextStyles.textStyleFW500(AppColor.black, 12)),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: staffController.selectedRole,
                            items: <String>['Teacher', 'Cordinator',]
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                staffController.selectedRole = newValue!;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColor.dashRoomBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      child: Text("Assigned Room",style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.circular(
                                20)),
                        child: const Center(child:
                        Text("C",
                        )
                        ),
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
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Class Name",
                                style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                              ),
                              Text("Remove",
                                style: TextStyles.textStyleFW500(AppColor.invoiceNumberColor, 14),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                  const Divider(thickness: 1,),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                            BorderRadius.circular(
                                20)),
                        child: const Center(child:
                        Text("C",
                        )
                        ),
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
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Class Name",
                                style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                              ),
                              Text("Remove",
                                style: TextStyles.textStyleFW500(AppColor.invoiceNumberColor, 14),
                              )
                            ],
                          )
                      ),

                    ],
                  ),
                  const SizedBox(height: 20,),
                  Text("Assign New Room",style: TextStyles.textStyleFW500(AppColor.black, 12)),
                  const SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.disableColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: staffController.selectedAssignName,
                            items: <String>['Assign New Room','Hello']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                staffController.selectedAssignName = newValue!;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Sub Admin",
                       style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                     ),
                     Transform.scale(
                         transformHitTests: false,
                         scale: 1,
                       child: CupertinoSwitch(
                         activeColor: Colors.red,
                         value: staffController.isSwitched,
                         onChanged: (value) {
                           setState(() {
                             staffController.isSwitched = value;
                           });
                         },
                       ),
                     ),
                   ],
                 ),
                  const Divider(thickness: 1,),
                  Text("Now you can give your existing staff the privilleges of a school-admin.",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14)
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child: RoundedButton(height: 50, width: 150,
                      color:  AppColor.dashRoomText, onClick: () {  },
                      text: 'make admin', style: TextStyles.textStyleFW400(AppColor. white, 16),),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}

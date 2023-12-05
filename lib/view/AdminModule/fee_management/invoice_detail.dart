import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart%20';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/comman_textStyle.dart';

class InvoiceDetail extends StatelessWidget {
  const InvoiceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Invoice Detail",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions:   [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: SvgPicture.asset(
                AppAssets.downloadIcon),
          )
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.totalStudent),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "user name",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),
                      ),
                    ],
                  ),
                  Text('Resend Invoice',
                    style: TextStyles.textStyleFW400(AppColor.invoiceNumberColor, 14),
                  ),
                ],
              ),
              Divider(),
              Container(
                margin: const EdgeInsets.symmetric(vertical:15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:   AppColor.invoiceNumberColor.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.refreshIcon),
                      SizedBox(width: 8,),
                      Text("Recurring invoice",
                        style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 12),),
                    ],
                  ),
                  Container(),
                  Row(
                    children: [
                      SvgPicture.asset(
                          AppAssets.autopay),
                      SizedBox(width: 8,),
                      Text("Set on autopay",
                        style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 12),),
                    ],
                  ),
                    Container(),
                 ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wonderland \n Avenue Pre School",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 18),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text("5905 Wilshire Blvd,\n Los Angeles, CA 90036, \n United States",
                          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 12),),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Invoice# \n 005453",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 18),),
                      Container(height: 60,)
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bill to",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 18),),
                      Padding(
                        padding: const EdgeInsets. only(top: 15),
                        child: Text("Parent Name",
                          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 12),),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Balance Due",
                        style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 12),),
                      SizedBox(height: 8,),
                      Text("1,516.00",
                        style: TextStyles.textStyleFW500(AppColor.appPrimary, 24),),
                    ],
                  ),
              ],),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Maria Hernade",
                  style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 12),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("mariahernade45@gmail.com",
                    style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 12),),
                  Text("Date of service:",
                    style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 10),),
                  Text("08/01/2022 - 08/30/2022",
                    style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 10),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Child Name",
                      style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 12),),
                    Text("Issue Date:",
                      style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 10),),
                    Text("08/30/2022",
                      style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 10),),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Olivia Davis",
                    style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 12),),
                  Text("Due Date:",
                    style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 10),),
                  Text("08/30/2022",
                    style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 10),),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical:15),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color:   AppColor.borderColor ,
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  border:   Border.all(
                      color: AppColor.heavyTextColor.withOpacity(0.2)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("line Item",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                    Container(
                      padding: EdgeInsets.zero,
                      height:45,
                      width: 0.5,
                      color: AppColor.heavyTextColor,),
                    Text("Total Amount",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                  ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tuition Fee",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                  Text("1,200.00",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                ],),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Activity Fee",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                    Text("116.00",
                      style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                  ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Meals & Snacks",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                  Text("200.00",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                ],),
              SizedBox(height: 10,),
              Divider(color: Colors.black,),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Meals & Snacks",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                  Text("1,516.00",
                    style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 14),),
                ],),

              Container(
                margin: const EdgeInsets.symmetric(vertical:15),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color:   AppColor.borderColor ,
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  border:   Border.all(
                      color: AppColor.heavyTextColor.withOpacity(0.2)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Balance Due",
                      style: TextStyles.textStyleFW500(AppColor.appPrimary, 14),),
                    Container(
                      padding: EdgeInsets.zero,
                      height:45,
                      width: 0.5,
                      color: AppColor.heavyTextColor,),
                    Text("1,516.00",
                      style: TextStyles.textStyleFW500(AppColor.appPrimary, 14),),
                  ],),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}

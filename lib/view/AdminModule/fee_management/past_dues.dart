import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../../../utils/comman_textStyle.dart';

class PastDues extends StatefulWidget {
  const PastDues({super.key});

  @override
  State<PastDues> createState() => _PastDuesState();
}

class _PastDuesState extends State<PastDues> {
  bool expendedPast =  false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          child:  Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3.8,vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.invoiceNumberColor.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text("Past Dues",
                      style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 14),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("1,000.00",
                        style: TextStyles.textStyleFW600(AppColor.heavyTextColor, 30),),
                    ),
                    Text("Paid invoices in last 30 days",
                      style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 12),),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index){
                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  expendedPast = !expendedPast;
                                });
                              },
                              child: Row(
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
                                  Column(
                                    children: [
                                      Text("700.00",
                                          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 16)),
                                      Row(
                                        children: [
                                          Text('view detail',
                                            style: TextStyles.textStyleFW400(AppColor.invoiceNumberColor, 14),
                                          ),
                                          Icon(expendedPast?Icons.arrow_drop_up:Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: expendedPast,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                decoration: BoxDecoration(
                                  color: AppColor.invoiceNumberColor.withOpacity(0.05),
                                  border: const Border(
                                    top: BorderSide(width: 0.5, color: AppColor.heavyTextColor),
                                    bottom: BorderSide(width: 0.5, color: AppColor.heavyTextColor),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Invoice #",
                                          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 13),),
                                        Text("Payment Date :",
                                          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 13),),
                                        Text("Paid Amount :",
                                          style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 13),),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text("003515",
                                                style: TextStyles.textStyleFW500(AppColor.invoiceNumberColor, 12),),
                                              const SizedBox(width: 5,),
                                              SvgPicture.asset(
                                                  AppAssets.refreshIcon),
                                            ],
                                          ),
                                          Text("30/10/2022",
                                            style: TextStyles.textStyleFW500(AppColor.heavyTextColor, 12),),
                                          Text("300.00",
                                            style: TextStyles.textStyleFW500(AppColor.outColor, 12),),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("view invoices",
                                          style: TextStyles.textStyleFW400(AppColor.outColor, 12),),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("view invoices", style: TextStyles.textStyleFW500(AppColor.invoiceNumberColor, 14),),
                                            const SizedBox(width: 5,),
                                            const Icon(Icons.arrow_forward,color: AppColor.invoiceNumberColor,size: 15,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 60,)
            ],
          ),
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.12,
            color: AppColor.disableColor,
            child: Text("For better experience, please use web \n application for any invoice related actions or \n visit https://app.preto3.com/Feemanagement",
                textAlign: TextAlign.center,
                style: TextStyles.textStyleFW400(AppColor.heavyTextColor, 14) ))
    );
  }
}

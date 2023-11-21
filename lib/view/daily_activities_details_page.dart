import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/controller/daily_activity_detail_controller.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/utils/app_string.dart';

class DailyActivitiesDetailsPage extends StatelessWidget {
  DailyActivitiesDetailsPage({Key? key}) : super(key: key);

  final dailyController = Get.find<DailyActivityDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
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
          AppString.dailyActivity,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          dailyController.roleId.value == 4
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoute.addDailActivity);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 45,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(42)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(42),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => const Image(
                            height: 42,
                            width: 42,
                            image: AssetImage(
                              AppAssets.placeHolder,
                            ),
                            fit: BoxFit.cover,
                          ),
                          imageUrl: dailyController.studentProfilePic.value,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const Image(
                            height: 42,
                            width: 42,
                            image: AssetImage(
                              AppAssets.placeHolder,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        dailyController.studentName.value,
                        style: GoogleFonts.poppins(
                            color: AppColor.heavyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              height: 1,
              color: AppColor.disableColor,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 40,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColor.profileHeaderBG,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    dailyController.activityDate.value,
                    style: GoogleFonts.poppins(
                        color: AppColor.heavyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            GetBuilder<DailyActivityDetailController>(
              builder: (controller) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.studentDailyActivity.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(42)),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => const Image(
                                    height: 42,
                                    width: 42,
                                    image: AssetImage(
                                      AppAssets.placeHolder,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  imageUrl: controller
                                      .studentDailyActivity[index].imageUrl,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Image(
                                    height: 42,
                                    width: 42,
                                    image: AssetImage(
                                      AppAssets.placeHolder,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                          .studentDailyActivity[index].name,
                                      style: GoogleFonts.poppins(
                                          color: AppColor.heavyTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${DateFormat("hh:mm a").format(DateTime.parse(controller.studentDailyActivity[index].activityStartTime))} to ${DateFormat("hh:mm a").format(DateTime.parse(controller.studentDailyActivity[index].activityEndTime))}",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.mediumTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "",
                              style: GoogleFonts.poppins(
                                  color: AppColor.mediumTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dailyController.argumentActivityImgUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  print(dailyController.argumentActivityImgUrls[index]);
                  return Container(
                    height: 180,
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const Image(
                          image: AssetImage(
                            AppAssets.noImageFound,
                          ),
                          fit: BoxFit.contain,
                        ),
                        imageUrl: dailyController.argumentActivityImgUrls[index]
                            .trim(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Image(
                          height: 75,
                          width: 75,
                          image: AssetImage(
                            AppAssets.noImageFound,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
            const Divider(
              height: 1,
              color: AppColor.disableColor,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

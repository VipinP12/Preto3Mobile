import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:preto3/view/AdminModule/fee_management/past_dues.dart';
import 'package:preto3/view/AdminModule/fee_management/total_paid.dart';
import 'package:preto3/view/AdminModule/fee_management/upcoming_dues.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_color.dart';
import '../drawer/switch_school_role/switch_school_bottomSheet.dart';
import 'Refund.dart';
import 'chargeback.dart';
import 'declined.dart';

class FeeManagement extends StatelessWidget {
  const FeeManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColor.appPrimary,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            InkWell(
              onTap: (){
                showModalBottomSheet(
                  // isScrollControlled:true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  isDismissible: true,
                  enableDrag: false,
                  builder: (context) {
                    return   const SingleChildScrollView(
                      child: SwitchSchoolRoleBottomSheet(),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SvgPicture.asset(
                  AppAssets.filterIcon,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                indicatorColor: const Color(0xffB01AA5),
                indicatorWeight: 4,
                labelColor: AppColor.appPrimary,
                unselectedLabelColor: AppColor.lightTextColor,
                onTap: (index) {
                  // Tab index when user select it, it start from zero
                },
                tabs: const [
                  Tab(
                    text: "Total paid",
                  ),
                  Tab(
                    text: "Upcoming dues",
                  ),
                  Tab(
                    text: "Past dues",
                  ),
                  Tab(
                    text: "Declined",
                  ),
                  Tab(
                    text: "Refund",
                  ),
                  Tab(
                    text: "Chargeback",
                  ),
                ],
              ),
            ),
          ),
          title: const Text('Fee Management'),
        ),
        body:   TabBarView(
          children: [
            TotalPaid(),
            UpComingDues(),
            PastDues(),
            DeclinedDues(),
            Refund(),
            Chargeback(),
          ],
        ),
      ),
    );
  }
}

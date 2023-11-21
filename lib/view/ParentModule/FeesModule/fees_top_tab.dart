import 'package:flutter/material.dart';
import 'package:preto3/utils/app_color.dart';

import 'PaymentSection/payment_settings.dart';
import 'student_acount.dart';

class FeesTopTab extends StatelessWidget {
  const FeesTopTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBackground,
        appBar: AppBar(
          backgroundColor: AppColor.appPrimary,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: const Color(0xffB01AA5),
                indicatorWeight: 4,
                labelColor: AppColor.appPrimary,
                unselectedLabelColor: AppColor.lightTextColor,
                onTap: (index) {
                  // Tab index when user select it, it start from zero
                },
                tabs: const [
                  Tab(
                    text: "Fees Payment",
                  ),
                  Tab(
                    text: "Payment Settings",
                  ),
                ],
              ),
            ),
          ),
          title: const Text('Fees Payment'),
        ),
        body: TabBarView(
          children: [StudentAcount(), PaymentSettings()],
        ),
      ),
    );
  }
}

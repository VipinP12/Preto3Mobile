import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_color.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dashFeesBg,
      body: Center(
        child: Text("FEES PAGE",style: GoogleFonts.poppins(
        color: Colors.white,fontSize: 24,fontWeight: FontWeight.w700
        ),),
      ),
    );
  }
}

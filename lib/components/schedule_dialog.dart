import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_routes.dart';


class ScheduleDialog extends StatelessWidget {

  const ScheduleDialog({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: MediaQuery.of(context).size.height*0.9,
        width: MediaQuery.of(context).size.width,
        // color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                      AppAssets.bottomBarCloseIcon),
                ),
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                color: Colors.pink,
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.centerRight,
                child: Text("HEADING"),
              ),
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                color: Colors.pink,
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.centerRight,
                child: Text("body"),
              ),
            ],
          )
        ),
      ),
    );
  }
}

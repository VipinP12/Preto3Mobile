import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:preto3/utils/app_color.dart';

class SchdulePage extends StatelessWidget {
  const SchdulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(176, 26, 167, 0.15),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Today ${DateFormat("MM/dd/yyyy").format(DateTime.now())}",
                style: GoogleFonts.poppins(
                    color: AppColor.heavyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 10),
                      height: 40,
                      width: 1,
                      color: AppColor.hintTextColor,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          "Creative class",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "01:00PM to 02:30PM",
                          style: GoogleFonts.poppins(
                              color: AppColor.heavyTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

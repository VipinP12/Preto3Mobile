import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/comman_textStyle.dart';
import '../../utils/comman_textfield.dart';

class AddPrimaryParent extends StatelessWidget {
  const AddPrimaryParent({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text("Add Student",
          style:  TextStyles.textStyleFW600(AppColor.white, 18)
        ),
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
                style: TextStyles.textStyleFW500(AppColor.white, 18)
              ),
            ),
          )
        ],
      ),
      body:  const Padding(
        padding:   EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child:   Column(
          children: [
            CommonTextField(hintText: 'First Name', title: "First Name",),
            CommonTextField(hintText: 'Last Name', title: "Last Name",),
            CommonTextField(hintText: 'Example@12gmail.com', title: "Email",),
            CommonTextField(hintText: '1234567890', title: "Contact",),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preto3/controller/Admin/rooms_controller/manage_creative_class_settings_controller.dart';
import 'package:preto3/model/room/manage_creative_class_settings_model.dart';

class ManageCreativeClassStaff extends StatelessWidget {
  ManageCreativeClassStaff({super.key});

  final manageCreativeClassSettingsController =
      Get.find<ManageCreativeClassSettingsController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: GetBuilder(
                                    init: manageCreativeClassSettingsController,
                                    builder: ((controller) =>
                                        ListView.separated(
                                          itemCount:
                                              controller.personList.length,
                                          itemBuilder: (context, index) {
                                            ManageCreativeClassSettingsModel
                                                value =
                                                controller.personList[index];
                                            return ListTile(
                                              leading: Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        value.profilePicture),
                                                  ),
                                                  if (value.inRoom)
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .green),
                                                      ),
                                                    )
                                                  else
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        180,
                                                                        183,
                                                                        180)),
                                                      ),
                                                    )
                                                ],
                                              ),
                                              title: Text(value.name),
                                              trailing: ElevatedButton.icon(
                                                onPressed: () {
                                                  controller
                                                      .toggleInRoomsStatus(
                                                          index);
                                                },
                                                icon: Icon(
                                                  value.inRoom
                                                      ? Icons.check
                                                      : Icons.add,
                                                  color: value.inRoom
                                                      ? Colors.purple
                                                      : Colors.grey,
                                                ),
                                                label: Text(
                                                  value.inRoom
                                                      ? "In Room"
                                                      : "Add to Room",
                                                  style: TextStyle(
                                                      color: value.inRoom
                                                          ? Colors.purple
                                                          : Colors.grey),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                    onPrimary: Colors.purple,
                                                    side: const BorderSide(
                                                        color: Colors.purple)),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const Divider(
                                              color: Colors.grey,
                                              thickness: 0.6,
                                            );
                                          },
                                        )),
                                  ),
                                );
  }
}

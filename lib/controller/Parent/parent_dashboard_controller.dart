import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/components/changed_password_dialog.dart';
import 'package:preto3/components/custom_dialog.dart';
import 'package:preto3/controller/Communication/communication_controller.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/controller/daily_activity_controller.dart';
import 'package:preto3/controller/google_places_controller.dart';
import 'package:preto3/model/comm_get_staff_group_model.dart';
import 'package:preto3/model/comm_staff_model.dart';
import 'package:preto3/model/dashboard_categories_model.dart';
import 'package:preto3/model/google_place_model.dart';
import 'package:preto3/model/parent/parent_dashboard_model.dart';
import 'package:preto3/model/parent/parent_profile_model.dart';
import 'package:preto3/model/parent/relationship_model.dart';
import 'package:preto3/model/qr_code_code.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_dialog.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../components/update_alertbox.dart';
import '../../network/socket_server.dart';
import '../../utils/app_routes.dart';
import '../../utils/toast.dart';

class ParentDashboardController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var refreshController = RefreshController();
  var refreshController1 = RefreshController();
  var logedOut = false.obs;

  final communicationController = Get.find<CommunicationController>();
  final googlePlacesController = Get.lazyPut(() => GooglePlacesController());
  final firstNameKey = GlobalKey<FormState>();
  final lastNameKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final phoneKey = GlobalKey<FormState>();
  final addressKey = GlobalKey<FormState>();
  final cityKey = GlobalKey<FormState>();
  final stateKey = GlobalKey<FormState>();
  final countryKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();
  final newPasswordKey = GlobalKey<FormState>();
  final cPasswordKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var cPasswordController = TextEditingController();
  var searchStaffController = TextEditingController();

  var placeList = <Prediction>[].obs;

  var profilePic = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var username = "".obs;
  var addressName = "".obs;
  var dob = "".obs;
  var city = "".obs;
  var state = "".obs;
  var country = "".obs;
  var password = "".obs;
  var cPassword = "".obs;
  var searchStaff = "".obs;
  var qrCode = "".obs;

  var parentName = "".obs;
  var parentEmail = "".obs;
  var parentNumber = "".obs;
  var parentUsername = "".obs;
  var parentProfilePic = "".obs;
  var parentUsernameList = <String>[].obs;

  var isFirstNameValid = false;
  var isLastNameValid = false;
  var isPhoneValid = false;
  var isProfilePicValid = false;
  var isAddressValid = false;
  var isPasswordValid = false;
  var isNewPasswordValid = false;
  var isCPasswordValid = false;

  var isSelected = false.obs;
  var profileUpdateSuccess = false.obs;
  var profileUpdateFailed = false.obs;
  var selectedChildIndex = 0;
  var selectedIndex = 0;
  var userId = 0.obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var pin = "".obs;
  var inTime = 0.obs;
  var outTime = 0.obs;
  var totalHours = 0.obs;
  var eventCount = 0.obs;

  var selectedClassId = 0.obs;
  var childDetailsList = <ChildDetail>[].obs;
  var emergencyContactList = <Parent>[].obs;
  final allStaff = <CommStaffModel?>[].obs;
  var staffCommList = <CommGetStaffGroupModel>[].obs;
  var formattedInTime = "".obs;
  var formattedOutTime = "".obs;
  var totalHourTime = "".obs;
  var postalCode = "".obs;
  var schoolAddress = "".obs;
  var currentPassword = "".obs;
  var newPassword = "".obs;

  var isPasswordFocused = false.obs;
  var isNewPasswordFocused = false.obs;
  var isConfirmPasswordFocused = false.obs;

  FocusNode passwordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
    refreshController1 = RefreshController(initialRefresh: false);
    firstName.value = storageBox.read(AppKeys.keyFirstName);
    lastName.value = storageBox.read(AppKeys.keyLastName);
    username.value = storageBox.read(AppKeys.keyUserName);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    userId.value = storageBox.read(AppKeys.keyId);
    print("ROLE ID:${roleId.value}");
    print("SCHOOL ID:${schoolId.value}");
    print("USER ID:${userId.value}");
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    cPasswordController = TextEditingController();
    // communicationController.getGroups();
    parentUsernameList.add(username.value);
    addressController.addListener(() {
      getSuggestion(addressController.text);
    });
    super.onInit();
  }

  @override
  void onReady() {
    getParentDashboard(schoolId.value);
    getParentProfileDetails(schoolId.value);
    getRelationship(userId.value);
    getQrCode(schoolId.value, roleId.value);
    getGroupFromBackend(schoolId.value, roleId.value);
    Future.delayed(const Duration(seconds: 30), () {
      UpdateAlert.updateAlertBox();
    });
    // Get.find<DailyActivityController>()
    //     .getAllActivity(schoolId.value, roleId.value);
  }

  void onCommunicationRefresh() async {
    // showLoading();
    getParentDashboard(schoolId.value);
    getParentProfileDetails(schoolId.value);
    getRelationship(userId.value);
    getQrCode(schoolId.value, roleId.value);
    await getGroupFromBackend(schoolId.value, roleId.value);
    Get.find<DailyActivityController>()
        .getAllActivity(schoolId.value, roleId.value);
    refreshController1.refreshCompleted();
    // hideLoading();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  focusPasswordIcons(bool value) {
    isPasswordFocused.value = value;
    update();
  }

  focusNewPasswordIcons(bool value) {
    isNewPasswordFocused.value = value;
    update();
  }

  focusCPasswordIcons(bool value) {
    isConfirmPasswordFocused.value = value;
    update();
  }

  String? firstNameValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a valid first name';
  }

  String? lastNameValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a valid last name';
  }

  String? phoneValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a number';
    } else if (value.length < 10) {
      return 'phone number must be valid.';
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
      return null;
    }
    return 'Please enter a valid email address';
  }

  String? addressValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a address';
  }

  String? stateValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a state';
  }

  String? cityValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a city';
  }

  String? countryValidator(String value) {
    if (value.isNotEmpty) {
      return null;
    }
    return 'Please enter a country';
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain minimum eight characters, \nat least one uppercase letter, one lowercase letter,\none number and one special character.';
    }
    return null;
  }

  String? cPasswordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter confirm password';
    } else if (value.isNotEmpty && value != newPasswordController.text) {
      return 'Password mismatched';
    }
    return null;
  }

  void onRefresh() async {
    // monitor network fetch
    try {
      getParentDashboard(schoolId.value);
      getParentProfileDetails(schoolId.value);
      getRelationship(userId.value);
      getQrCode(schoolId.value, roleId.value);
      isError.value = false;
    } catch (e) {
      log(e.toString());
    }
    update();
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  Future<void> getGroupFromBackend(int schoolId, int roleId) async {
    log("School id: $schoolId  Roll  id :$roleId");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.getGroups}'
            '?schoolId=$schoolId&roleId=$roleId&student=true',
            flag: true)
        .catchError(handleError);

    if (response != null && response != "") {
      log("getGroupFromBackend ===>" + response);
      staffCommList.value = commGetStaffGroupModelFromJson(response);
      hideLoading();
      update();
    }
  }

  List<DashboardCategoriesModel> dashboardCategory = [
    DashboardCategoriesModel(
        name: AppString.communication,
        assetImage: AppAssets.dashboardComm,
        colors: AppColor.dashCommText,
        bgColors: AppColor.dashCommBg),
    DashboardCategoriesModel(
        name: AppString.feesPayment,
        assetImage: AppAssets.dashboardFees,
        colors: AppColor.dashFeesText,
        bgColors: AppColor.dashFeesBg),
    DashboardCategoriesModel(
        name: AppString.authorizedPickUp,
        assetImage: AppAssets.pickupIcon,
        colors: AppColor.dashCheckInText,
        bgColors: AppColor.dashCheckInBg),
    DashboardCategoriesModel(
      name: AppString.events,
      subtitle: "0 Events",
      assetImage: AppAssets.dashboardEvent,
      colors: AppColor.dashRoomText,
      bgColors: AppColor.dashRoomBg,
    ),
    DashboardCategoriesModel(
        name: AppString.schedule,
        assetImage: AppAssets.dashboardSchedule,
        colors: AppColor.dashStaffScheduleText,
        bgColors: AppColor.dashStaffScheduleBg),
  ];

  void getParentDashboard(
    int schoolId,
  ) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.parentDashboard}' '?schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      var dashResponse =
          ParentDashboardModel.fromJson(jsonDecode(response.toString()));
      firstName.value = dashResponse.parentFirstName;
      lastName.value = dashResponse.parentLastName;
      pin.value = dashResponse.checkInOutPin;
      childDetailsList.value = dashResponse.childDetails;
      schoolAddress.value = dashResponse.schoolAddress;
      communicationController.selectedStudentId.value =
          childDetailsList.first.id;
      getAllStaff(schoolId, roleId.value, childDetailsList.first.id);
      eventCount.value = dashResponse.eventCount;
      storageBox.write(AppKeys.keyParentProfileURL, dashResponse.profilePic);
      storageBox.write(AppKeys.keyFirstName, dashResponse.parentFirstName);
      storageBox.write(AppKeys.keyLastName, dashResponse.parentLastName);
      storageBox.write(AppKeys.keyCheckInOutPin, dashResponse.checkInOutPin);
      for (int i = 0; i < childDetailsList.length; i++) {
        setTotalHour(i);
      }

      hideLoading();
      update();
    }
  }

  void setTotalHour(index) {
    if (childDetailsList[index].outTime != "-") {
      var dateTime1 =
          DateTime.fromMillisecondsSinceEpoch(childDetailsList[index].inTime);
      var dateTime2 =
          DateTime.fromMillisecondsSinceEpoch(childDetailsList[index].outTime);
      Duration diff = dateTime2.difference(dateTime1);

      if (childDetailsList[index].inTime == "-" ||
          childDetailsList[index].outTime == "-") {
        childDetailsList[index].totalHours = "-";
      } else {
        childDetailsList[index].totalHours =
            "${diff.inHours}:${diff.inMinutes.remainder(60)}";
      }
      update();
    }
  }

  void getParentProfileDetails(int schoolId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.parentProfileDetails}' '?schoolId=$schoolId')
        .catchError(handleError);
    if (response != null) {
      var parentResponse = parentProfileModelFromJson(response);
      firstName.value = parentResponse.firstName;
      lastName.value = parentResponse.lastName;
      roleId.value = parentResponse.roleId;
      firstNameController.text = parentResponse.firstName;
      lastNameController.text = parentResponse.lastName;
      phoneController.text = parentResponse.phoneNumber;
      addressController.text = parentResponse.address;
      email.value = parentResponse.email;

      update();
    }
  }

  void getRelationship(int userId) async {
    try {
      var response = await BaseClient()
          .get(ApiEndPoints.devBaseUrl,
              '${ApiEndPoints.parentRelations}' '?id=$userId')
          .catchError(handleError);
      if (response != null) {
        hideLoading();
        var relationshipResponse = relationshipModelFromJson(response);
        parentName.value = relationshipResponse.parent.name;
        parentEmail.value = relationshipResponse.parent.email;
        parentNumber.value = relationshipResponse.parent.phoneNumber.toString();
        parentProfilePic.value = relationshipResponse.parent.profilePic;
        parentUsername.value = relationshipResponse.parent.userName;
        parentUsernameList.add(relationshipResponse.parent.userName);
        emergencyContactList.value = relationshipResponse.emergencyContact;
        update();
      }
    } catch (e) {
      hideLoading();
      print(e);
    }
  }

  int getTotalHours(int index, int inTime, int outTime) {
    var dateTime1 = DateTime.fromMillisecondsSinceEpoch(inTime);
    var dateTime2 = DateTime.fromMillisecondsSinceEpoch(outTime);
    Duration diff = dateTime2.difference(dateTime1);

    if (inTime == 0 || outTime == 0) {
      totalHourTime.value = "-";
    } else {
      childDetailsList[index].totalHours =
          "${diff.inHours}:${diff.inMinutes.remainder(60)}";
    }
    update();
    return 0;
  }

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  void changeChildIndex(int index) {
    selectedChildIndex = index;
    communicationController.selectedStudentId.value =
        childDetailsList[index].id;

    getAllStaff(schoolId.value, roleId.value,
        communicationController.selectedStudentId.value);
    update();
  }

  void findAddressOnGoogle() {}
  void updateParentSession() {
    isFirstNameValid = firstNameKey.currentState!.validate();
    isLastNameValid = lastNameKey.currentState!.validate();
    isPhoneValid = phoneKey.currentState!.validate();
    isAddressValid = addressKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isFirstNameValid && isLastNameValid) {
      firstNameKey.currentState!.save();
      lastNameKey.currentState!.save();
      var fullAddress = "${addressController.text},${postalCode.value}";
      callUpdateProfileApi(roleId.value, firstNameController.text,
          lastNameController.text, phoneController.text, fullAddress);
    }
  }

  void changePasswordSession(BuildContext context) {
    isPasswordValid = passwordKey.currentState!.validate();
    isNewPasswordValid = newPasswordKey.currentState!.validate();
    isCPasswordValid = cPasswordKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isPasswordValid && isCPasswordValid) {
      passwordKey.currentState!.save();
      cPasswordKey.currentState!.save();
      log("SAVE ${currentPassword.value}");
      log("SAVE ${newPassword.value}");
      changePasswordAPICall(currentPassword.value, newPassword.value, context);
    }
  }

  void getAllStaff(int schoolId, int roleId, int studentId) async {
    showLoading();
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.allStaffCommunication}'
            '?schoolId=$schoolId&roleId=$roleId&studentId=$studentId',
            flag: true)
        .catchError(handleError);

    if (response != null && response != "") {
      allStaff.value = commStaffModelFromJson(response);
      communicationController.selectedStaffId.value = allStaff.first!.staffId;
    }
    hideLoading();
    update();
  }

  void getSuggestion(String input) async {
    placeList.clear();
    try {
      String type = 'address';
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&types=$type&key=${ApiEndPoints.googleTimeZoneApiKey}';
      print("REQ URL$request");
      var response = await http.get(Uri.parse(request));
      // log("PLACES RESPONSE:${response.body}");
      var placesResponse =
          GooglePlaceModel.fromJson(json.decode(response.body));
      log("TO LIST${placesResponse.predictions.length}");
      placeList.value = placesResponse.predictions;
      update();
    } catch (e) {
      print("Exceptions :${e.toString()}");
    }
  }

  void callUpdateProfileApi(int roleId, String firstname, String lastname,
      String phone, String address) async {
    var param = {
      "roleId": roleId,
      "firstName": firstname,
      "lastName": lastname,
      "phoneNumber": phone,
      "profilePic": "",
      "address": address
    };

    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.parentProfileUpdate, param)
        .catchError(handleError);
    AppDialog.showLoading(response);
    hideLoading();
    Get.back();
  }

  void getQrCode(int schoolId, int roleId) async {
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.qrCode}' '?schoolId=$schoolId&roleId=$roleId')
        .catchError(handleError);
    if (response != null) {
      var qrResponse = qrCodeCodeFromJson(response);
      log("SCHOOL NAME:${qrResponse.schoolName}");
      qrCode.value = qrResponse.qrCode;
    }
  }

  Future<void> pullRefresh() async {
    getParentDashboard(schoolId.value);
  }

  Future<void> removePushNotification() async {
    print("Delete Device token from server");
    var response = await BaseClient()
        .get(
            ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.userDeleteDeviceInfo}'
            '?roleId=${roleId.value}&schoolId=${schoolId.value}')
        .catchError(handleError);
    if (response != null) {
      print(response);
    }
  }

  void changePasswordAPICall(
      String currentPassword, String newPassword, BuildContext context) async {
    var param = {
      "currentPassword": currentPassword,
      "newPassword": newPassword
    };
    showLoading();
    print("PASSWORD PARAM ==>$param");
    var response = await BaseClient()
        .patch(ApiEndPoints.devBaseUrl, ApiEndPoints.changePassword, param)
        .catchError(handleError);
    if (response != null) {
      print("RESPONSE CHANGED PASSWORD :${response.toString()}");
      hideLoading();
      messageToastSuccess(context, "", "Password Changed Successfully");
      Future.delayed(const Duration(seconds: 2), () async {
        await removePushNotification();
        storageBox.erase();
        SocketServer.instance!.socket.close();
        Get.offAllNamed(AppRoute.login);
      });
    } else {
      isError.value = false;
    }
    update();
  }
}

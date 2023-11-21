import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:preto3/components/custom_dialog.dart';
import 'package:preto3/controller/base_controller.dart';
import 'package:preto3/model/dashboard_categories_model.dart';
import 'package:preto3/model/gender_model.dart';
import 'package:preto3/model/google_place_model.dart';
import 'package:preto3/model/language_model.dart';
import 'package:preto3/model/qr_code_code.dart';
import 'package:preto3/model/staff/staff_dashboard_model.dart';
import 'package:preto3/model/staff/staff_detail_model.dart';
import 'package:preto3/network/api_end_points.dart';
import 'package:preto3/network/base_client.dart';
import 'package:preto3/utils/app_assets.dart';
import 'package:preto3/utils/app_color.dart';
import 'package:preto3/utils/app_keys.dart';
import 'package:preto3/utils/app_string.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

import '../../components/update_alertbox.dart';
import '../../network/socket_server.dart';
import '../../utils/app_routes.dart';
import '../../utils/toast.dart';

class StaffDashboardController extends GetxController with BaseController {
  final storageBox = GetStorage();
  dynamic argumentData = Get.arguments;
  var staffScaffoldKey = GlobalKey<ScaffoldState>();
  var logedOut = false.obs;

  var refreshController = RefreshController();

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
  FocusNode passwordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();

  var isPasswordFocused = false.obs;
  var isNewPasswordFocused = false.obs;
  var isConfirmPasswordFocused = false.obs;

  var newPasswordController = TextEditingController();
  var cPasswordController = TextEditingController();
  var passwordController = TextEditingController();
  var currentPassword = "".obs;
  var newPassword = "".obs;
  var isPasswordValid = false;
  var isNewPasswordValid = false;
  var isCPasswordValid = false;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();

  var profilePic = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
  var addressName = "".obs;
  var dob = "".obs;
  var city = "".obs;
  var state = "".obs;
  var country = "".obs;
  var joiningDate = "".obs;

  var isFirstnameValid = false;
  var isLastnameValid = false;
  var isPhoneValid = false;
  var isPostalCodeValid = false;
  var isAddressValid = false;

  var qrCode = "".obs;

  var selectedImagePath = ''.obs;
  var selectedFileName = ''.obs;

  var genderIndex = 0.obs;

  var userId = 0.obs;
  var roleId = 0.obs;
  var schoolId = 0.obs;
  var inTime = 0.obs;
  var outTime = 0.obs;
  var totalHour = "".obs;
  var totalStudents = 0.obs;
  var studentIn = 0.obs;
  var studentAbsent = 0.obs;
  var eventCount = 0.obs;

  LanguageModel? language;

  var langId = 0.obs;
  var selectedLang = "".obs;
  var isAllAbsent = false.obs;
  var salaried = false.obs;
  var active = false.obs;

  var formattedInTime = "".obs;
  var formattedOutTime = "".obs;

  var staffRoomList = <RoomDetail>[].obs;
  var classRoomList = <ClassRoomDetail>[].obs;
  var emergencyContactList = <StaffEmergencyContactDetail>[].obs;
  final languageList = <LanguageList>[].obs;
  final allLanguageList = <LanguageModel>[].obs;
  final selectedLanguageIdList = <int?>[].obs;
  final selectedLanguageList = <String?>[].obs;

  var placeList = <Prediction>[].obs;

  StaffPersonalDetails? staffPersonalDetails;

  Placemark pickPlaceMark = Placemark();
  Placemark get getPlaceMark => pickPlaceMark;

  var searchPlacesController = TextEditingController();
  var predictionList = <Prediction>[].obs;
  var placeName = "".obs;
  var postalCode = "".obs;

  @override
  void onInit() {
    refreshController = RefreshController(initialRefresh: false);
    roleId.value = storageBox.read(AppKeys.keyRoleId);
    schoolId.value = storageBox.read(AppKeys.keySchoolId);
    userId.value = storageBox.read(AppKeys.keyId);
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    cPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    getStaffDashboard(schoolId.value);
    getStaffDetails(userId.value, schoolId.value);
    getQrCode(schoolId.value, roleId.value);

    Future.delayed(const Duration(seconds: 30), () {
      UpdateAlert.updateAlertBox();
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
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

  void openDrawer() {
    staffScaffoldKey.currentState!.openDrawer();
    update();
  }

  void closeDrawer() {
    staffScaffoldKey.currentState!.closeDrawer();
    update();
  }

  void changeGender(int index) {
    genderIndex.value = index;
    update();
  }

  void onRefresh() async {
    // monitor network fetch
    try {
      getStaffDashboard(schoolId.value);
      getStaffDetails(userId.value, schoolId.value);
      getQrCode(schoolId.value, roleId.value);
      isError.value = false;
    } catch (e) {
      log(e.toString());
    }
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
    update();
  }

  List<GenderModel> genderList = [
    GenderModel(name: AppString.boy),
    GenderModel(name: AppString.girl),
    GenderModel(name: AppString.other),
  ];

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

  void setLanguage(LanguageModel languageModel) {
    language = languageModel;
    langId.value = languageModel.id;
    selectedLang.value = languageModel.name.toString();
    addLanguages(selectedLang.value, langId.value);
    update();
  }

  List<DashboardCategoriesModel> dashboardCategory = [
    DashboardCategoriesModel(
        name: AppString.studentCheckIn,
        assetImage: AppAssets.dashboardCheckIn,
        colors: AppColor.dashCheckInText,
        bgColors: AppColor.dashCheckInBg),
    DashboardCategoriesModel(
        name: AppString.communication,
        assetImage: AppAssets.dashboardComm,
        colors: AppColor.dashCommText,
        bgColors: AppColor.dashCommBg),
    DashboardCategoriesModel(
      name: AppString.events,
      subtitle: "0 Events",
      assetImage: AppAssets.dashboardEvent,
      colors: AppColor.dashRoomText,
      bgColors: AppColor.dashRoomBg,
    ),
    DashboardCategoriesModel(
        name: AppString.dailyActivities,
        assetImage: AppAssets.dashboardDailyActivities,
        colors: AppColor.dashFeesText,
        bgColors: AppColor.dashFeesBg),
    DashboardCategoriesModel(
        name: AppString.schedule,
        assetImage: AppAssets.dashboardSchedule,
        colors: AppColor.dashStaffScheduleText,
        bgColors: AppColor.dashStaffScheduleBg),
  ];

  void addLanguages(String name, int id) {
    selectedLanguageIdList.add(id);
    selectedLanguageList.add(name);
    update();
  }

  void removeLanguages(String name, int id) {
    selectedLanguageIdList.remove(id);
    selectedLanguageList.remove(name);
    update();
  }

  void getStaffDashboard(
    int schoolId,
  ) async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.staffDashboard}' '?schoolId=$schoolId')
        .catchError(handleError);
    if (response == null) {
      hideLoading();
    } else {
      isOnline.value = true;
      var dashResponse =
          StaffDashboardModel.fromJson(jsonDecode(response.toString()));
      firstName.value = dashResponse.staffFirstName;
      lastName.value = dashResponse.staffLastName;
      eventCount.value = dashResponse.eventCount;
      staffRoomList.value = dashResponse.roomDetails;
      if (dashResponse.staffCheckInoutdata.inTime != "-") {
        inTime.value = dashResponse.staffCheckInoutdata.inTime;
        formattedInTime.value = DateFormat('hh:mm a')
            .format(DateTime.fromMillisecondsSinceEpoch(inTime.value))
            .toString();
      }
      if (dashResponse.staffCheckInoutdata.outTime != "-") {
        outTime.value = dashResponse.staffCheckInoutdata.outTime;
        formattedOutTime.value = DateFormat('hh:mm a')
            .format(DateTime.fromMillisecondsSinceEpoch(outTime.value))
            .toString();
        totalHour.value = dashResponse.staffCheckInoutdata.totalHour;
        storageBox.write(AppKeys.keyParentProfileURL, dashResponse.profilePic);
        storageBox.write(AppKeys.keyCheckInOutPin, dashResponse.checkInOutPin);
      }
      hideLoading();
      update();
    }
  }

  void getStaffDetails(int userId, int schoolId) async {
    try {
      var response = await BaseClient()
          .get(
              ApiEndPoints.devBaseUrl,
              '${ApiEndPoints.staffDetails}'
              '?userId=$userId&schoolId=$schoolId')
          .catchError(handleError);
      if (response != null) {
        var staffResponse = staffDetailModelFromJson(response);
        staffPersonalDetails = staffResponse.staffPersonalDetails;
        firstNameController.text = staffResponse.staffPersonalDetails.firstName;
        lastNameController.text = staffResponse.staffPersonalDetails.lastName;
        phoneController.text = staffResponse.staffContactDetails.phoneNumber;
        firstName.value = staffResponse.staffPersonalDetails.firstName;
        lastName.value = staffResponse.staffPersonalDetails.lastName;
        phone.value = staffResponse.staffContactDetails.phoneNumber;
        email.value = staffResponse.staffContactDetails.emailId;
        dob.value = staffResponse.staffPersonalDetails.birthDate;
        profilePic.value = staffResponse.staffPersonalDetails.profilePic;
        addressController.text =
            staffResponse.staffContactDetails.addressLine.isNotEmpty
                ? staffResponse.staffContactDetails.addressLine
                : "";
        countryController.text =
            staffResponse.staffContactDetails.country.isNotEmpty
                ? staffResponse.staffContactDetails.country
                : storageBox.read(AppKeys.keyCountry);
        stateController.text =
            staffResponse.staffContactDetails.state.isNotEmpty
                ? staffResponse.staffContactDetails.state
                : storageBox.read(AppKeys.keyState);
        cityController.text = staffResponse.staffContactDetails.city.isNotEmpty
            ? staffResponse.staffContactDetails.city
            : storageBox.read(AppKeys.keyCity);
        if (staffResponse.staffEmploymentDetails.hireDate != 0) {
          var date = DateTime.fromMicrosecondsSinceEpoch(
              staffResponse.staffEmploymentDetails.hireDate * 1000);
          joiningDate.value = DateFormat('MM/dd/yyyy').format(date).toString();
        } else {
          joiningDate.value = "-";
        }
        classRoomList.value = staffResponse.staffEmploymentDetails.roomDetails;
        salaried.value = staffResponse.staffEmploymentDetails.salaried;
        emergencyContactList.value = staffResponse.staffEmergencyContactDetails;
        languageList.value = staffResponse.staffPersonalDetails.languageList;
        update();
      }
    } catch (e) {
      log("Exception:${e.toString()}");
    }
  }

  void getLanguages() async {
    showLoading('');
    var response = await BaseClient()
        .get(ApiEndPoints.devBaseUrl, ApiEndPoints.getAllLanguages)
        .catchError(handleError);
    if (response != null) {
      isOnline.value = true;
      allLanguageList.value = languageModelFromJson(response);
      hideLoading();
      update();
    }
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
    getStaffDashboard(schoolId.value);
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedFileName.value =
          firstNameController.text + userId.value.toString();
      print("FILE NAME ${selectedFileName}");
    } else {
      Get.snackbar("Error", "No Image Selected",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void deleteEmergencyContact(
      int userId, int emergencyContactId, roleId) async {
    var response = await BaseClient()
        .delete(ApiEndPoints.devBaseUrl,
            '${ApiEndPoints.deleteStaffEmergencyContact}?userId=$userId&emergencyContactId=$emergencyContactId&roleId=$roleId')
        .catchError(handleError);
    if (response != null && response != "") {
      Get.dialog(CustomDialog(
        message: "Staff deleted successfully",
        roleId: roleId,
      ));
    }
  }

  Future<List<Prediction>> searchPlaces(
      BuildContext context, String queryText) async {
    print("QUERY TEXT:$queryText");
    String type = 'address';
    if (queryText.isNotEmpty) {
      predictionList.clear();
      var response = await http.get(Uri.parse(
          '${ApiEndPoints.googlePlaceUrl}${ApiEndPoints.autoCompleteSearch}input=$queryText&types=$type&key=${ApiEndPoints.googleTimeZoneApiKey}'));
      print("RESPONSE:$response");
      var data = googlePlaceModelFromJson(response.body.toString());
      if (data.status == "OK") {
        print("STATUS ${data.status}");
        predictionList.value = data.predictions;

        update();
      }
    }
    return predictionList;
  }

  void getLatLon(String selectedAddress) async {
    List<Location> locations = await locationFromAddress(selectedAddress);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        locations.first.latitude, locations.first.longitude);
    placeName.value = selectedAddress;
    state.value = placemarks.last.administrativeArea.toString();
    city.value = placemarks.last.locality.toString();
    postalCode.value = placemarks.last.postalCode.toString();
    country.value = placemarks.last.country.toString();
    addressController.text = placeName.value;
    cityController.text = city.value;
    stateController.text = state.value;
    countryController.text = country.value;
    postalCode.value = postalCode.value;
    storageBox.write(AppKeys.keyCountry, countryController.text);
    storageBox.write(AppKeys.keyState, stateController.text);
    storageBox.write(AppKeys.keyCity, cityController.text);
    print("NAME:${placeName.value}");
    print("POSTAL:${postalCode.value}");
    update();
  }

  void updateStaffProfileSession() {
    showLoading();
    isFirstnameValid = firstNameKey.currentState!.validate();
    isLastnameValid = lastNameKey.currentState!.validate();
    isPhoneValid = phoneKey.currentState!.validate();
    isAddressValid = addressKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (isFirstnameValid && isFirstnameValid) {
      firstNameKey.currentState!.save();
      lastNameKey.currentState!.save();

      log("FIRST NAME ${firstName.value}");
      log("LAST ${lastName.value}");
      updateStaffPersonDetail(schoolId.value, roleId.value, userId.value,
          firstName.value, lastName.value, dob.value);
    }
    if (isPhoneValid && isAddressValid && postalCode.value != null) {
      phoneKey.currentState!.save();
      addressKey.currentState!.save();

      log("PHONE ${phone.value}");
      log("ADDRESS ${addressName.value}");
      log("POSTAL CODE ${postalCode.value}");
      updateStaffContactDetail(schoolId.value, roleId.value, userId.value,
          phone.value, postalCode.value, addressName.value);
    }
  }

  void updateStaffPersonDetail(
    schoolId,
    roleId,
    userId,
    firstname,
    lastname,
    dob,
  ) async {
    var param = {
      "schoolId": schoolId,
      "roleId": roleId,
      "id": userId,
      "firstName": firstname,
      "lastName": lastname,
      "dob": dob,
      "languageId": [15, 25]
    };

    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.updateStaffPersonalDetails,
            param)
        .catchError(handleError);
    if (response != null && response != "") {}
  }

  void updateStaffContactDetail(
      schoolId, roleId, userId, phone, zipcode, addressLine) async {
    var param = {
      "schoolId": schoolId,
      "roleId": roleId,
      "id": userId,
      "phoneNumber": phone,
      "zipCode": zipcode,
      "addressLine": addressLine
    };
    print("CONTACT PARAM:$param");
    var response = await BaseClient()
        .post(ApiEndPoints.devBaseUrl, ApiEndPoints.updateStaffContactDetails,
            param)
        .catchError(handleError);
    if (response != null && response != "") {
      print("CONTACT DETAILS UPDATED");
      hideLoading();
    }
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

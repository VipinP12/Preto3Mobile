import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolSettingController extends GetxController{
final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
   final ssnEinController = TextEditingController();
  final enrollmentController = TextEditingController();
  final websiteController = TextEditingController();
  final schoolNameController = TextEditingController();
final schoolTypeController = TextEditingController();
final addressController = TextEditingController();
  final facilityController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final timeZoneController = TextEditingController();
  final selectedStartTimeController=TextEditingController ();
 final  selectedEndTimeController=TextEditingController();


  final emailError = RxString('');
  final phoneError = RxString('');
  final ssnEinError = RxString('');
  final enrollmentCapacityError = RxString('');
  final schoolWebsiteError = RxString('');
  final addressError = RxString('');
  final facilityError = RxString('');
  final countryError = RxString('');
  final cityError = RxString('');
  final stateError = RxString('');
  final timeZoneError = RxString('');


  Rx<TimeOfDay> selectedStartTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> selectedEndTime = TimeOfDay.now().obs;

  SchoolSettingController() {
    initialize();
  }

  String getTime(TimeOfDay time) {
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final formattedHour = hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$formattedHour:$minute $period';
  }

  void initialize() {
 selectedStartTimeController.text = getTime(selectedStartTime.value);
    selectedEndTimeController.text = getTime(selectedEndTime.value);
  }

Future<void> selectStartTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedStartTime.value,
    );
    if (newTime != null) {
      selectedStartTime.value = newTime;
      selectedStartTimeController.text = getTime(newTime);
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: selectedEndTime.value,
    );
    if (newTime != null) {
      selectedEndTime.value = newTime;
      selectedEndTimeController.text = getTime(newTime);
    }
  }


  // Validation for School Name
  String? validateSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return 'School Name is required';
    }
    return null;
  }

  // Validation for School Type
  String? validateSchoolType(String? value) {
    if (value == null || value.isEmpty) {
      return 'School Type is required';
    }
    return null;
  }

  // Validation for Email
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validation for Phone Number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    } else if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Validation for SSN or EIN Number
String? validateSsnEin(String? value) {
  if (value == null || value.isEmpty) {
    return 'SSN/EIN is required';
  } else if (value.length == 9) {
    if (!RegExp(r'^\d{2}-\d{7}$').hasMatch(value)) {
      return 'Enter a valid SSN/EIN (e.g., 123-45-6789 or 12-3456789)';
    }
  } else if (value.length == 11) {
    if (!RegExp(r'^\d{3}-\d{2}-\d{4}$').hasMatch(value)) {
      return 'Enter a valid SSN/EIN (e.g., 123-45-6789 or 12-3456789)';
    }
  } else {
    return 'Enter a valid SSN/EIN (e.g., 123-45-6789 or 12-3456789)';
  }
  return null;
}


  // Validation for Enrollment Capacity
  String? validateEnrollment(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enrollment Capacity is required';
    } else if (int.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    return null;
  }

  // Validation for School Website
  String? validateSchoolWebsite(String? value) {
    if (value == null || value.isEmpty) {
      return 'School Website is required';
    } else if (!GetUtils.isURL(value)) {
      return 'Enter a valid website';
    }
    return null;
  }

String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the school address';
    }
    // Additional validation logic for the address, if required
    return null;
  }

  String? validateFacility(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the facility';
    }
    // Additional validation logic for the facility, if required
    return null;
  }

  String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the country';
    }
    // Additional validation logic for the country, if required
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the city';
    }
    // Additional validation logic for the city, if required
    return null;
  }

  String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the state';
    }
    // Additional validation logic for the state, if required
    return null;
  }

  String? validateTimeZone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the time zone';
    }
    // Additional validation logic for the time zone, if required
    return null;
  }



  void saveSettingDetails() {
    final schoolNameValid = validateSchoolName(schoolNameController.text); 
    final schoolTypeValid = validateSchoolType(schoolTypeController.text); 
    final emailValid = validateEmail(emailController.text);
    final phoneValid = validatePhoneNumber(phoneNumberController.text);
    final ssnEinValid = validateSsnEin(ssnEinController.text); 
    final enrollmentCapacityValid = validateEnrollment(enrollmentController.text); 
    final schoolWebsiteValid = validateSchoolWebsite(websiteController.text);
    final addressValid=validateAddress(addressController.text);
    final facilityValid=validateFacility(facilityController.text);
    final countryValid=validateCountry(countryController.text);
    final stateValid=validateState(stateController.text);
    final cityValid=validateCity(cityController.text);
    final timeZoneValid=validateTimeZone(timeZoneController.text);

    emailError.value = emailValid ?? '';
    phoneError.value = phoneValid ?? '';
    ssnEinError.value = ssnEinValid ?? '';
    enrollmentCapacityError.value = enrollmentCapacityValid ?? '';
    schoolWebsiteError.value = schoolWebsiteValid ?? '';
    addressError.value = addressValid ?? '';
    facilityError.value = facilityValid ?? '';
    countryError.value = countryValid?? '';
    cityError.value = cityValid ??'';
    stateError.value = stateValid ??'';
    timeZoneError.value = timeZoneValid ?? '';

    if (formKey.currentState!.validate()) {
      if (schoolNameValid == null &&
          schoolTypeValid == null &&
          emailValid == null &&
          phoneValid == null &&
          ssnEinValid == null &&
          enrollmentCapacityValid == null &&
          schoolWebsiteValid == null && 
          addressValid==null && 
          facilityValid==null&& 
          countryValid==null&& 
          stateValid==null&& 
          cityValid==null && 
          timeZoneValid==null) {
        // Rest of the saving logic
      }
    }
  }
}
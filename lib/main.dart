import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:preto3/binding/Admin/Room/manage_creative_class_settings_binding.dart';
import 'package:preto3/binding/Parent/AuthorizePikupBinding/authorize_pickup_binding.dart';
import 'package:preto3/binding/Parent/AuthorizePikupBinding/update_authorize_pickup_binding.dart';
import 'package:preto3/binding/Parent/parent_student_details_binding.dart';
import 'package:preto3/binding/Staff/edit_checkin_binding.dart';
import 'package:preto3/binding/Staff/staff_dashboard_binding.dart';
import 'package:preto3/binding/Staff/staff_student_detail_binding.dart';
import 'package:preto3/binding/TimeClock/time_clock_binding.dart';
import 'package:preto3/binding/create_group_binding.dart';
import 'package:preto3/binding/daily_activity_binding.dart';
import 'package:preto3/binding/daily_detail_binding.dart';
import 'package:preto3/binding/event_binding.dart';
import 'package:preto3/binding/reset_password_binding.dart';
import 'package:preto3/binding/scanner_binding.dart';
import 'package:preto3/components/admin_deshboard_page.dart';
import 'package:preto3/components/coming_soon_page.dart';
import 'package:preto3/service/local_notification_service.dart';
import 'package:preto3/utils/app_routes.dart';
import 'package:preto3/binding/chat_binding.dart';
import 'package:preto3/binding/check_in_binding.dart';
import 'package:preto3/binding/communication_binding.dart';
import 'package:preto3/binding/Admin/dashboard_binding.dart';
import 'package:preto3/binding/fees_binding.dart';
import 'package:preto3/binding/forgot_password_binding.dart';
import 'package:preto3/binding/login_binding.dart';
import 'package:preto3/binding/onboarding_binding.dart';
import 'package:preto3/binding/Parent/parent_dashboard_binding.dart';
import 'package:preto3/binding/profile_student_binding.dart';
import 'package:preto3/binding/room_binding.dart';
import 'package:preto3/binding/room_selected_binding.dart';
import 'package:preto3/binding/school_setting_binding.dart';
import 'package:preto3/binding/select_role_binding.dart';
import 'package:preto3/binding/sign_up_binding.dart';
import 'package:preto3/binding/splash_binding.dart';
import 'package:preto3/binding/student_binding.dart';
import 'package:preto3/view/AdminModule/Rooms/manage_creative_class_settings.dart';
import 'package:preto3/view/AdminModule/add_parent.dart';
import 'package:preto3/view/AdminModule/admin_staff_profile.dart';
import 'package:preto3/view/AdminModule/drawer/authorize_pickup_view/authorize_pickup_detail.dart';
import 'package:preto3/view/AdminModule/drawer/authorize_pickup_view/authorize_pickup_page.dart';
import 'package:preto3/view/AdminModule/drawer/schedule_view/admin_shedule_page.dart';
import 'package:preto3/view/AdminModule/edit_admin_profile.dart';
import 'package:preto3/view/AdminModule/dashboard_staff.dart';
import 'package:preto3/view/AdminModule/new_student_add.dart';
import 'package:preto3/view/CommunicationModule/chat_page.dart';
import 'package:preto3/view/CommunicationModule/create_group_for_%20both.dart';
import 'package:preto3/view/CommunicationModule/create_group_for_both_preview.dart';
import 'package:preto3/view/CommunicationModule/create_group_preview_page.dart';
import 'package:preto3/view/CommunicationModule/parent_communication_page.dart';
import 'package:preto3/view/CommunicationModule/parent_create_staff_group.dart';
import 'package:preto3/view/CommunicationModule/staff_create_staff_group.dart';
import 'package:preto3/view/CommunicationModule/staff_create_student_group.dart';
import 'package:preto3/view/CommunicationModule/staff_or_admin_create_group.dart';
import 'package:preto3/view/ParentModule/AuthorizePickup/authorize_pickup_create.dart';
import 'package:preto3/view/ParentModule/AuthorizePickup/authorize_pickup_list.dart';
import 'package:preto3/view/ParentModule/AuthorizePickup/update_authorize_pickup_page.dart';
import 'package:preto3/view/ParentModule/DrawerPage/check_in_out_page.dart';
import 'package:preto3/view/ParentModule/FeesModule/PaymentSection/add_payment_method_option.dart';
import 'package:preto3/view/ParentModule/FeesModule/PaymentSection/final_payment_details_page.dart';
import 'package:preto3/view/ParentModule/FeesModule/fees_top_tab.dart';
import 'package:preto3/view/ParentModule/FeesModule/invoice_sort_discription_page.dart';
import 'package:preto3/view/ParentModule/FeesModule/view_invoice_page.dart';
import 'package:preto3/view/ParentModule/check_in_out_page.dart';
import 'package:preto3/view/ParentModule/children_profile_page.dart';
import 'package:preto3/view/ParentModule/edit_parent_profile.dart';
import 'package:preto3/view/ParentModule/parent_student_details_page.dart';
import 'package:preto3/view/StaffModule/add_emergency_contacts.dart';
import 'package:preto3/view/StaffModule/check_list_page.dart';
import 'package:preto3/view/StaffModule/class_room_page.dart';
import 'package:preto3/view/StaffModule/edit_check_in_page.dart';
import 'package:preto3/view/StaffModule/edit_staff_profile.dart';
import 'package:preto3/view/StaffModule/staff_detail_page.dart';
import 'package:preto3/view/TimeClockModule/check_in_child_page.dart';
import 'package:preto3/view/TimeClockModule/qrcode_page.dart';
import 'package:preto3/view/TimeClockModule/time_clock_scanner_page.dart';

import 'package:preto3/view/StaffModule/check_in_page.dart';
import 'package:preto3/view/ParentModule/parent_dashboard_page.dart';
import 'package:preto3/view/AdminModule/school_admin_dashboard_page.dart';
import 'package:preto3/view/daily_activities_details_page.dart';
import 'package:preto3/view/daily_activities_page.dart';
import 'package:preto3/view/daily_activity_add_page.dart';
import 'package:preto3/view/daily_activity_select_student.dart';
import 'package:preto3/view/daily_activity_set_time.dart';
import 'package:preto3/view/event_details.dart';
import 'package:preto3/view/event_page.dart';
import 'package:preto3/view/forgot_password_page.dart';
import 'package:preto3/view/login_page.dart';
import 'package:preto3/view/onboarding_page.dart';
import 'package:preto3/view/profile_student_page.dart';
import 'package:preto3/view/qr_scanner_page.dart';
import 'package:preto3/view/reset_password_page.dart';
import 'package:preto3/view/room_page.dart';
import 'package:preto3/view/room_selected_page.dart';
import 'package:preto3/view/school_setting_page.dart';
import 'package:preto3/view/select_role_page.dart';
import 'package:preto3/view/sign_up_form_page.dart';
import 'package:preto3/view/sign_up_page.dart';
import 'package:preto3/view/sign_up_school_page.dart';
import 'package:preto3/view/splash_page.dart';
import 'package:preto3/view/student_detail_page.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'binding/Admin/add_new_profile_binding.dart';
import 'binding/Admin/admin_schedule_binding.dart';
import 'binding/Admin/admin_staff_profile_binding.dart';
import 'binding/Admin/authorize_pickup_binding.dart';
import 'binding/Admin/dashboard_staff_binding.dart';
import 'binding/Bank/add_bank_atmcard_binding.dart';
import 'binding/Bank/bank_card_details_binding.dart';
import 'binding/Parent/AuthorizePikupBinding/authorize_pickup_create_binding.dart';
import 'binding/Parent/DrawerScreenBinding/check_in_out_binding.dart';
import 'binding/Parent/invoice_details_binding.dart';
import 'binding/Parent/view_invoice_binding.dart';
import 'binding/Staff/add_emergency_binding.dart';
import 'binding/event_details_binding.dart';
import 'view/CommunicationModule/communcation_page.dart';
import 'view/StaffModule/staff_dashboard_page.dart';
import 'view/StaffModule/student_profile_details.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  LocalNotificationService.initialize();

  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.

// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PreTo3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: AppRoute.splash,
      getPages: [
        GetPage(
            name: AppRoute.splash,
            page: () => SplashPage(),
            binding: SplashBinding()),
        GetPage(
            name: AppRoute.onBoarding,
            page: () => OnBoardingPage(),
            binding: OnBoardingBinding()),
        GetPage(
            name: AppRoute.login,
            page: () => LoginPage(),
            binding: LoginBinding()),
        GetPage(
            name: AppRoute.selectRole,
            page: () => SelectRolePage(),
            binding: SelectRoleBinding()),
        GetPage(
            name: AppRoute.forgotPassword,
            page: () => ForgotPasswordPage(),
            binding: ForgotPasswordBinding()),
        GetPage(
            name: AppRoute.signUp,
            page: () => SignUpPage(),
            binding: SignUpBinding()),
        GetPage(
            name: AppRoute.signUpSchool,
            page: () => SignUpSchoolPage(),
            binding: SignUpBinding()),
        GetPage(
            name: AppRoute.signUpForm,
            page: () => SignUpFormPage(),
            binding: SignUpBinding()),
        GetPage(
            name: AppRoute.dashboard,
            page: () => DashboardPage(),
            binding: DashboardBinding()),
        GetPage(
            name: AppRoute.students,
            page: () => StudentDetailPage(),
            binding: StudentBinding()),
        GetPage(
            name: AppRoute.adminDashboardStaff,
            page: () => AdminDashboardStaff(),
            binding: AdminDashboardStaffBinding()),
        GetPage(
            name: AppRoute.room,
            page: () => RoomPage(),
            binding: RoomBinding()),
        GetPage(
            name: AppRoute.roomSelect,
            page: () => RoomSelectedPage(),
            binding: RoomSelectedBinding()),
        GetPage(
            name: AppRoute.studentProfile,
            page: () => ProfileStudentPage(),
            binding: ProfileStudentBinding()),
        GetPage(
            name: AppRoute.checkIn,
            page: () => CheckInPage(),
            binding: CheckInBinding()),
        GetPage(
            name: AppRoute.communication,
            page: () => CommunicationPage(),
            binding: CommunicationBinding()),
        GetPage(
            name: AppRoute.fees,
            page: () => const FeesTopTab(),
            binding: FeesBinding()),
        GetPage(
            name: AppRoute.schoolSetting,
            page: () => const SchoolSettingPage(),
            binding: SchoolSettingBinding()),
        GetPage(
            name: AppRoute.chat,
            page: () => const ChatPage(),
            binding: ChatBinding()),
        GetPage(
            name: AppRoute.dashboardParent,
            page: () => ParentDashboardPage(),
            binding: ParentDashboardBinding()),
        GetPage(
            name: AppRoute.dashboardStaff,
            page: () => StaffDashboardPage(),
            binding: StaffDashboardBinding()),
        GetPage(
            name: AppRoute.staffDetails,
            page: () => StaffDetailPage(),
            binding: StaffDashboardBinding()),
        GetPage(
            name: AppRoute.addEmergency,
            page: () => AddEmergencyContacts(),
            binding: AddEmergencyBinding()),
        GetPage(
            name: AppRoute.checkIn,
            page: () => CheckInPage(),
            binding: CheckInBinding()),
        GetPage(
            name: AppRoute.checkedInList,
            page: () => CheckListPage(),
            binding: CheckInBinding()),
        GetPage(
            name: AppRoute.editCheckIn,
            page: () => EditCheckInPage(),
            binding: EditCheckInBinding()),
        GetPage(
            name: AppRoute.classRoom,
            page: () => ClassRoomPage(),
            binding: RoomBinding()),
        GetPage(
            name: AppRoute.comingSoon,
            page: () => const ComingSoonPage(),
            binding: OnBoardingBinding()),
        GetPage(
            name: AppRoute.adminDashboardSoon,
            page: () => AdminDashBoardPage(),
            binding: OnBoardingBinding()),
        GetPage(
            name: AppRoute.studentDetails,
            page: () => ParentStudentDetailsPage(),
            binding: ParentStudentDetailsBinding()),
        GetPage(
            name: AppRoute.invoiceSortDescription,
            page: () => InvoiceSortDescription(),
            binding: InvoiceDetailsBinding()),
        GetPage(
            name: AppRoute.addPaymentMethodOption,
            page: () => AddPaymentMethodOption(),
            binding: AddBankAtmCardBinding()),
        GetPage(
            name: AppRoute.finalPaymentDetailsPage,
            page: () => FinalPaymentDetailsPage(),
            binding: BankCardDetailsBinding()),
        GetPage(
            name: AppRoute.viewInvoicePage,
            page: () => ViewInvoicePage(),
            binding: ViewInvoiceBinding()),
        GetPage(
            name: AppRoute.parentCommunicationPage,
            page: () => ParentCommunicationPage(),
            binding: CommunicationBinding()),
        GetPage(
            name: AppRoute.editStaffProfile,
            page: () => EditStaffProfile(),
            binding: StaffDashboardBinding()),
        GetPage(
            name: AppRoute.editParentProfile,
            page: () => EditParentProfile(),
            binding: ParentDashboardBinding()),
        GetPage(
            name: AppRoute.childProfileDetails,
            page: () => ChildrenProfilePage(),
            binding: ProfileStudentBinding()),
        GetPage(
            name: AppRoute.timeClock,
            page: () => TimeClockScanner(),
            binding: TimeClockBinding()),
        GetPage(
            name: AppRoute.scanQRPage,
            page: () => QrcodePage(),
            binding: TimeClockBinding()),
        GetPage(
            name: AppRoute.checkInChild,
            page: () => CheckInChildPage(),
            binding: TimeClockBinding()),
        GetPage(
            name: AppRoute.createStaffGroup,
            page: () => CreateStaffGroup(),
            binding: ParentDashboardBinding()),
        GetPage(
            name: AppRoute.scannerPage,
            page: () => QrScannerPage(),
            binding: ScannerBinding()),
        GetPage(
            name: AppRoute.createStaffAdminGroup,
            page: () => StaffAdminCreateGroup(),
            binding: CommunicationBinding()),
        GetPage(
            name: AppRoute.createStudentGroup,
            page: () => CreateStudentGroup(),
            binding: CommunicationBinding()),
        GetPage(
            name: AppRoute.staffCreateStudentGroup,
            page: () => StaffCreateStaffGroup(),
            binding: CommunicationBinding()),
        GetPage(
            name: AppRoute.createGroupPreview,
            page: () => CreateGroupPreviewPage(),
            binding: CommunicationBinding()),
        GetPage(
            name: AppRoute.createGroup,
            page: () => CreateGroupForBoth(),
            binding: CreateGroupBinding()),
        GetPage(
            name: AppRoute.resetPassword,
            page: () => ResetPasswordPage(),
            binding: ResetPasswordBinding()),
        GetPage(
            name: AppRoute.childrenCheckInOut,
            page: () => CheckInOutPage(),
            binding: ScannerBinding()),
        GetPage(
            name: AppRoute.authorizePikupList,
            page: () => AuthorizePikupList(),
            binding: AuthorizePikupBinding()),
        GetPage(
            name: AppRoute.authorizePickupCreate,
            page: () => AuthorizePickupCreate(),
            binding: AuthorizePikupCreateBinding()),
        GetPage(
            name: AppRoute.checkInOutPage,
            page: () => CheckInOutParentPage(),
            binding: CheckInOutBinding()),
        GetPage(
            name: AppRoute.updateAuthorizePickup,
            page: () => UpdateAuthorizePickupPage(),
            binding: UpdateAuthorizePikupBinding()),
        GetPage(
            name: AppRoute.event,
            page: () => EventPage(),
            binding: EventBinding()),
        GetPage(
            name: AppRoute.adminAuthorizePickup,
            page: () => AdminAuthorizePickUp(),
            binding: AuthorizePickUPBinding()),
        GetPage(
            name: AppRoute.adminSchedule,
            page: () => AdminSchedule(),
            binding: AdminScheduleBinding()),
        GetPage(
            name: AppRoute.adminAuthorizePickupDetail,
            page: () => AuthorizePickUpDetail(),
            binding: AuthorizePickUPBinding()),
        GetPage(
            name: AppRoute.eventDetails,
            page: () => EventDetails(),
            binding: EventDetailsBinding()),
        GetPage(
            name: AppRoute.dailyActivity,
            page: () => DailyActivities(),
            binding: DailyActivityBinding()),
        GetPage(
            name: AppRoute.dailActivityDetails,
            page: () => DailyActivitiesDetailsPage(),
            binding: DailyDetailBinding()),
        GetPage(
            name: AppRoute.addDailActivity,
            page: () => DailyActivityAddPage(),
            binding: DailyActivityBinding()),
        GetPage(
            name: AppRoute.createGroupForBothPreview,
            page: () => CreateGroupForBothPreview(),
            binding: CreateGroupBinding()),
        GetPage(
            name: AppRoute.selectStudentForActivity,
            page: () => DailyActivitySelectStudent(),
            binding: DailyActivityBinding()),
        GetPage(
            name: AppRoute.setTimeActivity,
            page: () => DailyActivitySetTime(),
            binding: DailyActivityBinding()),
        GetPage(
            name: AppRoute.studentProfileDetails,
            page: () => StudentProfileDetails(),
            binding: StaffStudentDetailBinding()),
        GetPage(
            name: AppRoute.editAdminProfile,
            page: () => EditAdminProfile(),
            binding: OnBoardingBinding()),
        GetPage(
            name: AppRoute.adminStaffProfile,
            page: () => const AdminStaffProfile(),
            binding: AdminStaffProfileBinding()),
        GetPage(
            name: AppRoute.addStudentsProfile,
            page: () => const AddStudentsProfile(),
            binding: AddNewProfileBinding()),
        GetPage(
          name: AppRoute.addPrimaryParent,
          page: () => const AddPrimaryParent(),
          // binding: AddNewProfileBinding()
        ),
        GetPage(
          name: AppRoute.manageCreativeClassSettings,
          page: () =>  ManageCreativeClassSettings(),
           binding: ManageCreativeClassSettingsBinding()
        )
      ],
    );
  }
}

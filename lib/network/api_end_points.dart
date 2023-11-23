class ApiEndPoints {
  //staging
  //static const devBaseUrl = "https://backend-new.preto3.com";
  //prod
  // static const devBaseUrl = "https://api.preto3.com";
  // static const devBaseUrl = "http://192.168.1.57:8082";
  static const devBaseUrl = "http://3.21.186.48:8080/preto3lite";
  static const clientId = "93750";                                                                
  static const socketUrl = "wss://chat.migration.preto3.com:8080/chat/";
  //static const devBaseUrl = "http://192.168.1.6:8082";
  static const plaidURL = "https://sandbox.plaid.com";
  static const googlePlacesApiKey = "AIzaSyCAlkHLmhM5ho_uXEctCkG_hflHmDEJgKY";
  static const googleTimeZoneApiKey = "AIzaSyD4gS9zmlzjKj13_pfUvSNKdwATO_9W7lE";
  static const createLinkToken = "/link/token/create";
  //WE PAY STAGING
  static const wePayStagingURL = "https://stage.wepayapi.com/v2";
  static const plaidClientId = "642d39e7ef73aa0013d50cb1";
  static const plaidClientUsername = "user_good";
  static const plaidSandboxSecretKey = "fa381c2c7bf6e00cf02b1fe5dcbc89";
  static const plaidDevelopmentSecretKey = "4fd68277497f19a26da62f48226b50";

  static const getWePayCreditCard = "/credit_card/create";
  static const getWePayBankCreate = "/bank_account/create";
  //WE PAY PRODUCTION
  //static const wePayProductionURL = "https://wepayapi.com/v2";
  // static const getWepay_credit_card = "https://wepayapi.com/v2/credit_card/create";

  //We Pay url

  //staging
  // static const wePayWebURL =
  //     "https://stage-iframe.wepay.com/paymentMethods/bankAccount?client_id=118866";

  //production
  static const wePayWebURL =
      "https://iframe.wepay.com/paymentMethods/bankAccount?client_id=93750";

  //GOOGLE PLACES API URL;
  static const googlePlaceUrl = "https://maps.googleapis.com/maps/api/place";

  //END POINT
  static const login = "/login";
  static const roles = "/user/roles";
  static const schoolSignUp = "/user/school/signUp";
  static const adminDashboard = "/dashboard/getAdminDashboard";
  static const staffDashboard = "/dashboard/getStaffDashboard";
  static const parentDashboard = "/dashboard/getParentDashboard";
  static const getBirthday = "/dashboard/getBirthdays";
  static const allStudent = "/student/getAllActiveStudentsForCommunication";
  static const allStaff = "/staff/allStaff";
  static const allStaffCommunication = "/staff/allStaffForCommunication";
  static const allStudentCommunication =
      "/student/getAllActiveStudentsForCommunication";
  static const allRoom = "/room/all";
  static const allRoomStudent = "/student/getAllActiveStudents";
  static const allRoomStaff = "/staff/allStaff";
  static const studentProfileDetails = "/student/getStudentDetails";
  static const getUserRace = "/user/getRaceAndEthnicity";
  static const getSchoolProgramme = "/profile/getSchoolProgram";
  static const studentAccounts = "/invoice/studentAccounts";
  static const paymentBank = "/wepay/payment_bank";
  static const creditCard = "/wepay/credit_card";
  static const deleteCreditCard = "/wepay/deleteCreditCard";
  static const getInvoiceDetail = "/invoice/getInvoiceDetail";
  static const updateDefaultPaymentMethod = "/invoice/updateDefaultPaymentMethod";
  static const allStudentByRoom = "/room/getById";
  static const checkList = "/checkInOut/allStudents";
  static const getAllLanguages = "/language/all";
  static const staffDetails = "/staff/getStaffProfileDetails";
  static const forgotPassword = "/user/forgotPassword";
  static const addCheckIn = "/checkInOut/addStudent";
  static const addPaymentCreditCard = "/wepay/paymentmethod/add";
  static const makePayment = "/wepay/checkout";
  static const editStudentCheckInOut = "/checkInOut/editStudentDetails";
  static const parentProfileDetails = "/parent/profileDetails";
  static const parentRelations = "/parent/getRelations";
  static const punchMasterCheckInOut = "/checkInOut/punchMasterCheckInOut";
  static const punchStudentCheckInOut = "/checkInOut/studentCheckInOut";
  static const parentProfileUpdate = "/parent/updateProfile";
  static const qrCode = "/profile/getQRcode";
  static const parentSaveGroup = "/openFireCommunication/saveGroups";
  static const autoCompleteSearch = "/autocomplete/json?";
  static const getGroups = "/openFireCommunication/groups";
  static const multiplePersonCheckInOut =
      "/checkInOut/multiplePersonCheckInOut";
  static const getSchoolJoin = "/user/school/join";
  static const setUserPassword = "/user/setPassword";
  static const getParentMyChildern = "/parent/myChildren";
  static const getaddAuthorizedPickUp = "/addAuthorizedPickUp";
  static const getAllPickUps = "/getAllPickUps";
  static const deletePickUps = "/deletePickUps";
  static const editPickUpDetails = "/editPickUpDetails";
  static const deleteGroups = "/openFireCommunication/deleteGroups";
  static const allEvents = "/event/getEventDetail";
  static const allActivityBySchool = "/activity/getActivityBySchool";
  static const allActivity = "/activity/getActivityDetail";
  static const saveActivity = "/activity/saveOrUpdateActivity";
  static const eventResponse = "/event/respondEvent";
  static const checkInOutParent = "/checkInOut/report/student";
  static const addStaffEmergencyContact =
      "/staff/addUpdateStaffEmergencyContactDetails";
  static const deleteStaffEmergencyContact =
      "/staff/deleteEmergencyContactDetails";
  static const updateStaffPersonalDetails = "/staff/updateStaffPersonalDetails";
  static const updateStaffContactDetails = "/staff/updateStaffContactDetails";
  static const updateStaffEmploymentDetails =
      "/staff/updateStaffEmploymentDetails";
  static const userRegisterDeviceInfo = "/user/registerDeviceInfo";
  static const userDeleteDeviceInfo = "/user/deleteDeviceInfo";
  static const downloadInvoice = "/invoice/downloadInvoice";
  static const changePassword = "/user/resetPassword";
  static const uploadDailyActivityFile = "/file/daily-activity/uploadFile";
  static const uploadCommunicationFile = "/file/communication/uploadFile";
  static const sendPushNotifications =
      "/openFireCommunication/sendPushNotifications";
  //ADMIN
  static const allRoomRatio = "/dashboard/getRoomRatioDashboard?schoolId=1002939&isWebRequest=true&timezone=Asia/Calcutta";
  static const adminProfileDetail = "/profile/adminProfileDetails";
  static const allActiveStaffList = "staff/allStaff";
  // http://192.168.1.57:8082/staff/allStaff?classId=0&isActive=true&schoolId=1002939
}

// MUESTRA DE LOS TOASTS
import 'package:flutter/cupertino.dart';
import 'package:motion_toast/motion_toast.dart';

Future<void> messageToastWarning(BuildContext context, String mensaje) async {
  return MotionToast.warning(
    //title: Text(S.of(context).warning),
    description: Text(mensaje),
    toastDuration: const Duration(seconds: 2),
  ).show(context);
}

// MUESTRA UN TOAST DE SUCCESS
Future<void> messageToastSuccess(
    BuildContext context, String title, String message) async {
  return MotionToast.success(
    title: Text(title),
    description: Text(message),
    toastDuration: const Duration(seconds: 5),
  ).show(context);
}

// // MUESTRA UN TOAST DE ERROR
// Future<void> messageToastError(BuildContext context, String mensaje) async {
//   return MotionToast.error(
//     title: Text(S.of(context).warning),
//     description: Text(mensaje),
//     toastDuration: const Duration(seconds: 5),
//   ).show(context);
// }

// // MUESTRA UN TOAST DE INFO
// Future<void> messageToastInfo(BuildContext context, String mensaje) async {
//   return MotionToast.info(
//     title: Text(S.of(context).warning),
//     description: Text(mensaje),
//     toastDuration: const Duration(seconds: 5),
//   ).show(context);
// }

// // MUESTRA UN TOAST POR UN ERROR 500 DEL SERVER
// Future<void> messageToast500(BuildContext context, String mensaje) async {
//   return MotionToast.error(
//     title: Text(S.of(context).warning),
//     description: Text(mensaje),
//     toastDuration: const Duration(seconds: 6),
//   ).show(context);
// }

// // MUESTRA UN TOAST POR UN ERROR 400 DEL SERVER
// Future<void> messageToast400(BuildContext context, String mensaje) async {
//   return MotionToast.warning(
//     title: Text(S.of(context).warning),
//     description: Text(mensaje),
//     toastDuration: const Duration(seconds: 6),
//   ).show(context);
// }

// // MUESTRA UN TOAST DE SUCCESS
// Future<void> messageToast200(BuildContext context, String mensaje) async {
//   return MotionToast.success(
//     title: Text(S.of(context).success),
//     description: Text(mensaje),
//     toastDuration: const Duration(seconds: 3),
//   ).show(context);
// }

// // MUESTRA UN TOAST DE INFO TARJETA
// Future<void> messageToastInfoTarjeta(
//     BuildContext context, String titulo, String mensaje) async {
//   return MotionToast.info(
//     title: Text(titulo),
//     description: Text(mensaje),
//     toastDuration: const Duration(seconds: 5),
//   ).show(context);
// }

// Future<void> messageToastNotInternetConexion(BuildContext context) async {
//   return GFToast.showToast(S.of(context).thereIsNoInternetConection, context,
//       toastPosition: GFToastPosition.BOTTOM,
//       textStyle: const TextStyle(
//           fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
//       backgroundColor: const Color.fromARGB(255, 27, 27, 27),
//       toastDuration: 4,
//       trailing: const Icon(
//         CupertinoIcons.wifi_slash,
//         color: GFColors.SUCCESS,
//       ));
// }

// Future<void> messageToastInternetConexionTrue(BuildContext context) async {
//   return GFToast.showToast(S.of(context).connectionReestablished, context,
//       toastPosition: GFToastPosition.BOTTOM,
//       textStyle: const TextStyle(
//           fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
//       backgroundColor: const Color.fromARGB(255, 27, 27, 27),
//       toastDuration: 4,
//       trailing: const Icon(
//         CupertinoIcons.wifi,
//         color: GFColors.SUCCESS,
//       ));
// }

import 'package:flutter/material.dart';

dialogTitle(String title, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        IconButton(
          splashRadius: 10,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          tooltip: 'סגור',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
// Future getDialog(BuildContext context, String title, Widget child) {
//   return showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         titlePadding: EdgeInsets.all(0),
//         title: Container(
//           decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//           ),
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 title,
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               IconButton(
//                 splashRadius: 10,
//                 icon: const Icon(
//                   Icons.close,
//                   color: Colors.white,
//                 ),
//                 tooltip: 'סגור',
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(30)),
//         ),
//         content: child,
//       );
//     },
//   );
// }

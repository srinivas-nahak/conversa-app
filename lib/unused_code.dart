// //Trying to change position directly in the json
// Future<Uint8List> _changeAnimPosition({int value = 60}) async {
//   final data = await rootBundle
//       .loadString("assets/animations/moving_circles_brighter.json");
//   final aJson = await jsonDecode(data);
//
//   final position = aJson["layers"][3]["ks"]["p"]["k"];
//   List<dynamic> changedPosition = [];
//
//   for (int i = 0; i < position.length; i++) {
//     num yAxis = position[i];
//     if (i == 1) {
//       yAxis += value;
//     }
//     changedPosition = [...changedPosition, yAxis];
//   }
//
//   aJson["layers"][3]["ks"]["p"]["k"] = changedPosition;
//
//   List<int> list = jsonEncode(aJson).toString().codeUnits;
//   Uint8List bytes = Uint8List.fromList(list);
//   return bytes;
//
///Using Future builder to receive Future values
//   Transform.scale(
//     scale: 1.4,
//     child: FutureBuilder<Uint8List>(
//         future: _changeAnimPosition(value: _animationPosition),
//         builder: (context, snapShot) {
//           if (snapShot.data == null) {
//             return Lottie.asset(
//               "assets/animations/moving_circles_brighter.json",
//             );
//           }
//
//           return Lottie.memory(snapShot.data ?? Uint8List.fromList([]));
//         }),
//   ),
// }

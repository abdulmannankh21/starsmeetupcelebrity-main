//
// @override
// void initState() {
//   super.initState();
//   _init();
// }

// Future<void> _init() async {
//   final audioFile =
//       File(p.join((await getTemporaryDirectory()).path, 'audioFile.mp3'));
//   try {
//     await audioFile.writeAsBytes(
//         (await rootBundle.load('assets/audioFile.mp3')).buffer.asUint8List());
//     final waveFile =
//         File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
//     JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
//         .listen(progressStream.add, onError: progressStream.addError);
//   } catch (e) {
//     progressStream.addError(e);
//   }
// }

// Container(
//   width: MediaQuery.of(context).size.width,
//   height: 70,
//   decoration: BoxDecoration(
//     color: Colors.grey[300],
//     borderRadius: const BorderRadius.only(
//       topRight: Radius.circular(10.0),
//       topLeft: Radius.circular(10.0),
//       bottomLeft: Radius.circular(10.0),
//     ),
//   ),
//   padding: const EdgeInsets.all(15.0),
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     height: 60,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     child: Row(
//       children: [
//         const SizedBox(
//           width: 10,
//         ),
//         Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             shape: BoxShape.circle,
//           ),
//           child: const Center(
//             child: Icon(
//               Icons.play_arrow,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//         ),
//         const SizedBox(
//           width: 15,
//         ),
//         SizedBox(
//           width:
//               MediaQuery.of(context).size.width * 0.5,
//           height: 30,
//           child: StreamBuilder<WaveformProgress>(
//             stream: progressStream,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     'Error: ${snapshot.error}',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 );
//               }
//               final progress =
//                   snapshot.data?.progress ?? 0.0;
//               final waveform =
//                   snapshot.data?.waveform;
//               if (waveform == null) {
//                 return Center(
//                   child: Text(
//                     '${(100 * progress).toInt()}%',
//                     style: const TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 );
//               }
//               return AudioWaveformWidget(
//                 waveform: waveform,
//                 start: Duration.zero,
//                 duration: waveform.duration,
//               );
//             },
//           ),
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//       ],
//     ),
//   ),
// ),

// Container(
//   width: 40,
//   height: 40,
//   decoration: const BoxDecoration(
//       color: purpleColor,
//       shape: BoxShape.circle),
//   child: Center(
//     child: Image.asset(
//       "assets/sendIcon.png",
//       color: Colors.white,
//       width: 30,
//       height: 30,
//     ),
//   ),
// ),
// const SizedBox(
//   width: 15,
// ),

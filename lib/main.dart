import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'src/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    title: 'pendientes: 23',
    // size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,

    // skipTaskbar: false,
    // windowButtonVisibility: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MainApp());
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: const Scaffold(
//         body: ColumnApp(),
//       ),
//     );
//   }
// }

// class ColumnApp extends StatefulWidget {
//   const ColumnApp({super.key});

//   @override
//   State<ColumnApp> createState() => _ColumnAppState();
// }

// class _ColumnAppState extends State<ColumnApp> {
//   TextEditingController textController = TextEditingController();
//   ScrollController scrollController = ScrollController();
//   double cursorPosition = 0.0;

//   List<int> lineNumbers = [1];
//   double textFieldWidth = 0; // Almacena el ancho del TextField

//   void updateText(String newText) {
//     final textSpan = TextSpan(
//       text: newText,
//       style: const TextStyle(
//           fontSize: 14), // Ajusta el tamaño de fuente según tu diseño
//     );

//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//       maxLines: null,
//     );

//     textPainter.layout(
//       minWidth: 0,
//       maxWidth: textFieldWidth, // Usa el ancho del TextField
//     );

//     final lines = textPainter.computeLineMetrics();
//     setState(() {
//       lineNumbers = List<int>.generate(lines.length, (index) => index + 1);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     textController.addListener(updateCursorPosition);
//   }

//   @override
//   void dispose() {
//     textController.removeListener(updateCursorPosition);
//     textController.dispose();
//     super.dispose();
//   }

//   void updateCursorPosition() {
//     final TextPainter painter = TextPainter(
//       text:
//           TextSpan(text: textController.text, style: TextStyle(fontSize: 16.0)),
//       textDirection: TextDirection.ltr,
//     );
//     painter.layout();

//     final double cursorOffset = textController.selection.baseOffset > 0
//         ? painter.width /
//             textController.text.length *
//             textController.selection.baseOffset
//         : 0.0;

//     setState(() {
//       cursorPosition = cursorOffset;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         SingleChildScrollView(
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.start,
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 1, right: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         ...lineNumbers.map(
//                           (e) => Padding(
//                             padding: const EdgeInsets.all(1.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   right: BorderSide(
//                                     color: Colors.amber.withOpacity(0.5),
//                                     width: 1,
//                                   ),
//                                 ),
//                               ),
//                               child: Text(
//                                 '${e.toString()} ',
//                                 style: TextStyle(
//                                     color: Colors.amber.withOpacity(0.5)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 width: size.width - 30,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     LayoutBuilder(
//                       builder: (context, constraints) {
//                         textFieldWidth = constraints.maxWidth -
//                             (size.width *
//                                 0.13); // Actualiza el ancho del TextField
//                         return TextField(
//                           decoration: const InputDecoration(
//                             hintText: 'Ingresa un nuevo texto...',
//                             hintStyle: TextStyle(
//                               color: Colors.white10,
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                                 borderRadius: BorderRadius.only()),
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             // fontSize: 14,
//                           ),
//                           controller: textController,
//                           onChanged: (text) {
//                             updateText(text);
//                           },
//                           maxLines: null,
//                           onSubmitted: (text) {
//                             updateText(text);
//                             textController.clear();
//                           },
//                         );
//                       },
//                     ),
//                     Container(
//                       width: 300.0,
//                       height: 2.0,
//                       color: Colors.blue, // Simula el fondo coloreado
//                       margin: EdgeInsets.only(left: cursorPosition),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               controller: scrollController,
//               itemCount: lineNumbers.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: Text(
//                     lineNumbers[index].toString(),
//                     style: const TextStyle(color: Colors.white10),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         Expanded(
//           // flex: 8,
//           child: SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             controller: scrollController,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     textFieldWidth = constraints.maxWidth -
//                         41; // Actualiza el ancho del TextField
//                     return TextField(
//                       style: const TextStyle(color: Colors.white70),
//                       controller: textController,
//                       onChanged: (text) {
//                         updateText(text);
//                       },
//                       maxLines: null,
//                       onSubmitted: (text) {
//                         updateText(text);
//                         textController.clear();
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: const Scaffold(
//         body: ColumnApp(),
//       ),
//     );
//   }
// }

// class ColumnApp extends StatefulWidget {
//   const ColumnApp({super.key});

//   @override
//   State<ColumnApp> createState() => _ColumnAppState();
// }

// class _ColumnAppState extends State<ColumnApp> {
//   TextEditingController textController = TextEditingController();
//   ScrollController scrollController = ScrollController();

//   List<int> lineNumbers = [1];
//   int cursorLine = 1; // Número de línea donde se encuentra el cursor
//   double textFieldWidth = 0; // Almacena el ancho del TextField

//   void updateText(String newText) {
//     final textSpan = TextSpan(
//       text: newText,
//       style: const TextStyle(
//         fontSize: 14, // Ajusta el tamaño de fuente según tu diseño
//       ),
//     );

//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//       maxLines: null,
//     );

//     textPainter.layout(
//       minWidth: 0,
//       maxWidth: textFieldWidth, // Usa el ancho del TextField
//     );

//     final lines = textPainter.computeLineMetrics();
//     setState(() {
//       lineNumbers = List<int>.generate(lines.length, (index) => index + 1);
//     });
//   }

//   // void updateCursorPosition() {
//   //   final cursorPosition = textController.selection.extentOffset;
//   //   int currentOffset = 0;
//   //   int currentLine = 1;

//   //   for (var line in lineNumbers) {
//   //     if (cursorPosition >= currentOffset &&
//   //         cursorPosition < currentOffset + line) {
//   //       setState(() {
//   //         cursorLine = currentLine;
//   //       });
//   //       break;
//   //     }
//   //     currentOffset += line;
//   //     currentLine++;
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         SingleChildScrollView(
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 1, right: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     ...lineNumbers.map(
//                       (e) => Padding(
//                         padding: const EdgeInsets.all(1.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                               right: BorderSide(
//                                 color: cursorLine == e
//                                     ? Colors.blue
//                                     : Colors.amber.withOpacity(0.5),
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             '${e.toString()} ',
//                             style: TextStyle(
//                               color: cursorLine == e
//                                   ? Colors.blue
//                                   : Colors.amber.withOpacity(0.5),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: size.width - 30,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     LayoutBuilder(
//                       builder: (context, constraints) {
//                         textFieldWidth = constraints.maxWidth -
//                             (size.width *
//                                 0.13); // Actualiza el ancho del TextField
//                         return TextField(
//                           decoration: const InputDecoration.collapsed(
//                             hintText: 'Ingresa un nuevo texto...',
//                             // hintStyle: TextStyle(
//                             //   color: Colors.white10,
//                             // ),
//                             // focusedBorder: UnderlineInputBorder(
//                             //   borderRadius: BorderRadius.only(),
//                             // ),
//                           ),
//                           style: const TextStyle(
//                             color: Colors.white70,
//                           ),
//                           controller: textController,
//                           onChanged: (text) {
//                             var nombre =
//                                 text.replaceAll(RegExp('/[^\r\n]+/g'), '\n');
//                             print(nombre);
//                             updateText(text);
//                             // updateCursorPosition(); // Actualizar la posición al cambiar el texto
//                           },
//                           maxLines: null,
//                           onSubmitted: (text) {
//                             updateText(text);
//                             textController.clear();
//                           },
//                           onTap: () {
//                             // updateCursorPosition();
//                           },
//                           // onSelectionChanged: (selection, cause) {
//                           //   if (cause == SelectionChangedCause.tap) {
//                           //     updateCursorPosition();
//                           //   }
//                           // },
//                           // onChanged: (text) {

//                           // },
//                         );
//                       },
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: HomeWidget(),
//       ),
//     );
//   }
// }

// class HomeWidget extends StatelessWidget {
//   final text =
//       'My text line.\nThis line wraps to the next.\nAnother line.\n\n\nSigo con el textoSigo con el textoSigo con el textoSigo con el textoSigo con el textoSigo con el texto';
//   // MyPainter()..datalist(lista: lista);

//   const HomeWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var data = MyPainter.lista;
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 1,
//             child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text((index + 1).toString()),
//                 );
//               },
//             ),
//           ),
//           CustomPaint(
//             size: const Size(300, 300),
//             painter: MyPainter(text: text),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyPainter extends CustomPainter {
//   // static List<int> datalist({required List<int> lista}) {
//   //   return lista;
//   // }

//   MyPainter({required this.text});
//   final String text;
//   // final text = 'My text line.\nThis كلمة makes more boxes.\nAnother line.\n\n';
//   static List<int> lista = [];

//   final bluePaint = Paint()
//     ..color = Colors.blue
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 1;

//   final redPaint = Paint()
//     ..color = Colors.red
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 1;

//   @override
//   void paint(Canvas canvas, Size size) {
//     const textStyle = TextStyle(
//       color: Colors.black,
//       // fontSize: ,
//     );

//     final textSpan = TextSpan(
//       text: text,
//       style: textStyle,
//     );

//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );


//     textPainter.layout(
//       minWidth: 0,
//       maxWidth: size.width,
//     );

//     const offset = Offset(0, 0);
//     textPainter.paint(canvas, offset);
//     List<ui.LineMetrics> lines = textPainter.computeLineMetrics();
//     for (ui.LineMetrics line in lines) {
//       // print(line.lineNumber);
//       lista.add(line.lineNumber);
//       // print('lista: $lista');
//       // final baseline = line.baseline;
//       // final left = line.left;
//       // final top = line.baseline - line.ascent;
//       // final right = left + line.width;
//       // final bottom = line.baseline + line.descent;
//       // final rect = Rect.fromLTRB(left, top, right, bottom);
//       // canvas.drawLine(
//       //   Offset(left, baseline),
//       //   Offset(right, baseline),
//       //   bluePaint,
//       // );
//       // canvas.drawRect(rect, redPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Columnas Numéricas y de Texto :c')),
//         body: ColumnApp(),
//       ),
//     );
//   }
// }

// class ColumnApp extends StatefulWidget {
//   @override
//   _ColumnAppState createState() => _ColumnAppState();
// }

// class _ColumnAppState extends State<ColumnApp> {
//   TextEditingController textController = TextEditingController();
//   int lineNumber = 1;

//   void updateText(String newText) {
//     setState(() {
//       lineNumber = newText.split('\n').length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: ListView.builder(
//             itemCount: lineNumber,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text((index + 1).toString()),
//               );
//             },
//           ),
//         ),
//         Expanded(
//           flex: 8,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextField(
//                 controller: textController,
//                 onChanged: (text) {
//                   updateText(text);
//                 },
//                 // decoration: InputDecoration(
//                 //   hintText: 'Ingresa un nuevo texto...',
//                 //   contentPadding: EdgeInsets.all(8.0),
//                 // ),
//                 maxLines: null,
//                 // keyboardType: TextInputType.multiline,
//                 // textAlignVertical: TextAlignVertical.top,
//                 onSubmitted: (text) {
//                   updateText(text);
//                   textController.clear();
//                 },
//               ),
              
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }










// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:notepad/src/main_app.dart';

// void main() => runApp(const LogicalKeySetExampleApp());

// class LogicalKeySetExampleApp extends StatelessWidget {
//   const LogicalKeySetExampleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('LogicalKeySet Sample')),
//         body: const Center(
//           child: LogicalKeySetExample(),
//         ),
//       ),
//     );
//   }
// }

// class IncrementIntent extends Intent {
//   const IncrementIntent();
// }

// class DecrementIntent extends Intent {
//   const DecrementIntent();
// }

// class HelpMenuIntent extends Intent {
//   const HelpMenuIntent();
// }

// class LogicalKeySetExample extends StatefulWidget {
//   const LogicalKeySetExample({super.key});

//   @override
//   State<LogicalKeySetExample> createState() => _LogicalKeySetExampleState();
// }

// class _LogicalKeySetExampleState extends State<LogicalKeySetExample> {
//   int count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Shortcuts(
//       shortcuts: <ShortcutActivator, Intent>{
//         const SingleActivator(LogicalKeyboardKey.keyC, control: true):
//             const IncrementIntent(),
//         // LogicalKeySet(LogicalKeyboardKey.keyI, LogicalKeyboardKey.controlLeft):
//         //     const IncrementIntent(),
//         LogicalKeySet(LogicalKeyboardKey.keyD, LogicalKeyboardKey.controlLeft):
//             const DecrementIntent(),
//         const CharacterActivator(
//           '?',
//         ): const HelpMenuIntent(),
//       },
//       child: Actions(
//         actions: <Type, Action<Intent>>{
//           IncrementIntent: CallbackAction<IncrementIntent>(
//             onInvoke: (IncrementIntent intent) => setState(() {
//               count = count + 1;
//             }),
//           ),
//           DecrementIntent: CallbackAction<DecrementIntent>(
//             onInvoke: (DecrementIntent intent) => setState(() {
//               count = count - 1;
//             }),
//           ),
//           HelpMenuIntent: CallbackAction<HelpMenuIntent>(
//             onInvoke: (HelpMenuIntent intent) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Keep calm and carry on!')),
//               );
//               return null;
//             },
//           ),
//         },
//         child: Focus(
//           autofocus: true,
//           child: Column(
//             children: <Widget>[
//               const Text('Press question mark for help'),
//               const Text('Add to the counter by pressing Ctrl+I'),
//               const Text('Decrement to the counter by pressing Ctrl+D'),
//               Text('count: $count'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

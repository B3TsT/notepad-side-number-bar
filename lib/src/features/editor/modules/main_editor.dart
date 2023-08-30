// import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

class MainEditor extends StatelessWidget {
  const MainEditor({super.key});

  @override
  Widget build(BuildContext context) {
    const String yourText =
        'Reprehenderit culpa occaecat\n cillum pariatur sit ea exercitation\n deserunt ut proident.';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('TO do List'),
            LayoutBuilder(builder: (context, constraints) {
              const span = TextSpan(text: yourText);
              final tp =
                  TextPainter(text: span, textDirection: TextDirection.ltr);
              tp.layout(maxWidth: constraints.maxWidth);
              final numLines = tp.computeLineMetrics().length;

              if (numLines > 3) {
                // TODO: display the prompt message
                return const ColoredBox(color: Colors.grey);
              } else {
                return const Text(yourText);
              }
            })
          ],
        ),
      ],
    );
  }
}

class ColumnApp extends StatefulWidget {
  const ColumnApp({super.key});

  @override
  State<ColumnApp> createState() => _ColumnAppState();
}

class _ColumnAppState extends State<ColumnApp> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<int> lineNumbers = [1];
  int cursorLine = 1; // Número de línea donde se encuentra el cursor
  double textFieldWidth = 0; // Almacena el ancho del TextField

  void updateText(String newText) {
    final textSpan = TextSpan(
      text: newText,
      style: const TextStyle(
        fontSize: 14, // Ajusta el tamaño de fuente según tu diseño
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: textFieldWidth, // Usa el ancho del TextField
    );

    final lines = textPainter.computeLineMetrics();
    setState(() {
      lineNumbers = List<int>.generate(lines.length, (index) => index + 1);
    });
  }

  void updateCursorPosition() {
    final cursorPosition = textController.selection.extentOffset;
    int currentOffset = 0;
    int currentLine = 1;

    for (var line in lineNumbers) {
      if (cursorPosition >= currentOffset &&
          cursorPosition < currentOffset + line) {
        setState(() {
          cursorLine = currentLine;
        });
        break;
      }
      currentOffset += line;
      currentLine++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    updateText(textController.text);
    return ScaffoldPage.scrollable(
      // header: Text('data'),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...lineNumbers.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(0.08),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: cursorLine == e
                                  ? Colors.blue
                                  : Colors.orange.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text(
                          '${e.toString()} ',
                          style: TextStyle(
                            color: cursorLine == e
                                ? Colors.blue
                                : Colors.orange.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // child:
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        // width: size.width - 125,
                        width: size.width > 1000
                            ? size.width - 320
                            // : size.width < 900
                            //     ? size.width - 110
                            : size.width - 100,
                        // : size.width - 135,
                        // width: 300,
                        // height: size.height - 100,
                        // color: Colors.amber,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                textFieldWidth = constraints.maxWidth - 10;

                                // con
                                // updateMetric(constraints);
                                // (size.width *
                                //     0.1); // Actualiza el ancho del TextField
                                // return TextField(
                                //   decoration: const InputDecoration.collapsed(
                                //     hintText: 'Ingresa un nuevo texto...',
                                //     // hintStyle: TextStyle(
                                //     //   color: Colors.white10,
                                //     // ),
                                //     // focusedBorder: UnderlineInputBorder(
                                //     //   borderRadius: BorderRadius.only(),
                                //     // ),
                                //   ),
                                //   style: const TextStyle(
                                //     color: Colors.white70,
                                //   ),
                                //   controller: textController,
                                //   onChanged: (text) {
                                //     var nombre =
                                //         text.replaceAll(RegExp('/[^\r\n]+/g'), '\n');
                                //     print(nombre);
                                //     updateText(text);
                                //     // updateCursorPosition(); // Actualizar la posición al cambiar el texto
                                //   },
                                //   maxLines: null,
                                //   onSubmitted: (text) {
                                //     updateText(text);
                                //     textController.clear();
                                //   },
                                //   onTap: () {
                                //     // updateCursorPosition();
                                //   },
                                //   // onSelectionChanged: (selection, cause) {
                                //   //   if (cause == SelectionChangedCause.tap) {
                                //   //     updateCursorPosition();
                                //   //   }
                                //   // },
                                //   // onChanged: (text) {

                                //   // },
                                // );

                                // return SizedBox();
                                return TextBox(
                                  maxLines: null,
                                  placeholder: 'Ingresa un nuevo texto...',
                                  controller: textController,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    top: BorderSide.none,
                                    left: BorderSide.none,
                                  )),
                                  onChanged: (text) {
                                    updateText(text);
                                    updateCursorPosition(); // Actualizar la posición al cambiar el texto
                                  },
                                  onSubmitted: (text) {
                                    updateText(text);
                                    textController.clear();
                                  },
                                  onTap: () {
                                    updateCursorPosition();
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          ],
        ),
      ],
      // child: ,
    );
  }
}

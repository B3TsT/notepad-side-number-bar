part of '../modules/editor_view.dart';

mixin _EditorViewStateMixin on State<EditorView> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<int> lineNumbers = [1];
  int cursorLine = 1;
  double textFieldWidth = 0;

  void updateText(String newText) {
    final textSpan = TextSpan(
      text: newText,
      style: const TextStyle(
        fontSize: 14,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: textFieldWidth,
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

  Row editorViewBodyExtension(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
          children: [
            Row(
              children: [
                SizedBox(
                  width:
                      size.width > 1000 ? size.width - 320 : size.width - 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          textFieldWidth = constraints.maxWidth - 10;
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
                              updateCursorPosition();
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
          ],
        ),
      ],
    );
  }
}

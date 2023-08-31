import 'package:fluent_ui/fluent_ui.dart';
import '../../../../common/variable.dart' as va;

class HeaderNavigationPane extends StatelessWidget {
  const HeaderNavigationPane({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, right: 7),
      child: Image.network(va.image),
    );
  }
}

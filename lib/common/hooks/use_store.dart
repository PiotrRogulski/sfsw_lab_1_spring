import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sfsw_lab_1_spring/common/hooks/use_reaction.dart';

T useObservable<T>(T Function() buildObservable) {
  final valueNotifier = useState<T>(buildObservable());
  useReaction(buildObservable, (value) {
    valueNotifier.value = value;
  });
  return valueNotifier.value;
}

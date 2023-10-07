import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobx/mobx.dart';

typedef ReactionFunction<T> = T Function();
typedef ReactionEffect<T> = void Function(T value);

void useReaction<T>(
  ReactionFunction<T> fn,
  ReactionEffect<T> effect, [
  List<Object> keys = const [],
]) {
  final disposer = useMemoized(
    () => reaction((_) => fn(), effect),
    keys,
  );
  useEffect(
    () => disposer,
    [disposer],
  );
}

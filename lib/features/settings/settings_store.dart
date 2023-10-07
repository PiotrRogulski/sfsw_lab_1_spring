import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;

abstract class _SettingsStoreBase with Store {
  _SettingsStoreBase({
    required this.themeMode,
  });

  @observable
  ThemeMode themeMode;
}

import 'package:flutter/foundation.dart';

const String _configuredApiBase = String.fromEnvironment('API_BASE');
const String _configuredApiPort = String.fromEnvironment(
  'API_PORT',
  defaultValue: '5001',
);

String get apiBase {
  if (_configuredApiBase.isNotEmpty) {
    return _configuredApiBase;
  }

  if (kIsWeb) {
    return 'http://localhost:$_configuredApiPort';
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'http://10.0.2.2:$_configuredApiPort';
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return 'http://localhost:$_configuredApiPort';
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return 'http://127.0.0.1:$_configuredApiPort';
    case TargetPlatform.fuchsia:
      return 'http://localhost:$_configuredApiPort';
  }
}

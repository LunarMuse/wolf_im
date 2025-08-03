import 'package:flutter/material.dart';

import 'gen/app_l10n.dart';

export 'gen/app_l10n.dart' show AppL10n;

const l10nDelegates = AppL10n.localizationsDelegates;
const l10nLocales = AppL10n.supportedLocales;

extension AppLocalizationsX on BuildContext {
  AppL10n get l10n => AppL10n.of(this);
}

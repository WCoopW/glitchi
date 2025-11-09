import 'dart:async';

import 'package:glitchi/src/core/utils/refined_logger.dart';
import 'package:glitchi/src/feature/initialization/logic/app_runner.dart';

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );

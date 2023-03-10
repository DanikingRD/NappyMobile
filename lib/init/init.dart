import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/firebase_options.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/config.dart';
import 'package:nappy_mobile/nappy.dart';

final NappyLogger logger = NappyLogger.getLogger("init");
const String appName = "Nappy";
// This is why I use [Unit] instead of `void`:
// (https://medium.com/flutter-community/the-curious-case-of-void-in-dart-f0535705e529)
Future<Unit> run(EnvType env) async {
  final NappyConfig config = NappyConfig(appName, env);
  logger.i("Initializing Nappy in ${config.env.name} mode");
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
  runApp(
    const ProviderScope(
      observers: [
        NappyProviderObserver(),
      ],
      child: Nappy(),
    ),
  );
  return unit;
}

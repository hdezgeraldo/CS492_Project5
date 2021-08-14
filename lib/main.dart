import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'app.dart';

const DSN_URL = 'https://0cb06a04f7b84d199bce5183dcacc981@o956722.ingest.sentry.io/5906129';

Future<void> main() async {
  await SentryFlutter.init(
    (options) => options.dsn = DSN_URL,
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(MyApp());
    }
  );
}
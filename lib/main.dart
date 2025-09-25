import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/constants/hive_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Initializing Hive
  final appStorageDirPath = await getApplicationDocumentsDirectory();
  Hive.initFlutter();
  Hive.init(appStorageDirPath.path);

  //! Opening Hive boxes
  await Hive.openBox<String>(HiveConstants.prefBoxName);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

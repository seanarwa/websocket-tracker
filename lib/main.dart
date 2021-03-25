import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websocket_tracker/pages/index.dart';
import 'package:global_configuration/global_configuration.dart';

class SecureHttpOverrides extends HttpOverrides {
  final String clientCertificatePfxPath;
  final String clientKeyPassword;

  SecureHttpOverrides(this.clientCertificatePfxPath, this.clientKeyPassword);

  @override
  HttpClient createHttpClient(SecurityContext context) {
    context.setTrustedCertificates(
      this.clientCertificatePfxPath,
      password: this.clientKeyPassword,
    );
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromPath('config/config.json');
  final useSecureConnection = GlobalConfiguration().get('secure') as bool;
  if (useSecureConnection) {
    print("Using HTTPS connections");
    HttpOverrides.global = SecureHttpOverrides(
      GlobalConfiguration().get('clientCertificatePfx'),
      GlobalConfiguration().get('clientKeyPassword'),
    );
  } else {
    print("Using HTTP connections");
  }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Socket.IO Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'locales.dart';

class AppAboutDialog {
  AppAboutDialog(context) {
    showAboutDialog(
      context: context,
      applicationName: currentLocale.appName,
      applicationVersion: currentLocale.appVersion,
      applicationLegalese:
          "${currentLocale.main.aboutContent.copyright} ${currentLocale.developer}",
      applicationIcon: const Center(
        child: Image(
          image: AssetImage('assets/icons/icon.png'),
          height: 85.0,
        ),
      ),
      children: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentLocale.main.aboutContent.createdBy),
            InkWell(
              child: Text(
                currentLocale.developer,
                style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
              onTap: () {
                launchUrl(
                    Uri.parse('https://github.com/${currentLocale.developer}'));
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentLocale.main.aboutContent.poweredBy),
            InkWell(
              child: const Text(
                "Flutter",
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
              onTap: () {
                launchUrl(Uri.parse('https://flutter.dev'));
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentLocale.main.aboutContent.currenciesPoweredBy),
            InkWell(
              child: const Text(
                "JsDelivr",
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
              onTap: () {
                launchUrl(Uri.parse('https://cdn.jsdelivr.net'));
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentLocale.main.aboutContent.codeDistributedOn),
            InkWell(
              child: const Text(
                "GitHub",
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
              onTap: () => launchUrl(Uri.parse(
                  'https://github.com/${currentLocale.developer}/unitconverter')),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Text(
                currentLocale.main.aboutContent.privacyPolicy,
                style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue),
              ),
              onTap: () => launchUrl(Uri.parse(
                  "https://thedarkbug.github.io/privacy-policy/unitconverter.html")),
            ),
          ],
        ),
      ],
    );
  }
}

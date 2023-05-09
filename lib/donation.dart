import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'locales.dart';

class DonationDialog extends StatelessWidget {
  const DonationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(currentLocale.main.donationContent.question)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Ko-fi'),
            onPressed: () {
              launchUrl(Uri.parse(
                  'https://ko-fi.com/${currentLocale.developer.toLowerCase()}'));
            },
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(currentLocale.main.donationContent.close),
            ),
          ],
        ),
      ],
    );
  }
}

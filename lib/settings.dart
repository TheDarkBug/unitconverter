import 'package:flutter/material.dart';

class SettingCard extends StatefulWidget {
  const SettingCard({super.key, required this.name, required this.setter});
  final String name;
  final Widget setter;

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.name),
            widget.setter,
          ],
        ),
      ),
    );
  }
}

class Settings {
  Settings({required this.themeSetter, required this.themeMode});
  final void Function(ThemeMode mode) themeSetter;
  ThemeMode themeMode;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.settings});
  final Settings settings;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool themeSwitch = false;
  bool systemTheme = true;
  @override
  void initState() {
    super.initState();
    themeSwitch = widget.settings.themeMode == ThemeMode.dark;
    systemTheme = widget.settings.themeMode == ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    if (systemTheme) {
      themeSwitch =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return [
          SettingCard(
            name: 'Dark Mode',
            setter: Switch(
                value: themeSwitch,
                onChanged: systemTheme
                    ? null
                    : (value) {
                        setState(() {
                          themeSwitch = value;
                          widget.settings.themeSetter(
                              value ? ThemeMode.dark : ThemeMode.light);
                        });
                      }),
          ),
          SettingCard(
            name: 'Use System Theme',
            setter: Switch(
                value: systemTheme,
                onChanged: (value) {
                  setState(() {
                    systemTheme = value;
                    widget.settings
                        .themeSetter(value ? ThemeMode.system : ThemeMode.dark);
                  });
                }),
          ),
        ][index];
      },
    );
  }
}

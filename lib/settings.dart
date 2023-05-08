import 'package:flutter/material.dart';
import 'locales.dart';

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
  Settings(
      {required this.themeSetter,
      required this.getTheme,
      required this.setLocale});
  final void Function(ThemeMode mode) themeSetter;
  final ThemeMode Function() getTheme;
  final void Function(String code) setLocale;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.settings});
  final Settings settings;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool themeSwitch = false;
  bool systemTheme = false;
  @override
  void initState() {
    super.initState();
    themeSwitch = widget.settings.getTheme() == ThemeMode.dark;
    systemTheme = widget.settings.getTheme() == ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return [
            SettingCard(
              name: currentLocale.settings.darkMode,
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
              name: currentLocale.settings.systemTheme,
              setter: Switch(
                  value: systemTheme,
                  onChanged: (value) {
                    setState(() {
                      systemTheme = value;
                      widget.settings.themeSetter(value
                          ? ThemeMode.system
                          : themeSwitch
                              ? ThemeMode.dark
                              : ThemeMode.light);
                    });
                  }),
            ),
            SettingCard(
              name: currentLocale.settings.language,
              setter: DropdownButton<String>(
                value: currentLocale.id[0],
                items: currentLocale.langs
                    .map<DropdownMenuItem<String>>((locale) => DropdownMenuItem(
                          value: locale['code'],
                          child: Text(locale['name']),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    widget.settings.setLocale(value!);
                  });
                },
              ),
            ),
          ][index];
        },
      ),
    );
  }
}

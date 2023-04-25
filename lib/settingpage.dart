import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Sound'),
            value: _soundEnabled,
            onChanged: (bool value) {
              setState(() {
                _soundEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Music'),
            value: _musicEnabled,
            onChanged: (bool value) {
              setState(() {
                _musicEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

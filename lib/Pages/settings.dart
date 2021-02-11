import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool sawich = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.black,
              child: ListTile(
                leading: Icon(
                  Icons.not_interested,
                  color: Colors.red,
                ),
                title: Text(
                  'Show NSFW',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Switch(
                  value: sawich,
                  onChanged: (value) {
                    setState(() {
                      sawich = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.red[600],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

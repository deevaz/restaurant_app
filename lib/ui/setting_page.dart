import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/provider/theme_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Tema Gelap'),
                trailing: Switch(
                  value: provider.isDarkMode,
                  onChanged: (value) {
                    provider.toggleTheme();
                  },
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

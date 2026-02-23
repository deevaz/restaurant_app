import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reastaurant_app/provider/preference_provider.dart';
import 'package:reastaurant_app/provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Tema Gelap'),
                trailing: Switch(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    provider.toggleTheme();
                  },
                  activeThumbColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Consumer<SchedulingProvider>(
                builder: (context, scheduled, child) {
                  return ListTile(
                    title: const Text('Daily Reminder (11:00 AM)'),
                    subtitle: const Text('Rekomendasi restoran acak untukmu'),
                    trailing: Switch.adaptive(
                      value: scheduled.isScheduled,
                      onChanged: (value) async {
                        await scheduled.scheduledNews(value);
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

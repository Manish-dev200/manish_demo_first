import 'package:demo_first/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/di/setting_injector.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {

  @override
  Widget build(BuildContext context) {
    final vm=ref.read(settingViewModelProvider.notifier);
    final state=ref.watch(settingViewModelProvider);
    return Scaffold(
      appBar: AppBar(title:  AppText("Settings",style:Theme.of(context).textTheme.bodyLarge)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🧑 Profile Section
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=4', // Replace with real image
                  ),
                ),
                const SizedBox(height: 10),
                 AppText(
                  'John Doe',
                  style:Theme.of(context).textTheme.titleMedium,
                ),
                 AppText(
                  'john.doe@example.com',
                  style:Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),



          const Divider(),

          // ➕ Optional Buttons
          ListTile(
            leading: const Icon(Icons.edit),
            title:  AppText('Edit Profile',style:Theme.of(context).textTheme.displaySmall,),
            onTap: () {},
          ),


          // 🌙 Theme Mode Toggle
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title:  AppText('Dark Mode',style:Theme.of(context).textTheme.displaySmall,),
            trailing: Switch(

              value: state.isDarkMode,
              onChanged: (val) {
                vm.changeTheme(val,ref);

              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title:  AppText('Logout',style:Theme.of(context).textTheme.displaySmall,),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

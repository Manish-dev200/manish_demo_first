

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/theme_injector.dart';

class SettingState {
  final bool isLoading;
  late final  bool isDarkMode;

  SettingState({this.isLoading = false,this.isDarkMode=false});

  SettingState copyWith({bool? isLoading,bool? isDarkMode}) {
    return SettingState(
        isLoading: isLoading ?? this.isLoading,
        isDarkMode: isDarkMode ?? this.isDarkMode
    );
  }
}



class SettingViewModel extends StateNotifier<SettingState> {
  SettingViewModel() : super(SettingState()) {
  }

  void changeTheme(bool val, WidgetRef ref) {
    state=state.copyWith(isDarkMode: val);
    if(val){
      ref.read(themeModeProvider.notifier).state = ThemeMode.dark;

    }else{
      ref.read(themeModeProvider.notifier).state = ThemeMode.light;
    }

  }


}

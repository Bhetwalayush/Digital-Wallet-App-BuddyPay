import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { defaultTheme, light, dark }

class ThemeCubit extends Cubit<AppTheme> {
  ThemeCubit() : super(AppTheme.defaultTheme) {
    _loadTheme();
  }

  Future<void> setTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_theme', theme.toString());
    emit(theme);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString =
        prefs.getString('app_theme') ?? AppTheme.defaultTheme.toString();
    emit(AppTheme.values.firstWhere((e) => e.toString() == themeString));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/app/localization/localization_cubit.dart';
import 'package:recipe/core/app/theme_cubit/theme_cubit.dart';

class ProfileCubit extends Cubit<void> {
  ProfileCubit(this.themeCubit, this.localizationCubit) : super(null);

  final ThemeCubit themeCubit;
  final LocalizationCubit localizationCubit;
  

  void toggleTheme() => themeCubit.toggleTheme();
  void toggleLanguage() => localizationCubit.toggleLanguage();

  bool get isDark => themeCubit.isDark;
  bool get isArabic => localizationCubit.isArabic;
}

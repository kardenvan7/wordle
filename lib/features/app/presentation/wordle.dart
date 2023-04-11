import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/di/di.dart';
import 'package:wordle/features/app/application/cubits/locale_cubit.dart';
import 'package:wordle/features/app/application/cubits/theme_mode_cubit.dart';
import 'package:wordle/features/app/presentation/theme/theme_facade.dart';
import 'package:wordle/localization/localization.dart';
import 'package:wordle/navigation/app_router.dart';

class Wordle extends StatelessWidget {
  const Wordle({
    Key? key,
  }) : super(key: key);

  Scope get _scope => Scope.app;

  @override
  Widget build(BuildContext context) {
    final di = DI.instance;

    final localization = di.get<AppLocalizationsFacade>(_scope);
    final router = di.get<AppRouter>(_scope);
    final theme = di.get<ThemeFacade>(_scope);
    final themeCubit = di.get<ThemeModeCubit>(_scope);
    final localeCubit = di.get<LocaleCubit>(_scope);

    return BlocBuilder<LocaleCubit, Locale>(
      bloc: localeCubit,
      builder: (context, locale) {
        return BlocBuilder<ThemeModeCubit, ThemeMode>(
          bloc: themeCubit,
          builder: (context, mode) {
            return MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              title: localization.getAppTitle(locale: locale),
              theme: theme.light,
              darkTheme: theme.dark,
              themeMode: mode,
              locale: locale,
              localizationsDelegates: localization.delegates,
              supportedLocales: localization.supportedLocales,
            );
          },
        );
      },
    );
  }
}

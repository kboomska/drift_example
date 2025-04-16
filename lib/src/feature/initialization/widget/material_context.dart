import 'package:flutter/material.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey(debugLabel: 'MaterialContext');

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      // TODO(Kuzmin): Add locale and theme.
      home: Placeholder(),
      builder: (context, child) {
        return MediaQuery(
          key: _globalKey,
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(
              mediaQueryData.textScaler.scale(1).clamp(0.5, 2),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

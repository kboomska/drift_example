import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:drift_example/src/feature/tasks/controller/tasks_controller.dart';
import 'package:drift_example/src/feature/tasks/widget/tasks_scope.dart';
import 'package:drift_example/src/feature/tasks/widget/tasks_screen.dart';
import 'package:flutter/material.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatefulWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  // This global key is needed for [MaterialApp]
  // to work properly when Widgets Inspector is enabled.
  static final _globalKey = GlobalKey(debugLabel: 'MaterialContext');

  @override
  State<MaterialContext> createState() => _MaterialContextState();
}

class _MaterialContextState extends State<MaterialContext> {
  late final TasksController tasksController;

  @override
  void initState() {
    super.initState();

    tasksController = TasksController(
      repository: DependenciesScope.of(context).tasksRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return MaterialApp(
      // TODO(Kuzmin): Add locale and theme.
      home: TasksScreen(),
      builder: (context, child) {
        return MediaQuery(
          key: MaterialContext._globalKey,
          data: mediaQueryData.copyWith(
            textScaler: TextScaler.linear(
              mediaQueryData.textScaler.scale(1).clamp(0.5, 2),
            ),
          ),
          child: TasksScope(controller: tasksController, child: child!),
        );
      },
    );
  }
}

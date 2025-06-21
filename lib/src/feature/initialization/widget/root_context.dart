import 'package:drift_example/src/feature/initialization/model/dependencies_container.dart';
import 'package:drift_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:drift_example/src/feature/initialization/widget/material_context.dart';
import 'package:flutter/material.dart';

/// {@template app}
/// [RootContext] is an entry point to the application.
///
/// If a scope doesn't depend on any inherited widget returned by
/// [MaterialApp] or [WidgetsApp], like [Directionality] or [Theme],
/// and it should be available in the whole application, it can be
/// placed here.
/// {@endtemplate}
class RootContext extends StatelessWidget {
  /// {@macro app}
  const RootContext({super.key, required this.dependencies});

  /// Container with dependencies.
  final DependenciesContainer dependencies;

  @override
  Widget build(BuildContext context) {
    return DependenciesScope(
      dependencies: dependencies,
      child: MaterialContext(),
    );
  }
}

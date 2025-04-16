import 'package:drift_example/src/core/extensions/context_extensions.dart';
import 'package:drift_example/src/feature/initialization/model/dependencies_container.dart';
import 'package:flutter/widgets.dart';

/// {@template dependencies_scope}
/// A scope that provides composed [DependenciesContainer].
/// {@endtemplate}
class DependenciesScope extends InheritedWidget {
  /// {@macro dependencies_scope}
  const DependenciesScope({
    super.key,
    required super.child,
    required this.dependencies,
  });

  /// Container with dependencies.
  final DependenciesContainer dependencies;

  /// Get the dependencies from the [context].
  static DependenciesContainer of(BuildContext context) =>
      context.inhOf<DependenciesScope>(listen: false).dependencies;

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) {
    return !identical(dependencies, oldWidget.dependencies);
  }
}

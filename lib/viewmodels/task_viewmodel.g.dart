// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'32848c18dd36b350439a45fa6338bf2df6758978';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(TaskViewModel)
final taskViewModelProvider = TaskViewModelProvider._();

final class TaskViewModelProvider
    extends $AsyncNotifierProvider<TaskViewModel, List<TaskModel>> {
  TaskViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskViewModelHash();

  @$internal
  @override
  TaskViewModel create() => TaskViewModel();
}

String _$taskViewModelHash() => r'301fd5390a908e09c72737c4796df1a1fd2b8e37';

abstract class _$TaskViewModel extends $AsyncNotifier<List<TaskModel>> {
  FutureOr<List<TaskModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<TaskModel>>, List<TaskModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TaskModel>>, List<TaskModel>>,
              AsyncValue<List<TaskModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredTasks)
final filteredTasksProvider = FilteredTasksProvider._();

final class FilteredTasksProvider
    extends
        $FunctionalProvider<List<TaskModel>, List<TaskModel>, List<TaskModel>>
    with $Provider<List<TaskModel>> {
  FilteredTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTasksHash();

  @$internal
  @override
  $ProviderElement<List<TaskModel>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<TaskModel> create(Ref ref) {
    return filteredTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TaskModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TaskModel>>(value),
    );
  }
}

String _$filteredTasksHash() => r'02063612590aadb6ae9034d2be242dd9d924339d';

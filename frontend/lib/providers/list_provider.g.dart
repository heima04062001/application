// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchItemsHash() => r'654ab6f5927365315b8774a237d713094a439ef6';

/// See also [fetchItems].
@ProviderFor(fetchItems)
final fetchItemsProvider = AutoDisposeFutureProvider<List<ToDoItem>>.internal(
  fetchItems,
  name: r'fetchItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchItemsRef = AutoDisposeFutureProviderRef<List<ToDoItem>>;
String _$addItemHash() => r'661bd3fb001d681ac871a2f7197d62db80d4fc0f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [addItem].
@ProviderFor(addItem)
const addItemProvider = AddItemFamily();

/// See also [addItem].
class AddItemFamily extends Family<AsyncValue<void>> {
  /// See also [addItem].
  const AddItemFamily();

  /// See also [addItem].
  AddItemProvider call(
    ToDoItem item,
  ) {
    return AddItemProvider(
      item,
    );
  }

  @override
  AddItemProvider getProviderOverride(
    covariant AddItemProvider provider,
  ) {
    return call(
      provider.item,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addItemProvider';
}

/// See also [addItem].
class AddItemProvider extends AutoDisposeFutureProvider<void> {
  /// See also [addItem].
  AddItemProvider(
    ToDoItem item,
  ) : this._internal(
          (ref) => addItem(
            ref as AddItemRef,
            item,
          ),
          from: addItemProvider,
          name: r'addItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addItemHash,
          dependencies: AddItemFamily._dependencies,
          allTransitiveDependencies: AddItemFamily._allTransitiveDependencies,
          item: item,
        );

  AddItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final ToDoItem item;

  @override
  Override overrideWith(
    FutureOr<void> Function(AddItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddItemProvider._internal(
        (ref) => create(ref as AddItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddItemProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddItemRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `item` of this provider.
  ToDoItem get item;
}

class _AddItemProviderElement extends AutoDisposeFutureProviderElement<void>
    with AddItemRef {
  _AddItemProviderElement(super.provider);

  @override
  ToDoItem get item => (origin as AddItemProvider).item;
}

String _$modifyItemHash() => r'bbd42af8f8cc5dec90cda47635bbd48860b13bf7';

/// See also [modifyItem].
@ProviderFor(modifyItem)
const modifyItemProvider = ModifyItemFamily();

/// See also [modifyItem].
class ModifyItemFamily extends Family<AsyncValue<void>> {
  /// See also [modifyItem].
  const ModifyItemFamily();

  /// See also [modifyItem].
  ModifyItemProvider call(
    ToDoItem updatedItem,
  ) {
    return ModifyItemProvider(
      updatedItem,
    );
  }

  @override
  ModifyItemProvider getProviderOverride(
    covariant ModifyItemProvider provider,
  ) {
    return call(
      provider.updatedItem,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'modifyItemProvider';
}

/// See also [modifyItem].
class ModifyItemProvider extends AutoDisposeFutureProvider<void> {
  /// See also [modifyItem].
  ModifyItemProvider(
    ToDoItem updatedItem,
  ) : this._internal(
          (ref) => modifyItem(
            ref as ModifyItemRef,
            updatedItem,
          ),
          from: modifyItemProvider,
          name: r'modifyItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$modifyItemHash,
          dependencies: ModifyItemFamily._dependencies,
          allTransitiveDependencies:
              ModifyItemFamily._allTransitiveDependencies,
          updatedItem: updatedItem,
        );

  ModifyItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.updatedItem,
  }) : super.internal();

  final ToDoItem updatedItem;

  @override
  Override overrideWith(
    FutureOr<void> Function(ModifyItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ModifyItemProvider._internal(
        (ref) => create(ref as ModifyItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        updatedItem: updatedItem,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _ModifyItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ModifyItemProvider && other.updatedItem == updatedItem;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, updatedItem.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ModifyItemRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `updatedItem` of this provider.
  ToDoItem get updatedItem;
}

class _ModifyItemProviderElement extends AutoDisposeFutureProviderElement<void>
    with ModifyItemRef {
  _ModifyItemProviderElement(super.provider);

  @override
  ToDoItem get updatedItem => (origin as ModifyItemProvider).updatedItem;
}

String _$deleteItemHash() => r'e84cf948d26fe5022092e39a8303fee0a167236c';

/// See also [deleteItem].
@ProviderFor(deleteItem)
const deleteItemProvider = DeleteItemFamily();

/// See also [deleteItem].
class DeleteItemFamily extends Family<AsyncValue<void>> {
  /// See also [deleteItem].
  const DeleteItemFamily();

  /// See also [deleteItem].
  DeleteItemProvider call(
    ToDoItem item,
  ) {
    return DeleteItemProvider(
      item,
    );
  }

  @override
  DeleteItemProvider getProviderOverride(
    covariant DeleteItemProvider provider,
  ) {
    return call(
      provider.item,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteItemProvider';
}

/// See also [deleteItem].
class DeleteItemProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteItem].
  DeleteItemProvider(
    ToDoItem item,
  ) : this._internal(
          (ref) => deleteItem(
            ref as DeleteItemRef,
            item,
          ),
          from: deleteItemProvider,
          name: r'deleteItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteItemHash,
          dependencies: DeleteItemFamily._dependencies,
          allTransitiveDependencies:
              DeleteItemFamily._allTransitiveDependencies,
          item: item,
        );

  DeleteItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.item,
  }) : super.internal();

  final ToDoItem item;

  @override
  Override overrideWith(
    FutureOr<void> Function(DeleteItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteItemProvider._internal(
        (ref) => create(ref as DeleteItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        item: item,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteItemProvider && other.item == item;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, item.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeleteItemRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `item` of this provider.
  ToDoItem get item;
}

class _DeleteItemProviderElement extends AutoDisposeFutureProviderElement<void>
    with DeleteItemRef {
  _DeleteItemProviderElement(super.provider);

  @override
  ToDoItem get item => (origin as DeleteItemProvider).item;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

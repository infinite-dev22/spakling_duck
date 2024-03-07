part of 'property_category_bloc.dart';

enum PropertyCategoryStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty
}

@immutable
class PropertyCategoryState extends Equatable {
  final List<PropertyCategoryModel>? propertyCategories;
  final PropertyCategoryStatus? status;

  const PropertyCategoryState(
      {this.propertyCategories, this.status = PropertyCategoryStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [propertyCategories, status];

  PropertyCategoryState copyWith({
    final List<PropertyCategoryModel>? propertyCategories,
    final PropertyCategoryStatus? status,
  }) {
    return PropertyCategoryState(
      propertyCategories: propertyCategories ?? this.propertyCategories,
      status: status ?? this.status,
    );
  }
}

@immutable
class PropertyCategoryInitial extends PropertyCategoryState {
  @override
  List<Object> get props => [];
}

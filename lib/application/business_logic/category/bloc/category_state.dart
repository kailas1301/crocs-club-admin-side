part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Map<String, dynamic>> categories;
  CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError({required this.message});
}

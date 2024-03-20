part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class LoadCategory extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final String name;
  AddCategory({required this.name});
}

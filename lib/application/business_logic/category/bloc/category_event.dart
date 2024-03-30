part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class LoadCategory extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final String name;
  AddCategory({required this.name});
}

class EditCategory extends CategoryEvent {
  final String name;
  final String newName;
  EditCategory({required this.name, required this.newName});
}

class DeleteCategory extends CategoryEvent {
  final int id;
  DeleteCategory({required this.id});
}

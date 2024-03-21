import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/repositories/admin_categoryadd.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AdminCategoryRepo repository = AdminCategoryRepo();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.addCategory(event.name);
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<EditCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.editCategory(event.name, event.newName);
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (error) {
        emit(CategoryError(message: error.toString()));
      }
    });

    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await repository.deleteCategory(event.id);
        final categories = await repository.getCategories();
        emit(CategoryLoaded(categories: categories));
      } catch (error) {
        emit(CategoryError(message: error.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/repositories/admin_categoryadd.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AdminCategoryRepo repository = AdminCategoryRepo();

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategory>((event, emit) async {
      print('worked till loadcategory');
      emit(CategoryLoading());
      print('worked till categoryloading');
      try {
        final categories = await repository.getCategories();
        print('worked till getcategory function called');
        emit(CategoryLoaded(categories: categories));
        print('worked till emit categoryLOaded');
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
  }
}

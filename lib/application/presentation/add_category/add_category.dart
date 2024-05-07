import 'package:crocsclub_admin/application/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/application/presentation/add_category/widgets/category_adding_dialougue.dart';
import 'package:crocsclub_admin/application/presentation/add_category/widgets/category_list_tile_widget.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryScrn extends StatelessWidget {
  const AddCategoryScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    context.read<CategoryBloc>().add(LoadCategory());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Categories'),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Column(
              children: [
                Center(
                  child: Text(
                      state.categories.isEmpty ? 'No categories found' : ''),
                ),
                if (state.categories.isNotEmpty)
                  ListView.separated(
                    separatorBuilder: (context, index) => kSizedBoxH10,
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return CategoryListTileWidget(category: category);
                    },
                  ),
              ],
            );
          } else if (state is CategoryError) {
            return const Center(child: Text('No Category Found '));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddCategoryDialougueWidget(nameController: nameController);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

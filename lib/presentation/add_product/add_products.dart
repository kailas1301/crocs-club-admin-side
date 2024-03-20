import 'package:crocsclub_admin/business_logic/category/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductingScrn extends StatelessWidget {
  const AddProductingScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    // Trigger initial loading of categories when widget is first built
    context.read<CategoryBloc>().add(LoadCategory());

    return Scaffold(
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          // You can handle any additional state changes here if needed
        },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoaded) {
            return Column(
              children: [
                Text(state.categories.isEmpty
                    ? 'No categories found'
                    : 'Categories:'),
                if (state.categories.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) =>
                        Text(state.categories[index]),
                  ),
              ],
            );
          } else if (state is CategoryError) {
            return Center(child: Text(state.message));
          }
          return Container(); // Handle unexpected states
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(labelText: 'Category Name'),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Dispatch the AddCategory event here
                          context.read<CategoryBloc>().add(
                                AddCategory(name: nameController.text),
                              );
                          Navigator.pop(context);
                          nameController.clear();
                          // Close the dialog
                        },
                        child: const Text('Add Category'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

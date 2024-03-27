import 'package:crocsclub_admin/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/utils/constants.dart';
import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:crocsclub_admin/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductingScrn extends StatelessWidget {
  const AddProductingScrn({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    context.read<CategoryBloc>().add(LoadCategory());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Categories',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ListTile(
                              title: Text(category['category']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      showEditDialog(
                                          context, category['category']);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      confirmDelete(context, category['id'],
                                          category['category']);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          } else if (state is CategoryError) {
            return const Center(
                child: Text('please wait there is some issue '));
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
                      TextFormFieldWidget(
                          controller: nameController,
                          hintText: 'Category Name',
                          errorText: 'Enter a valid category name'),
                      kSizedBoxH10,
                      ElevatedButtonWidget(
                          onPressed: () {
                            context.read<CategoryBloc>().add(
                                  AddCategory(name: nameController.text),
                                );
                            Navigator.pop(context);
                            nameController.clear();
                          },
                          buttonText: 'Add Category')
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

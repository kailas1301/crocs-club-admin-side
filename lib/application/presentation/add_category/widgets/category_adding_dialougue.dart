import 'package:crocsclub_admin/application/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/utils/widgets/elevatedbutton_widget.dart';

class AddCategoryDialougueWidget extends StatelessWidget {
  const AddCategoryDialougueWidget({super.key, required this.nameController});
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(
                controller: nameController,
                hintText: 'Category Name',
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid category name';
                  }
                  return null; // Valid
                },
              ),
              kSizedBoxH20,
              ElevatedButtonWidget(
                  onPressed: () {
                    context
                        .read<CategoryBloc>()
                        .add(AddCategory(name: nameController.text));
                    Navigator.pop(context);
                    nameController.clear();
                  },
                  buttonText: 'Add Category')
            ],
          ),
        ),
      ),
    );
  }
}

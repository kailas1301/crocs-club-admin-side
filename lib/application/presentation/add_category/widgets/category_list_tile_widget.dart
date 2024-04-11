import 'package:crocsclub_admin/application/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/application/presentation/adding_selecting_screen/adding_selecting_screen.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListTileWidget extends StatelessWidget {
  const CategoryListTileWidget({super.key, required this.category});

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          showSelectionDialog(context, category['id'], category['category']),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: kAppPrimaryColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListTile(
              title: SubHeadingTextWidget(
                title: category['category'],
                textColor: kwhiteColour,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: kwhiteColour,
                    ),
                    onPressed: () {
                      showEditDialog(context, category['category']);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: kwhiteColour,
                    ),
                    onPressed: () {
                      confirmDelete(
                        onPressed: () => context
                            .read<CategoryBloc>()
                            .add(DeleteCategory(id: category['id'])),
                        context: context,
                        id: category['id'],
                        categoryName: category['category'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

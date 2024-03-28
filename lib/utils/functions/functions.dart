import 'package:crocsclub_admin/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/presentation/admin_login/llogin_scrn.dart';
import 'package:crocsclub_admin/utils/constants.dart';
import 'package:crocsclub_admin/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// to save the auth token while admin log in

Future<String?> getToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  } catch (e) {
    print('Error fetching token: $e');
    throw Exception('Failed to get access token: $e');
  }
}

// to log out the admin by clearing the token

Future<void> adminlogout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accessToken', ''); // Set token to empty string
  print('Logged out successfully!');
  Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false);
}

// to show the snackbar

void showCustomSnackbar(
    BuildContext context, String text, Color backgroundcolor, Color textcolor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
      backgroundColor: backgroundcolor,
    ),
  );
}

// to show the edit dialougue box to delete the category
void confirmDelete(BuildContext context, int id, String categoryName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content:
            Text('Are you sure you want to delete the category $categoryName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CategoryBloc>().add(DeleteCategory(id: id));
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

// to show the edit dialougue boc to edit the category
void showEditDialog(BuildContext context, String categoryName) {
  final editController = TextEditingController(text: categoryName);
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
                  controller: editController,
                  hintText: 'Category Name',
                  errorText: 'Please give a valid name'),
              kSizedBoxH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (editController.text.isNotEmpty &&
                          editController.text != categoryName) {
                        context.read<CategoryBloc>().add(
                              EditCategory(
                                  name: categoryName,
                                  newName: editController.text),
                            );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

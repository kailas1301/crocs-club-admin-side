import 'dart:io';

import 'package:crocsclub_admin/application/business_logic/multiple_image/bloc/multiple_image_picking_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddImagesScreen extends StatelessWidget {
  const AddImagesScreen({super.key, required this.inventoryId});
  final int inventoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<MultipleImagePickingBloc>(context)
                  .add(PickImagesExited());
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Add Images'),
      ),
      body: BlocBuilder<MultipleImagePickingBloc, MultipleImagePickingState>(
        builder: (context, state) {
          if (state is MultipleImagePickingInitial) {
            return const Center(child: Text('No images selected'));
          } else if (state is MultipleImagePicked) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: state.fileImages.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(state.fileImages[index].path)),
                      );
                    },
                  ),
                ),
                ElevatedButtonWidget(
                  buttonText: 'Upload Image',
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context).add(UploadImagesEvent(
                        inventoryId: inventoryId, images: state.fileImages));
                    BlocProvider.of<MultipleImagePickingBloc>(context)
                        .add(PickImagesExited());
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }

          if (state is NoImagePicked) {
            return const Center(
                child: SubHeadingTextWidget(
              title: 'No images were picked',
              textColor: kDarkGreyColour,
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pickimageevent called');
          BlocProvider.of<MultipleImagePickingBloc>(context)
              .add(PickImagesEvent());
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'multiple_image_picking_event.dart';
part 'multiple_image_picking_state.dart';

class MultipleImagePickingBloc
    extends Bloc<MultipleImagePickingEvent, MultipleImagePickingState> {
  MultipleImagePickingBloc() : super(MultipleImagePickingInitial()) {
    on<PickImagesEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        print("the length of the image list is ${images.length}");
        emit(MultipleImagePicked(fileImages: images));
        print('emitted multipleimagepicked state');
      } else {
        emit(NoImagePicked());
        print('no image was picked');
      }
    });

    on<PickImagesExited>((event, emit) {
      try {
        emit(NoImagePicked());
      } catch (e) {
        emit(NoImagePicked());
      }
    });
  }
}

part of 'multiple_image_picking_bloc.dart';

@immutable
sealed class MultipleImagePickingState {}

final class MultipleImagePickingInitial extends MultipleImagePickingState {}

final class MultipleImagePicked extends MultipleImagePickingState {
  final List<XFile> fileImages;
  MultipleImagePicked({required this.fileImages});
}

final class NoImagePicked extends MultipleImagePickingState {}

part of 'multiple_image_picking_bloc.dart';

@immutable
sealed class MultipleImagePickingEvent {}

class PickImagesEvent extends MultipleImagePickingEvent {}

class PickImagesExited extends MultipleImagePickingEvent {}

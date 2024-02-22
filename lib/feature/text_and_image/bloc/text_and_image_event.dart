part of 'text_and_image_bloc.dart';

sealed class TextAndImageEvent extends Equatable {
  const TextAndImageEvent();

  @override
  List<Object> get props => [];
}

class TextAndImageGenerate extends TextAndImageEvent {
  final String text;
  final List<File> images;
  const TextAndImageGenerate(this.text, this.images);

  @override
  List<Object> get props => [text, images];
}

class AddImage extends TextAndImageEvent {
  final List<File> image;
  const AddImage(this.image);

  @override
  List<Object> get props => [image];
}

class RemoveImage extends TextAndImageEvent {
  final int indexImage;
  const RemoveImage(this.indexImage);

  @override
  List<Object> get props => [indexImage];
}

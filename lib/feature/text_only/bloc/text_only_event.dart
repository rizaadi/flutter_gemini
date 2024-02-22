part of 'text_only_bloc.dart';

sealed class TextOnlyEvent extends Equatable {
  const TextOnlyEvent();

  @override
  List<Object> get props => [];
}

class TextOnlyGenerate extends TextOnlyEvent {
  final String text;
  const TextOnlyGenerate(this.text);
}

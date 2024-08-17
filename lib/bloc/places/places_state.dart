import 'package:equatable/equatable.dart';

abstract class PlaceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final List<dynamic> places;
  final String suggestionType;

  PlaceLoaded(this.places, this.suggestionType);

  @override
  List<Object?> get props => [places, suggestionType];
}

class PlaceError extends PlaceState {
  final String message;

  PlaceError(this.message);

  @override
  List<Object?> get props => [message];
}

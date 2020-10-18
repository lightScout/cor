part of 'cor_cubit.dart';

@immutable
abstract class CorState extends Equatable {
  const CorState();
}

class CorInitial extends CorState {
  const CorInitial();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CorLoading extends CorState {
  const CorLoading();

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CorLoaded extends CorState {
  final HashMap map;

  const CorLoaded(this.map);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CorError extends CorState {
  final String message;

  const CorError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cor/data/color_data.dart';
import 'package:cor/data/color_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'cor_state.dart';

class CorCubit extends Cubit<CorState> {
  final ColorRepository _colorRepository;

  CorCubit(this._colorRepository) : super(CorInitial());

  Future<void> getCor(bool a) async {
    try {
      emit(CorLoading());
      final colorMap = await getColorData();
      emit(CorLoaded(colorMap));
    } on NetworkException {
      emit(CorError('Wait a sec, remember to take a breath to activate Cor'));
    }
  }
}

Future<HashMap> getColorData() async {
  HashMap data;
  try {
    data = await ColorData().getColorData();
  } catch (e) {
    print(e);
  }
  return data;
}

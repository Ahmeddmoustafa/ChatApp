import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'jitsi_state.dart';

class JitsiCubit extends Cubit<JitsiState> {
  JitsiCubit() : super(JitsiInitial());
}

part of "jitsi_cubit.dart";

@immutable
sealed class JitsiState {}

class JitsiInitial extends JitsiState {}

class JitsiCalled extends JitsiState {}

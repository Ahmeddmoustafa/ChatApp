part of 'call_cubit.dart';

@immutable
sealed class CallState {}

class CallInitial extends CallState {}

class CallAccepted extends CallState {}

class CallPending extends CallState {}

class EndCall extends CallState {}

class CallError extends CallState {
  final String msg;

  CallError({required this.msg});
}


// class RecievedCall extends CallState {}

// class CallSent extends CallState {}

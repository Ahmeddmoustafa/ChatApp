part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

class ChatInitial extends ChatState {}

class ChatOpened extends ChatState {}

class UserCalled extends ChatState {}

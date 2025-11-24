part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SendContactEvent extends ContactEvent {}

class RequestContactEvent extends ContactEvent {}

class ApproveContactEvent extends ContactEvent {}

part of 'contact_bloc.dart';

sealed class ContactEvent extends Equatable {
  const ContactEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SendContactEvent extends ContactEvent {
  final String requestedId;
  const SendContactEvent({required this.requestedId});
  @override
  List<Object> get props => [requestedId];
}

class ApproveContactEvent extends ContactEvent {
  final String requestedId;
  const ApproveContactEvent({required this.requestedId});
  @override
  List<Object> get props => [requestedId];
}

class MySentContactRequestsEvent extends ContactEvent {}

class MyReceivedContactRequestEvent extends ContactEvent {}

class CancelSentContactRequestEvent extends ContactEvent {
  final String requestedId;
  const CancelSentContactRequestEvent({required this.requestedId});
  @override
  List<Object> get props => [requestedId];
}

class MySentContactRequestListEvent extends ContactEvent {}
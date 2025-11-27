part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final ApiResponse<String> apiResponse;
  final ContactRequestedListModel contactRequestedListModel;
  final ReceivedContactRequestModel receivedContactRequestModel;
  const ContactState({
    this.apiResponse = const ApiResponse.initial(),
    this.contactRequestedListModel = const ContactRequestedListModel(),
    this.receivedContactRequestModel = const ReceivedContactRequestModel(),
  });

  ContactState copyWith({
    final ApiResponse<String>? apiResponse,
    final ContactRequestedListModel? contactRequestedListModel,
    final ReceivedContactRequestModel? receivedContactRequestModel
  }) {
    return ContactState(
      apiResponse: apiResponse ?? this.apiResponse,
      contactRequestedListModel:
          contactRequestedListModel ?? this.contactRequestedListModel,
      receivedContactRequestModel: receivedContactRequestModel ?? this.receivedContactRequestModel
    );
  }

  @override
  List<Object> get props => [apiResponse, contactRequestedListModel, receivedContactRequestModel];
}

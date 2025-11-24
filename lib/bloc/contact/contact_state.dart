part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final ApiResponse<String> apiResponse;
  const ContactState({this.apiResponse = const ApiResponse.initial()});

  @override
  List<Object> get props => [apiResponse];
}

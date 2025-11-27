// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rishta_app/data/response/api_response.dart';
import 'package:rishta_app/model/contact/contact_request_list_model.dart';
import 'package:rishta_app/repo/activity/activity_api_repo.dart';

import '../../model/contact/received_contact_request_model.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ActivityApiRepo activityApiRepo;
  ContactBloc({required this.activityApiRepo}) : super(ContactState()) {
    on<SendContactEvent>(_onSendContact);
    on<MySentContactRequestListEvent>(_onMySentContactRequestList);
    on<CancelSentContactRequestEvent>(_onCancelSentContactRequest);
    on<MyReceivedContactRequestEvent>(_onReceiveContactRequests);
    on<ApproveContactEvent>(_onApproveContactRequest);
  }

  Future<void> _onApproveContactRequest(
    ApproveContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      Map<String, dynamic> data = {};
      final response = await activityApiRepo.approveContactRequest(
        requestedId: event.requestedId,
        data: data,
      );

      if (response == null) {
        print("No response from server");
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error("No response from server."),
          ),
        );
        return;
      }

      print("Approve Contact Response: $response");

      if (response['success'] == true) {
        final message = response['message'] ?? "Request approved";

        final oldModel = state.receivedContactRequestModel;

        final updatedList = oldModel.data
            .where((item) => item.requester?.id != event.requestedId)
            .toList();

        final newModel = ReceivedContactRequestModel(
          success: oldModel.success,
          data: updatedList,
        );

        emit(
          state.copyWith(
            receivedContactRequestModel: newModel,
            apiResponse: ApiResponse.completed(message),
          ),
        );

        return;
      }

      final errorMessage = response['message'] ?? "Something went wrong.";
      print("API Error: $errorMessage");

      emit(state.copyWith(apiResponse: ApiResponse.error(errorMessage)));
    } catch (e, s) {
      print("Exception in approveContactRequest: $e");
      print(s);

      emit(
        state.copyWith(
          apiResponse: ApiResponse.error("Unexpected error occurred."),
        ),
      );
    }
  }

  Future<void> _onReceiveContactRequests(
    MyReceivedContactRequestEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));
    try {
      final response = await activityApiRepo.receivedContactRequests();
      if (response != null) {
        if (response['success'] == true && response['data'] != null) {
          final model = ReceivedContactRequestModel.fromJson(response);
          emit(
            state.copyWith(
              receivedContactRequestModel: model,
              apiResponse: ApiResponse.completed('Data fetched Successfully'),
            ),
          );
        } else {
          print(response['message'] ?? 'Something went wrong.');
          emit(
            state.copyWith(
              apiResponse: ApiResponse.error(
                response['message'] ?? 'Something went wrong.',
              ),
            ),
          );
        }
      } else {
        print('No response from server');
      }
    } catch (e) {
      print('error: $e');
      rethrow;
    }
  }

  Future<void> _onSendContact(
    SendContactEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      Map<String, dynamic> data = {};
      final response = await activityApiRepo.sendContact(
        requestedId: event.requestedId,
        data: data,
      );

      if (response != null) {
        if (response['success'] == true && response['message'] != null) {
          final oldModel = state.contactRequestedListModel;

          final updatedRequestedUserIds = List<String>.from(
            oldModel.requestedUserIds,
          )..add(event.requestedId);

          final updatedModel = ContactRequestedListModel(
            success: oldModel.success,
            count: oldModel.count + 1,
            requestedUserIds: updatedRequestedUserIds,
          );

          emit(
            state.copyWith(
              contactRequestedListModel: updatedModel,
              apiResponse: ApiResponse.completed(response['message']),
            ),
          );
        } else {
          print(response['message'] ?? "Error while sending contact request");
          emit(
            state.copyWith(
              apiResponse: ApiResponse.error(
                response['message'] ?? "Error while sending contact request",
              ),
            ),
          );
        }
      } else {
        print('No response from server');
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error('No response from server'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error('An unexpected error occurred'),
        ),
      );
    }
  }

  Future<void> _onCancelSentContactRequest(
    CancelSentContactRequestEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));

    try {
      Map<String, dynamic> data = {};
      final response = await activityApiRepo.cancelRequest(
        requestedId: event.requestedId,
        data: data,
      );

      if (response != null) {
        if (response['success'] == true && response['message'] != null) {
          final oldModel = state.contactRequestedListModel;

          final updatedRequestedUserIds = List<String>.from(
            oldModel.requestedUserIds,
          )..remove(event.requestedId);

          final updatedModel = ContactRequestedListModel(
            success: oldModel.success,
            count: oldModel.count - 1,
            requestedUserIds: updatedRequestedUserIds,
          );

          emit(
            state.copyWith(
              contactRequestedListModel: updatedModel,
              apiResponse: ApiResponse.completed(response['message']),
            ),
          );
        } else {
          print(
            response['message'] ?? "Error while cancelling contact request",
          );
          emit(
            state.copyWith(
              apiResponse: ApiResponse.error(
                response['message'] ?? "Error while cancelling contact request",
              ),
            ),
          );
        }
      } else {
        print('No response from server');
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error('No response from server'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error('An unexpected error occurred'),
        ),
      );
    }
  }

  Future<void> _onMySentContactRequestList(
    MySentContactRequestListEvent event,
    Emitter<ContactState> emit,
  ) async {
    emit(state.copyWith(apiResponse: ApiResponse.loading()));
    try {
      final response = await activityApiRepo.getSenContactRequestList();

      if (response != null) {
        if (response['success'] == true &&
            response['requested_user_ids'] != null) {
          final model = ContactRequestedListModel.fromJson(response);

          emit(
            state.copyWith(
              contactRequestedListModel: model,
              apiResponse: ApiResponse.completed('Data fetched successfully'),
            ),
          );
        } else {
          print(response['message'] ?? "Error while fetching data");
          emit(
            state.copyWith(
              apiResponse: ApiResponse.error(
                response['message'] ?? "Error while fetching data",
              ),
            ),
          );
        }
      } else {
        print('No response from server');
        emit(
          state.copyWith(
            apiResponse: ApiResponse.error('No response from server'),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      emit(
        state.copyWith(
          apiResponse: ApiResponse.error('An unexpected error occurred'),
        ),
      );
    }
  }
}

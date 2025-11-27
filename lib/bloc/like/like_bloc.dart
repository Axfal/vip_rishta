import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rishta_app/data/response/api_response.dart';

import '../../model/like/liked_profile_model.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(LikeInitial()) {
    on<LikeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

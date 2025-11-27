part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddLikeEvent extends LikeEvent {
  final String userId;
  const AddLikeEvent({required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class RemoveLikeEvent extends LikeEvent {
  final String userId;
  const RemoveLikeEvent({required this.userId});
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class WhoLikesMeEvent extends LikeEvent {
  const WhoLikesMeEvent();
}

class LikedProfileEvent extends LikeEvent {
  const LikedProfileEvent();
}
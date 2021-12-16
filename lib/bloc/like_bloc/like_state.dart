import 'package:equatable/equatable.dart';

abstract class LikeState extends Equatable{}

class LikePutState extends LikeState {
  @override
  List<Object?> get props => [];
}

class LikeEmptyState extends LikeState {
  @override
  List<Object?> get props => [];
}
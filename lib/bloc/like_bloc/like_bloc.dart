import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/like_bloc/like_event.dart';
import 'package:thoughts/bloc/like_bloc/like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc(LikeState initialState) : super(initialState);

  // final LikeRepository? likeRepository;

  // LikeBloc({this.likeRepository}) :assert(likeRepository != null), super(LikeEmptyState());

  LikeState get initialState => LikeEmptyState();

  @override
  Stream<LikeState> mapEventToState(LikeEvent event) async*{
    if(event is LikeButtonPressedEvent) {
      try {
        if (event.isLiked) {
          yield LikePutState();
        } else {
          yield LikeEmptyState();
        }
      } catch (_) {
        throw Exception("Произошла ошибка! Повторите попытку");
      }
    }

  }
}
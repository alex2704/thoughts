abstract class LikeEvent{}

class LikeButtonPressedEvent extends LikeEvent{
  final bool isLiked;

  LikeButtonPressedEvent({required this.isLiked});
}
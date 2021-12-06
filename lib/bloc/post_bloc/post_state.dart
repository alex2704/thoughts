abstract class PostState {}

class PostEmptyState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  List<dynamic> loadedPost;
  PostLoadedState({required this.loadedPost});
}

class PostErrorState extends PostState {}
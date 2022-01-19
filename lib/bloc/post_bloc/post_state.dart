abstract class PostState {}

class PostEmptyState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  List<dynamic> loadedPost;
  List<dynamic> loadedForProfile;
  PostLoadedState({required this.loadedPost, required this.loadedForProfile});
}

class PostErrorState extends PostState {}
abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetLoadingUserDadaState extends SocialStates {}

class SocialGetSuccessUserDadaState extends SocialStates {}

class SocialGetErrorUserDadaState extends SocialStates {
  final String error;

  SocialGetErrorUserDadaState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialReceiveMessageSuccessState extends SocialStates {}

class SocialReceiveMessageErrorState extends SocialStates {
  final String error;

  SocialReceiveMessageErrorState(this.error);
}

class SocialGetLoadingAllUserDadaState extends SocialStates {}

class SocialGetSuccessAllUserDadaState extends SocialStates {}

class SocialGetErrorAllUserDadaState extends SocialStates {
  final String error;

  SocialGetErrorAllUserDadaState(this.error);
}

class SocialGetLoadingPostsState extends SocialStates {}

class SocialGetSuccessPostsState extends SocialStates {}

class SocialGetErrorPostsState extends SocialStates {
  final String error;

  SocialGetErrorPostsState(this.error);
}

class SocialLikeSuccessState extends SocialStates {}

class SocialLikeErrorState extends SocialStates {
  final String error;

  SocialLikeErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialGetProfileImageSuccessState extends SocialStates {}

class SocialGetProfileImageErrorState extends SocialStates {}

class SocialGetCoverImageSuccessState extends SocialStates {}

class SocialGetCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialLoadingUpdateUserState extends SocialStates {}

//post
class SocialPickedPostImageSuccessState extends SocialStates {}

class SocialPickedPostImageErrorState extends SocialStates {}

class SocialPostSuccessState extends SocialStates {}

class SocialPostErrorState extends SocialStates {}

class SocialPostImageSuccessState extends SocialStates {}

class SocialPostImageErrorState extends SocialStates {}

class SocialLoadingPostImageState extends SocialStates {}

class SocialLoadingPostState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

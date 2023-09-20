abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetLoadingUserDadaState extends SocialStates {}

class SocialGetSuccessUserDadaState extends SocialStates {}

class SocialGetErrorUserDadaState extends SocialStates {
  final String error;

  SocialGetErrorUserDadaState(this.error);
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

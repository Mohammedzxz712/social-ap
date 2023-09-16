abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetLoadingUserDadaState extends SocialStates {}

class SocialGetSuccessUserDadaState extends SocialStates {}

class SocialGetErrorUserDadaState extends SocialStates {
  final String error;

  SocialGetErrorUserDadaState(this.error);
}

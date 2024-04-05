abstract class IVideoPlayer<T> {
  T get controller;

  Future<void> play();
  Future<void> pause();
  Future<void> mute();
  Future<void> unMute();
  Future<void> load(String videoId, [bool loop = true]);
}

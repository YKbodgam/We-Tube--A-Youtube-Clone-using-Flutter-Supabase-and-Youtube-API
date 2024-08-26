String? extractVideoId(String url) {
  RegExp regExp = RegExp(
    r"(?:(?:https?:)?\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})",
    caseSensitive: false,
    multiLine: false,
  );
  Match? match = regExp.firstMatch(url);
  return match?.group(1);
}

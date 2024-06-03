String formatNameForBackend(String name) {
  // Trim leading and trailing spaces
  name = name.trim();

  // Replace multiple spaces between first and last names with a single space
  name = name.replaceAll(RegExp(r'\s+'), ' ');

  return name;
}

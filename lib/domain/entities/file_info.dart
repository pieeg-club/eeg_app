/// FileInfo entity
///
/// This entity is used to represent a file information.
class FileInfo {
  /// Constructs a [FileInfo] with the given [name], [path], [extension],
  /// and [size].
  const FileInfo(this._name, this._path, this._extension, this._size);

  final String _name;
  final String _path;
  final String _extension;
  final int _size;

  /// Returns the name of the file.
  String get name => _name;

  /// Returns the path of the file.
  String get path => _path;

  /// Returns the extension of the file.
  String get extension => _extension;

  /// Returns the size of the file.
  int get size => _size;
}

/// A simple singleton that holds the authenticated user's info
/// for the lifetime of the app session.
///
/// Name extraction rules:
///   ALU email  → "firstname.lastname@campus.alustudent.com"
///                  extracts "Firstname Lastname"
///   Gmail      → "firstname.lastname@gmail.com"
///                  extracts "Firstname Lastname"
///   Fallback   → everything before the first '@' or '.'
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  String _email = '';
  String _displayName = '';
  String _firstName = '';

  /// Call this right after the user passes validation.
  void signIn(String email) {
    _email = email.trim().toLowerCase();
    _displayName = _extractName(_email);
    _firstName = _displayName.split(' ').first;
  }

  String get email => _email;

  /// Full name, e.g. "Aline Umuhoza"
  String get displayName => _displayName.isEmpty ? 'Student' : _displayName;

  /// First name only, e.g. "Aline"
  String get firstName => _firstName.isEmpty ? 'Student' : _firstName;

  void signOut() {
    _email = '';
    _displayName = '';
    _firstName = '';
  }

  //  helpers 

  static String _extractName(String email) {
    // Take the local part (before @)
    final local = email.split('@').first;

    // Split on dot or underscore, capitalise each part, join with space
    final parts = local
        .split(RegExp(r'[._]'))
        .where((p) => p.isNotEmpty)
        .map(_capitalise)
        .toList();

    return parts.join(' ');
  }

  static String _capitalise(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
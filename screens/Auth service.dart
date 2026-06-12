/// A simple singleton that holds the authenticated user's info
/// for the lifetime of the app session.
///
/// We used a singleton pattern here to ensure that once a user signed in, 
/// their profile data was consistently accessible across any screen in the app
/// without needing to pass user objects manually through every constructor.
///
/// Name extraction rules:
///    ALU email   → "firstname.lastname@campus.alustudent.com"
///                    extracts "Firstname Lastname"
///    Gmail       → "firstname.lastname@gmail.com"
///                    extracts "Firstname Lastname"
///    Fallback    → everything before the first '@' or '.'
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  String _email = '';
  String _displayName = '';
  String _firstName = '';

  /// Call this right after the user passed validation.
  /// We processed the email here immediately so that the UI could 
  /// show a personalized welcome message as soon as the user logged in.
  void signIn(String email) {
    _email = email.trim().toLowerCase();
    _displayName = _extractName(_email);
    _firstName = _displayName.split(' ').first;
  }

  String get email => _email;

  /// Full name, e.g. "Aline Umuhoza"
  /// Providing a default 'Student' fallback here ensured the UI didn't 
  /// show empty strings if the name extraction failed for any reason.
  String get displayName => _displayName.isEmpty ? 'Student' : _displayName;

  /// First name only, e.g. "Aline"
  /// This was used primarily in our greeting headers to make the app feel
  /// more personal and welcoming for our student users.
  String get firstName => _firstName.isEmpty ? 'Student' : _firstName;

  /// Clears session data. We did this when the user logged out to ensure
  /// that no data from the previous session persisted for the next person.
  void signOut() {
    _email = '';
    _displayName = '';
    _firstName = '';
  }

  //  helpers  

  static String _extractName(String email) {
    // We isolated the local part to focus only on the name portion 
    // and ignored the domain (@alustudent.com or @gmail.com) entirely.
    final local = email.split('@').first;

    // We split by dots or underscores because students often formatted their 
    // emails as "firstname.lastname" or "firstname_lastname". 
    // Mapping these parts allowed us to standardize the display name.
    final parts = local
        .split(RegExp(r'[._]'))
        .where((p) => p.isNotEmpty)
        .map(_capitalise)
        .toList();

    return parts.join(' ');
  }

  /// Capitalises the first letter of each name part.
  /// We did this to ensure that even if a student used all lowercase 
  /// in their email, the app displayed their name with professional casing.
  static String _capitalise(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
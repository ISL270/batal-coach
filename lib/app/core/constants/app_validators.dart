class AppValidators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Name is too short';
    }

    return null; // Return null if display name is valid
  }

  static String? phoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Number cannot be empty';
    }
    if (phoneNumber.length != 11) {
      return 'Number must be 11 number';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    } else if (value!.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  static String? validateZipCode(String? value) {
    final zipCodeRegExp = RegExp(r'^\d{3}-\d{3}$');
    if (value == null || value.isEmpty) {
      return 'Please enter a zip code';
    } else if (!zipCodeRegExp.hasMatch(value)) {
      return 'Invalid zip code format';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }

    final words = value.trim().split(RegExp(r'\s+'));
    if (words.length < 3) {
      return 'Address must contain at least 3 words';
    }

    return null;
  }

  static String? validateCity(String? value) {
    final cityRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter a city name';
    } else if (!cityRegExp.hasMatch(value)) {
      return 'City name can only contain letters and spaces';
    }
    return null;
  }

  static String? validateTwelveDigitNumber(String? value) {
    final digitRegExp = RegExp(r'^\d{4}-\d{4}-\d{4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter a 12-digit number';
    } else if (!digitRegExp.hasMatch(value)) {
      return 'Number must be in the format 1234-5678-9999';
    }
    return null;
  }

  static String? validateExpirationDate(String? value) {
    final dateRegExp = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$');
    if (value == null || value.isEmpty) {
      return 'Please enter an expiration date';
    } else if (!dateRegExp.hasMatch(value)) {
      return 'Expiration date must be in the format MM/YY';
    }
    return null;
  }

  static String? validateCVV(String? value) {
    final cvvRegExp = RegExp(r'^[0-9]{3,4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter a CVV';
    } else if (!cvvRegExp.hasMatch(value)) {
      return 'CVV must be 3 or 4 digits';
    }
    return null;
  }
}

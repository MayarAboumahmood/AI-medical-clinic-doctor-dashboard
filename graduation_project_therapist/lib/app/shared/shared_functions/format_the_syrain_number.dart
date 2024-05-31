String formatSyrianPhoneNumber(String phoneNumber) {
  // Case 1: Number starts with '09' and is 10 digits long
  if (phoneNumber.startsWith('09') && phoneNumber.length == 10) {
    return '963${phoneNumber.substring(1)}';
  }
  // Case 2: Number starts with '9' and is 9 digits long
  else if (phoneNumber.startsWith('9') && phoneNumber.length == 9) {
    return '963$phoneNumber';
  }
  // Case 3: Number already starts with '963' and is 12 digits long
  else if (phoneNumber.startsWith('963') && phoneNumber.length == 12) {
    return phoneNumber;
  }
  // If the phone number doesn't match any of the specific cases
  return '';
}

String formatSyrianPhoneNumberForMakeItStartWIth09(String phoneNumber) {
  if (phoneNumber.startsWith('09') && phoneNumber.length == 10) {
    return phoneNumber;
  } else if (phoneNumber.startsWith('9') && phoneNumber.length == 9) {
    return '0$phoneNumber';
  } else if (phoneNumber.startsWith('963') && phoneNumber.length == 12) {
    return '0${phoneNumber.substring(3)}';
  }
  // If the phone number doesn't match any of the specific cases
  return '';
}

class Validator {

  // Declasre function as static to be used in the form field validator

  // Validator function to validate the participant name
  // This function checks if the name is empty or less than 3 characters
  static String? validateParticipantName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Participant name cannot be empty.';
    }
    if (value.length < 3) {
      return 'Participant name must be at least 3 characters.';
    }
    return null; 
  }
  
  // Validator function to validate the participant bib number
  // This function checks if the bib number is empty or less than 6 characters 'BIB 001'
  static String? validateparticipantBibNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Participant bib number cannot be empty.';
    }
    if (value.length < 6 ) {
      return 'Participant bib number must be at least 6 characters.';
    }
    return null; 
  }

}

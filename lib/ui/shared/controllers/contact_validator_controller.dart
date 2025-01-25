abstract class ContactValidatorController{
  static String? validateName(String name){
    if(name.isEmpty) return 'Name is required';
    if(name.length>100) return 'Name too large';
    return null;
  }
}
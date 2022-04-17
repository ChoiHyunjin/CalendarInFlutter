class StringFormatter{
  static String getFormattedTime(int number){
    return (number < 10 ? '0' : '') + number.toString();
  }
}
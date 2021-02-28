String getDay(int weekday) {
  switch (weekday) {
    case 1:
      return ("monday");
    case 2:
      return ("tuesday");

    case 3:
      return ("wednesday");

    case 4:
      return ("thursday");

    case 5:
      return ("friday");

    case 6:
      return ("saturday");

    case 7:
      return ("sunday");

    default:
      return "";
  }
}

String getMonth(int month) {
  switch (month) {
    case 1:
      return "january";
    case 2:
      return "february";
    case 3:
      return "march";
    case 4:
      return "april";
    case 5:
      return "may";
    case 6:
      return "june";
    case 7:
      return "july";
    case 8:
      return "august";
    case 9:
      return "september";
    case 10:
      return "october";
    case 11:
      return "november";
    case 12:
      return "december";
    default:
      return "";
  }
}

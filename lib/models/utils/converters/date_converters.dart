String getDay(int weekday) {
  switch (weekday) {
    case 1:
      return ("mon");
    case 2:
      return ("tue");

    case 3:
      return ("wed");

    case 4:
      return ("thu");

    case 5:
      return ("fri");

    case 6:
      return ("sat");

    case 7:
      return ("sun");

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

class Util{

  Util();

  String getMonth(String date){
    DateTime aux = DateTime.parse(date);
    String day = "";
    switch(aux.month){
      case 1:
        day = "Ene";
        break;
      case 2:
        day = "Feb";
        break;
      case 3:
        day = "Mar";
        break;
      case 4:
        day = "Abr";
        break;
      case 5:
        day = "May";
        break;
      case 6:
        day = "Jun";
        break;
      case 7:
        day = "Jul";
        break;
      case 8:
        day = "Ago";
        break;
      case 9:
        day = "Set";
        break;
      case 10:
        day = "Oct";
        break;
      case 11:
        day = "Nov";
        break;
      case 12:
        day = "Dic";
        break;
    }
    return day;
  }

  String getDay(String date){
    DateTime aux = DateTime.parse(date);
    String day = "";
    switch(aux.weekday){
      case 1:
        day = "Lun";
        break;
      case 2:
        day = "Mar";
        break;
      case 3:
        day = "Mie";
        break;
      case 4:
        day = "Jue";
        break;
      case 5:
        day = "Vie";
        break;
      case 6:
        day = "Sab";
        break;
      case 7:
        day = "Dom";
        break;
    }
    return day;
  }

}
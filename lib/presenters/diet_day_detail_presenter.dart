

class DietDayDetailPresenter {
  DietDayDetailPresenter();

  setDay(int day){
    String dayName = "";
    switch(day){
      case 1:
        dayName = "Lun";
        break;
      case 2:
        dayName = "Mar";
        break;
      case 3:
        dayName = "Mie";
        break;
      case 4:
        dayName = "Jue";
        break;
      case 5:
        dayName = "Vie";
        break;
      case 6:
        dayName = "Sab";
        break;
      case 7:
        dayName = "Dom";
        break;
    }
    return dayName;
  }

}
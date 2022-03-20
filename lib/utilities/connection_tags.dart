
class ConnectionTags{

  final String baseUrl = "https://fullfeed-aq.herokuapp.com/";

  //Endpoints

  //User
  final String userEndpoint = "user/";
  final String userLogin = "login";
  final String patientRegister = "patient";
  final String doctorRegister = "doctor";

  //Region
  final String regionEndpoint = "region/";
  final String allRegion = "all";

  //Patient
  final String patientEndpoint = "patient/";
  final String getDoctor = "doctor";
  final String successfulDays = "successfulDays";
  final String newNutritionalPlan = "generateDiet";
  final String validateAccessCode = "validateAccessCode";

  //Doctor
  final String doctorEndpoint = "doctor/";
  final String generateAccessCode = "generateAccessCode";
  final String getPatientsByDoctor = "patients";

  //Preferences
  final String preferencesEndpoint = "preferences";

  //Meal
  final String mealEndpoint = "meal/";
  final String weekMealList = "diet-meals";
  final String dayMealList = "day";
  final String alternativeMeals = "alternativeMeals";
  final String completeMeal = "completeMeal";
  final String restoreMeal = "restoreMeal";
  final String replaceMeal = "replaceMeal";

  //NutrionalPlan
  final String nutritionalPlanEndpoint = "nutritionalPlan/";
  final String weightEvolution = "weightEvolution";
  final String consumedBalance = "consumedBalance";
  final String createNewNutritionalPlan = "createNewNutritionalPlan";


}
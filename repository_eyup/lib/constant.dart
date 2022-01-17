
class Constant{
  static String accessToken="";
  static String userName = "";
  static String name="";
  static String surname="";
  static String image="";
  static int userId =0;
  static String baseUrl = "http://78.111.98.76:5241/";

  // Register
  static String login = "Home/Login";
  static String register = "Home/Register";
  static String getCounties = "Home/GetCounties";
  static String getCities = "Home/GetCities";

  //Games
  static String getGamesNoFilter = "Games/GetGames";
  static String getGameDetail = "Games/GetGameDetail";
  static String getGameUsers = "Games/GetGameUsers";
  static String getGameComments = "Games/GetGameComments";
  static String writeGameComment = "Games/WriteGameComment";

  // oyuna gir - çık
  static String joinGame = "Games/JoinGame";
  static String quitGame = "Games/QuitGame";
  // Account
  static String getMyUser = "Account/GetMyUserProfile";
  static String getUserProfile = "Account/GetUserProfile";
  static String updateEmail = "Account/UpdateEmail";
  static String updatePassword = "Account/UpdatePassword";
  static String getUsersAttendingMatchs = "Account/GetUsersAttendingMatchs";
  static String getUsersPlayedMatchs = "Account/GetUsersPlayedMatchs";
  static String getMyFollowers = "Account/GetMyFollowers";
  static String getFollowingUsers = "Account/GetFollowingUsers";
  static String follow = "Account/Follow";
  // Venue
  static String getVenues = "Venue/GetVenues";
  static String getVenueDetail = "Venue/GetVenueDetail";
  static String venueFollow = "Venue/VenueFollow";
  static String getUpComingGames = "Venue/GetUpComingGames";
  static String getVenueComments = "Venue/GetVenueComments";
  static String rateVenue = "Venue/RateVenue";
  static String getVenueRates = "Venue/GetVenueRates";
  static String addVenueComment = "Venue/AddVenueComment";
  //Wallet
  static String getUserBalance = "Payment/GetUserBalance";
  static String getPaymentLogs = "Payment/GetPaymentLogs";

  //Message
  static String getMyChatList = "Chat/GetMyChatList";
  static String getMyChat = "Chat/GetMyChat";
  static String sendMessage = "Chat/SendMessage";

}

class Constant{
  static String accessToken="";
  static String userName = "";
  static String name="";
  static String surname="";
  static String image="";
  static int userId =0;
  static String baseUrl = "http://80.93.213.244:5241/";

  // Register
  static String login = "Home/Login";
  static String help = "Support/Help";
  static String register = "Home/Register";
  static String getCounties = "Home/GetCounties";
  static String getCities = "Home/GetCities";

  //Games
  static String getGamesNoFilter = "Games/GetGames";
  static String createGame = "Games/CreateGame";
  static String getGameDetail = "Games/GetGameDetail";
  static String getGameUsers = "Games/GetGameUsers";
  static String getGameComments = "Games/GetGameComments";
  static String writeGameComment = "Games/WriteGameComment";

  // oyuna gir - çık
  static String joinGame = "Games/JoinGame";
  static String joinGameRequest = "Games/JoinGameRequest";
  static String quitGame = "Games/QuitGame";

  // şifremi unuttum
  static String lostMyPassword ="Home/LostMyPassword";
  static String resetMyPassword ="Home/ResetMyPassword";
  // Account
  static String getMyUser = "Account/GetMyUserProfile";
  static String getUserProfile = "Account/GetUserProfile";
  static String updateEmail = "Account/UpdateEmail";
  static String updatePassword = "Account/UpdatePassword";
  static String getUsersAttendingMatchs = "Account/GetUsersAttendingMatchs";
  static String getUsersPlayedMatchs = "Account/GetUsersPlayedMatchs";
  static String getMyFollowers = "Account/GetMyFollowers";
  static String getFollowingUsers = "Account/GetFollowingUsers";
  static String settings = "Account/Settings";
  static String updateImage = "Account/UploadImage";
  static String follow = "Account/Follow";
  static String checkFollow = "Account/CheckFollow";
  static String getMyRole = "Account/GetMyRole";
  static String blockUser = "Account/BlockUser";
  static String removeBlockUser = "Account/RemoveBlockUser";
  static String createOrganizer = "Account/OrganizerForm";
  static String sendAComplaint = "Account/SendAComplaint";
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
  static String checkTCKNO = "Payment/CheckTCKNO";
  static String setTc = "Payment/TCKNO";
  static String payment = "MobilPayment/Payment";
  static String getPaymentLogs = "Payment/GetPaymentLogs";

  //Message
  static String getMyChatList = "Chat/GetMyChatList";
  static String getMyChat = "Chat/GetMyChat";
  static String sendMessage = "Chat/SendMessage";

  //firebase
  static String sendGuid = "FireBase/SendGuid";
  static String sendLocation = "FireBase/SendLocation";

}
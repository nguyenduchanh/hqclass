class AppUrl {
  static const String liveBaseUrl = "https://shiny-awful-wildebeast.gigalixirapp.com/api/v1";
  static const String localBaseUrl = "http://10.0.2.2:4000/api/v1";
  static const String baseURL = liveBaseUrl;
  static const String login = baseURL + "/session";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";
}
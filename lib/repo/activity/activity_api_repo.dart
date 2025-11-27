abstract class ActivityApiRepo {
  /// Match
  Future<dynamic> suggestedMatch();
  Future<dynamic> partnerPreference(dynamic data);

  /// Contact
  Future<dynamic> sendContact({dynamic data, required String requestedId});
  Future<dynamic> receivedContactRequests();
  Future<dynamic> cancelRequest({dynamic data, required String requestedId});
  Future<dynamic> getSentRequest(dynamic data);
  Future<dynamic> getSenContactRequestList();
  Future<dynamic> approveContactRequest({dynamic data, required String requestedId});
}

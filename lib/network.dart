import 'dart:convert';
import 'package:http/http.dart';
import 'package:mockva/screens/login_screen.dart';

class Network {
  LoginScreen loginScreen = LoginScreen();
  String apiKey = '6aa6160d-2720-4080-8673-5dbbd482d4fe';
  String secretKey =
      '2c68m66b9j97b2ffptvxebjy9vov5f8lhgk93g5jhgkqx4i58524o3j713cit3xz';
  String? username;
  String? password;
  String dataId = '';

  Future loginAuth(username, password) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$apiKey:$secretKey'))}';
    Response r = await post(
      Uri.parse('https://mockva.daksa.co.id/mockva-rest/rest/auth/login'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    var statusCode = r.statusCode;
    String data = r.body;
    if (statusCode == 200) {
      return json.decode(data);
    } else {
      print(statusCode);
    }
  }

  Future accountDetail(sessionId, accountId) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$apiKey:$secretKey'))}';
    Response r = await get(
      Uri.https('mockva.daksa.co.id', '/mockva-rest/rest/account/detail/',
          {'id': accountId}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
        "_sessionId": sessionId
      },
    );

    String data = r.body;
    var statusCode = r.statusCode;
    if (statusCode == 200) {
      return json.decode(data);
    } else {
      print(statusCode);
    }
  }

  Future transferInq(
      accountSourceId, accountDestinationId, amount, sessionId) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$apiKey:$secretKey'))}';
    Response r = await post(
      Uri.parse(
          'https://mockva.daksa.co.id/mockva-rest/rest/account/transaction/transferInquiry'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
        "_sessionId": sessionId
      },
      body: jsonEncode({
        "accountSrcId": accountSourceId,
        "accountDstId ": accountDestinationId,
        "amount": amount
      }),
    );

    String data = r.body;
    var statusCode = r.statusCode;
    if (statusCode == 200) {
      return json.decode(data);
    } else {
      print('$statusCode : ' + data);
    }
  }

  Future transferSuccess(accountSourceId, accountDestinationId, amount,
      inquiryId, sessionId) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$apiKey:$secretKey'))}';
    Response r = await post(
      Uri.parse(
          'https://mockva.daksa.co.id/mockva-rest/rest/account/transaction/transfer'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
        "_sessionId": sessionId
      },
      body: jsonEncode({
        "accountSrcId": accountSourceId,
        "accountDstId ": accountDestinationId,
        "amount": amount,
        "inquiryId": inquiryId
      }),
    );

    String data = r.body;
    var statusCode = r.statusCode;
    if (statusCode == 200) {
      return json.decode(data);
    } else {
      print('$statusCode :' + data);
    }
  }

  Future accountHistory(accountId, sessionId) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$apiKey:$secretKey'))}';
    Response r = await get(
      Uri.https('mockva.daksa.co.id',
          '/mockva-rest/rest/account/transaction/log/fetch', {'id': accountId}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
        "_sessionId": sessionId
      },
    );

    String data = r.body;
    var statusCode = r.statusCode;
    if (statusCode == 200) {
      return json.decode(data);
    } else {
      print(statusCode);
    }
  }

  Future logOut(sessionId) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$apiKey:$secretKey'))}';
    Response r = await delete(
      Uri.parse('https://mockva.daksa.co.id/mockva-rest/rest/auth/logout'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
        "_sessionId": sessionId
      },
    );

    String data = r.body;
    var statusCode = r.statusCode;
    if (statusCode == 200) {
      return json.decode(data);
    } else {
      print(statusCode);
    }
  }
}

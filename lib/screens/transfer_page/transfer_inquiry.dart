import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockva/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferInquiry extends StatefulWidget {
  const TransferInquiry({Key? key}) : super(key: key);

  @override
  State<TransferInquiry> createState() => _TransferInquiryState();
}

class _TransferInquiryState extends State<TransferInquiry> {
  Network network = Network();
  String? textAlert = '';
  String? transInq = '';
  String? accountSourceId = '';
  String? accountDestination = '';
  String? amount = '';
  double? balance = 0;
  String? sessionId = '';
  String? alertText = '';
  String? inqId = '';
  String? accountSrcName = '';
  String? accountDstName = '';
  double? transfAmount = 0;

  Future getPreference() async {
    final pref = await SharedPreferences.getInstance();
    sessionId = pref.getString('id');
    accountSourceId = pref.getString('accountId');
    balance = pref.getDouble('balance');
  }

  Future setPreferences() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('accountSrcId', accountSourceId!);
    await pref.setString('accountDstId', accountDestination!);
    await pref.setString('inquiryId', inqId!);
    await pref.setString('accountSrcName', accountSrcName!);
    await pref.setString('accountDstName', accountDstName!);
    await pref.setDouble('amount', transfAmount!);
    setState(() {});
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      content: Text('Account Not Found.'),
      actions: [],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPreference(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'TRANSFER',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  ' Account Destination',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black)),
                  color: Colors.white,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        onChanged: (valueId) {
                          accountDestination = valueId;
                        }),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  ' Amount',
                  style: TextStyle(fontSize: 20),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.black),
                  ),
                  color: Colors.white,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: TextFormField(
                      onChanged: (valueNum) {
                        amount = valueNum;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade600),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        print('Source Account ID :$accountSourceId');
                        print('Source Destination ID : $accountDestination');
                        print('Amount : $amount');
                        print('Session ID : $sessionId');
                        final transInq = await network.transferInq(
                          accountSourceId,
                          accountDestination,
                          amount,
                          sessionId,
                        );
                        if (transInq == null) {
                          showAlertDialog(context);
                        } else {
                          transfAmount = transInq['amount'];
                          accountDstName = transInq['accountDstName'];
                          accountSrcName = transInq[accountSrcName];
                          accountSourceId = transInq['accountSrcId'];
                          accountDestination = transInq['accountDstId'];
                          inqId = transInq['inquiryId'];
                          setPreferences();
                          Navigator.pushNamed(context, 'transfer_confirm');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      'Transfer',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

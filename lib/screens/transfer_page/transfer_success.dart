import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network.dart';

class TransferSuccess extends StatefulWidget {
  const TransferSuccess({Key? key}) : super(key: key);

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {
  Network network = Network();
  String? accountSourceId = '';
  String? accountDestination = '';
  String? inqId = '';
  String? accountSrcName = '';
  String? accountDstName = '';
  double? transfAmount = 0;
  String? sessionId = '';
  String? clientRef = '';
  String? transactionTimestamp = '';

  Future getPreferences() async {
    final pref = await SharedPreferences.getInstance();
    accountSourceId = pref.getString('accountSrcId');
    accountDestination = pref.getString('accountDstId');
    inqId = pref.getString('inquiryId');
    accountSrcName = pref.getString('accountSrcName');
    accountDstName = pref.getString('accountDstName');
    transfAmount = pref.getDouble('amount');
    sessionId = pref.getString('id');
    transactionTimestamp = pref.getString('transactionTimestamp');
    clientRef = pref.getString('clientRef');
  }

  Future setPreferences() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('transactionTimestamp', transactionTimestamp!);
    await pref.setString('clientRef', clientRef!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
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
                'Account Source',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                '$accountSourceId',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Account Source Name',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                '$accountSrcName',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Account Destination',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                '$accountDestination',
                style: const TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Account Destination Name',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              Text(
                '$accountDstName',
                style: const TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Amount',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$transfAmount',
                style: const TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Reference Number',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$inqId',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Transaction Timestamp',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$transactionTimestamp',
                style: const TextStyle(
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Status',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'SUCCESS',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

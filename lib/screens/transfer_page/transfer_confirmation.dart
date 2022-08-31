import 'package:flutter/material.dart';
import 'package:mockva/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransferConfirmation extends StatefulWidget {
  const TransferConfirmation({Key? key}) : super(key: key);

  @override
  State<TransferConfirmation> createState() => _TransferConfirmationState();
}

class _TransferConfirmationState extends State<TransferConfirmation> {
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
  }

  Future setPreferences() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('transactionTimestamp', transactionTimestamp!);
    await pref.setString('clientRef', clientRef!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreferences(),
        builder: ((context, _) => Scaffold(
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
                        ' Account Source',
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '$accountSourceId',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        ' Account Source Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Source Sans Pro',
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.black)),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '$accountSrcName',
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        ' Account Destination',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Source Sans Pro',
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.black)),
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '$accountDestination',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        ' Account Destination Name',
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '$accountDstName',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '$transfAmount',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
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
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.grey.shade600),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                            onPressed: () async {
                              final transferData =
                                  await network.transferSuccess(
                                accountSourceId,
                                accountDestination,
                                transfAmount,
                                inqId,
                                sessionId,
                              );
                              clientRef = transferData['clientRef'];
                              transactionTimestamp =
                                  transferData['transactionTimestamp'];
                              setPreferences();

                              Navigator.pushNamed(context, 'transfer_success');
                            },
                            child: const Text(
                              'Confirm',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}

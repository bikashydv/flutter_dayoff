import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dayoff/logic/company_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  final String companyId;
  const UserProfile(this.companyId, {super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

final TextEditingController _CompanyNameController = TextEditingController();
final TextEditingController _CompanyEmailController = TextEditingController();

class _UserProfileState extends State<UserProfile> {
  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<CompanyProfile>(context).loadProfile(widget.companyId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompanyProfile>(builder: (context, authprovider, _) {
        if (authprovider.companyModel == null) {
          return CircularProgressIndicator();
        } else {
          _CompanyNameController.text =
              '${authprovider.companyModel!.company_name}';
          _CompanyEmailController.text =
              '${authprovider.companyModel!.email}';

          return Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('Company Name'),
                ),
                Container(
                  child: TextField(
                    controller: _CompanyNameController,
                    decoration: InputDecoration(
                      hintText: 'CompanyName',
                      // labelText: 'CompanyName',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text('Company Email'),
                ),
                Container(
                  child: TextField(
                    controller: _CompanyEmailController,
                    decoration: InputDecoration(
                      hintText: 'CompanyEmail',
                      // labelText: 'CompanyName',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'ok',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 25),
                      )),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

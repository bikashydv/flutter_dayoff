import 'package:dayoff/screens/dashboard/requestholiday_page.dart';
import 'package:dayoff/screens/dashboard_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/holiday_request_provider.dart';
import '../../model/holidayRequestmodel.dart';
import 'package:intl/intl.dart';

dateformate(DateTime d) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(d);

  return formattedDate;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

class DashPage extends StatefulWidget {
  final String companyId;
  const DashPage(this.companyId, {Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _dashPageState();
}

class _dashPageState extends State<DashPage> {
  List<HolidayRequestModel> holidays = [];
  @override
  void initState() {
    super.initState();
    getHolidaysData();
  }

  void getHolidaysData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HolidayRequestProvider>(context, listen: false)
          .getRequestedHolidays()
          .then((value) {
        // holidays = value;
        setState(() {
          holidays = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<HolidayRequestProvider>(context , listen: false)

    //     .getRequestedHolidays()
    //     .then((value) {
    //   holidays = value;
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text('holidaylist'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(widget.companyId)));
              },
              icon: Icon(Icons.person))
        ],
        //  IconButton(onPressed: (){}, icon: Icon(Icons.person)) ,
        // automaticallyImplyLeading: false,  ////  to remove  back < button ////
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Column(
            children: [
              holidays.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: holidays.length,
                      itemBuilder: (context, index) {
                        // print(holidays[]);
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text('Bikash'),
                                  ),
                                  Container(
                                    child: Text(
                                        dateformate(holidays[index].starttime),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        )),
                                  ),
                                  Container(
                                    child: Text(
                                      dateformate(holidays[index].endtime),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      daysBetween(holidays[index].starttime,
                                              holidays[index].endtime)
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: TextButton(
                                    onPressed: () {},
                                    child: holidays[index].status == true
                                        ? Text('Accepted')
                                        : Text('Pending')),
                              ),
                            ),
                          ],
                        );
                        //  Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         child: Text(holidays[index].starttime.toString()),
                        //       ),
                        //       Container(
                        //         child: Text(holidays[index].endtime.toString()),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                    )
                  : SizedBox(),
              TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestHoliday(),
                      ),
                    );
                    getHolidaysData();
                  },
                  child: Text('Request New'))
            ],
          ),
        ),  
      ),    
    );
  }
}

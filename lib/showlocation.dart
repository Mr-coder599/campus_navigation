import 'package:campus_app/Dashboard.dart';
import 'package:campus_app/NavigationScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowLocations extends StatefulWidget {
  final User user;
  const ShowLocations({Key? key, required this.user}) : super(key: key);

  @override
  State<ShowLocations> createState() => _ShowLocationsState();
}

class _ShowLocationsState extends State<ShowLocations> {
  Future getLocation() async {
    var firestor = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestor.collection("schoollocation").get();
    return qn.docs;
  }

  NavigateToDetail(DocumentSnapshot locationdetails) {
    //   User user;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationDetails(
                  locationdetails: locationdetails,
                  user: widget.user,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All available locations'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserDashboard(user: widget.user)));
          },
          icon: Icon(Icons.backspace_rounded),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getLocation(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('loading..'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data[index].data()['lname'],
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      onTap: () => NavigateToDetail(snapshot.data[index]),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class LocationDetails extends StatefulWidget {
  final User user;
  const LocationDetails(
      {Key? key, required this.locationdetails, required this.user})
      : super(key: key);
  final DocumentSnapshot locationdetails;
  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: ListTile(
          subtitle: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Location' + '         ' + widget.locationdetails['lname'],
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Text(widget.locationdetails['lname']),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Longitude',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.locationdetails['longitude']),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        copyToClipboards(context);
                      },
                      child: Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Latitude',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        copyToClipboards(context);
                      },
                      child: Text(
                        widget.locationdetails['latitude'],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        // copyToClipboard(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NavigationScreen(
                                double.parse(
                                    widget.locationdetails['longitude']),
                                double.parse(
                                    widget.locationdetails['latitude']),
                                widget.user)));
                      },
                      child: Text(
                        'Get Direction',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void copyToClipboard(BuildContext context) {
    // void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.locationdetails['latitude']));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'latitude to clipboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  void copyToClipboards(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.locationdetails['longitude']));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }
}

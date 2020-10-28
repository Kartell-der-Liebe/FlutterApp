import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RSSReader extends StatefulWidget {
  RSSReader() : super();

  // Setting title for the action bar.
  final String title = 'Festival News';

  @override
  RSSReaderState createState() => RSSReaderState();
}

class RSSReaderState extends State<RSSReader> {
  // Feed URL being used for the app. In this case is the Hacker News job feed.
  static const String FEED_URL = 'https://eineliebe.de/feed/';

  RssFeed _feed; // RSS Feed Object
  String _title; // Place holder for appbar title.

  // Notification Strings
  static const String loadingMessage = 'Loading Feed...';
  static const String feedLoadErrorMessage = 'Error Loading Feed.';
  static const String feedOpenErrorMessage = 'Error Opening Feed.';

  // Key for the RefreshIndicator
  // See the documentation linked below for info on the RefreshIndicatorState
  // class and the GloablKey class.
  // https://api.flutter.dev/flutter/widgets/GlobalKey-class.html
  // https://api.flutter.dev/flutter/material/RefreshIndicatorState-class.html
  GlobalKey<RefreshIndicatorState> _refreshKey;

  // Method to change the title as a way to inform the user what is going on
  // while retrieving the RSS data.
  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  // Method to help refresh the RSS data.
  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  // Method to navigate to the URL of a RSS feed item.
  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMessage);
  }

  // Method to load the RSS data.
  load() async {
    updateTitle(loadingMessage);
    loadFeed().then((result) {
      if (null == result || result
          .toString()
          .isEmpty) {
        // Notify user of error.
        updateTitle(feedLoadErrorMessage);
        return;
      }
      // If there is no error, load the RSS data into the _feed object.
      updateFeed(result);
      // Reset the title.
      updateTitle("Festival News");
    });
  }

  // Method to get the RSS data from the provided URL in the FEED_URL variable.
  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      // handle any exceptions here
    }
    return null;
  }

  // When the app is initialized, we setup our GlobalKey, set our title, and
  // call the load() method which loads the RSS feed and UI.
  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  // Method to check if the RSS feed is empty.
  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  // Method for the pull to refresh indicator and the actual ListView UI/Data.
  body() {
    return isFeedEmpty()
        ? Center(
      child: CircularProgressIndicator(),
    )
        : RefreshIndicator(
      key: _refreshKey,
      child: list(),
      onRefresh: () => load(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: body(),
      ),
    );
  }

  // ==================== ListView Components ====================

  // ListView
  // Consists of two main widgets. A Container Widget displaying info about the
  // RSS feed and the ListView containing the RSS Data. Both contained in a
  // Column Widget.
  list() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: ListView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: _feed.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _feed.items[index];
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: title(item.title),
                      subtitle: subtitle(item.pubDate),
                      trailing: rightIcon(),
                      contentPadding: EdgeInsets.all(5.0),
                      onTap: () => openFeed(item.link),
                    ),
                  );
                },
              ),
            ),
          ),
        ]);
  }

  // Method that returns the Text Widget for the title of our RSS data.
  title(title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.black38),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Method that returns the Text Widget for the subtitle of our RSS data.
  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
          color: Colors.black38),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Method that returns Icon Widget.
  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.black38,
      size: 30.0,
    );
  }

  // Custom box decoration for the Container Widgets.
  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black38, // border color
        width: 1.0,
      ),
    );
  }

// ====================  End ListView Components ====================
}
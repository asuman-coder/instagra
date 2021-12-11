import 'package:flutter/material.dart';
import 'package:instagra/models/object.dart';
import 'package:instagra/models/post.dart';
import 'package:instagra/models/story.dart';
import 'package:instagra/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:instagra/services/database.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Story> _stories = [
    Story(
        "https://images.pexels.com/photos/5119203/pexels-photo-5119203.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Asman"),
    Story(
        "https://images.pexels.com/photos/5119213/pexels-photo-5119213.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Paul"),
    Story(
        "https://images.pexels.com/photos/1405822/pexels-photo-1405822.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Arthur"),
    Story(
        "https://images.pexels.com/photos/1115697/pexels-photo-1115697.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Nancha"),
    Story(
        "https://images.pexels.com/photos/1975879/pexels-photo-1975879.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Halima"),
    Story(
        "https://images.pexels.com/photos/2085805/pexels-photo-2085805.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Abdalla"),
    Story(
        "https://images.pexels.com/photos/1918084/pexels-photo-1918084.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Alisa"),
    Story(
        "https://images.pexels.com/photos/1893075/pexels-photo-1893075.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Sofina"),
    Story(
        "https://images.pexels.com/photos/2005744/pexels-photo-2005744.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Quinter"),
    Story(
        "https://images.pexels.com/photos/1852751/pexels-photo-1852751.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Shariff"),
    Story(
        "https://images.pexels.com/photos/2379523/pexels-photo-2379523.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        "Standout"),
  ];

  List<Post> posts = [
    Post(
      username: "Namianya",
      userImage:
          "https://s3.amazonaws.com/uifaces/faces/twitter/felipecsl/128.jpg",
      postImage:
          "https://images.pexels.com/photos/247298/pexels-photo-247298.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
    Post(
      username: "Wancha",
      userImage: "https://s3.amazonaws.com/uifaces/faces/twitter/kevka/128.jpg",
      postImage:
          "https://images.pexels.com/photos/169191/pexels-photo-169191.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
    Post(
      username: "Allela",
      userImage:
          "https://s3.amazonaws.com/uifaces/faces/twitter/ionuss/128.jpg",
      postImage:
          "https://images.pexels.com/photos/1252983/pexels-photo-1252983.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
    Post(
      username: "Cham",
      userImage:
          "https://s3.amazonaws.com/uifaces/faces/twitter/vinciarts/128.jpg",
      postImage:
          "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
    Post(
      username: "Winnie",
      userImage:
          "https://s3.amazonaws.com/uifaces/faces/twitter/ssiskind/128.jpg",
      postImage:
          "https://images.pexels.com/photos/291762/pexels-photo-291762.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
    Post(
      username: "Denno",
      userImage: "https://s3.amazonaws.com/uifaces/faces/twitter/areus/128.jpg",
      postImage:
          "https://images.pexels.com/photos/884979/pexels-photo-884979.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
    Post(
      username: "Amon",
      userImage:
          "https://s3.amazonaws.com/uifaces/faces/twitter/oskarlevinson/128.jpg",
      postImage:
          "https://images.pexels.com/photos/302769/pexels-photo-302769.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      caption: "Allah Akbar",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // to access data from the firestore stream
    final posts = Provider.of<List<Post>>(context) ?? [];
    final user = Provider.of<Object>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Stories',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            'Watch All',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      height: 110,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: _stories.map((story) {
                          return Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(
                                    2,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image(
                                      image: NetworkImage(story.image),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(story.name),
                            ],
                          );
                        }).toList(),
                      ),
                    ),

                    //posts
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (ctx, i) {
                          return Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image(
                                              image: NetworkImage(
                                                //posts[i].userImage,
                                                userData.userImage,
                                              ),
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            // posts[i].username
                                            userData.username,
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.more_horiz),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage(
                                    image: NetworkImage(
                                      // posts[i].postImage,
                                      userData.postImage,
                                    ),
                                    placeholder:
                                        AssetImage("assets/placeholder.png"),
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite_border),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.maps_ugc),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.send),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bookmark),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: RichText(
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Liked By",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Wekesa,",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Asman,",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Muhud",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "and",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "456 others",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //caption
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 5,
                                  ),
                                  child: RichText(
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          // text: posts[i].username,
                                          text: userData.username,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          // text: " ${posts[i].caption}",
                                          text: userData.caption,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // post date
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 14.0,
                                  ),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "September 2020",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

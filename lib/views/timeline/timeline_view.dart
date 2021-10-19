import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class TimeLine_View extends StatelessWidget {
  const TimeLine_View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Timeline",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(UniconsLine.plus_square),
              color: Theme.of(context).iconTheme.color,
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          children: [
            Card(
                elevation: 0,
                color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).iconTheme.color,
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/9741840/pexels-photo-9741840.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                      ),
                      title: Text(
                        'Nadia Browne',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Text(
                        'a minute ago',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_horiz,
                            color: Theme.of(context).iconTheme.color),
                      ),
                    ),
                    Text("This is an image of Ghana\'s most beautiful queen."),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://images.pexels.com/photos/7638963/pexels-photo-7638963.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                UniconsLine.thumbs_up,
                                // size: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                UniconsLine.comment_chart_line,
                                // size: 10,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          UniconsLine.telegram_alt,
                          // size: 10,
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}

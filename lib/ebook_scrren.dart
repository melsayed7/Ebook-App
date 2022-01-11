
import 'dart:convert';
import 'package:ebook_app/app_colors.dart' as AppColors;
import 'package:ebook_app/audio_screen.dart';
import 'package:ebook_app/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EBookScreen extends StatefulWidget {
  const EBookScreen({Key? key}) : super(key: key);

  @override
  _EBookScreenState createState() => _EBookScreenState();
}

class _EBookScreenState extends State<EBookScreen> with SingleTickerProviderStateMixin {

   List? popularBooks ;
   List? books ;
   ScrollController? scrollController;
   TabController? tabController;

  ReadData()async{
    await DefaultAssetBundle.of(context).loadString('json/popularBooks.json')
        .then((value){
          setState(() {
            popularBooks = json.decode(value);
          });
    });

    await DefaultAssetBundle.of(context).loadString('json/books.json')
        .then((value){
      setState(() {
        books = json.decode(value);
      });
    });
  }
  @override
  void initState()
  {
    super.initState();
    tabController =TabController(length: 3, vsync: this);
    scrollController = ScrollController();
    ReadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20.0,right: 20.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ImageIcon(
                          AssetImage('assets/images/menu.png'),
                        size: 24,
                        color: Colors.black,
                      ),
                      //Icon(Icons.menu),
                      Row(
                        children:
                        const [
                          Icon(Icons.search),
                          SizedBox(width: 10.0,),
                          Icon(Icons.notifications_active),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0,),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: const Text(
                          'Popular Books',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: PageController(viewportFraction: .9),
                            itemCount: popularBooks == null ? 0 : popularBooks!.length,
                            itemBuilder: (_,index)
                            {
                              return Container(
                                height: 180,
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image:  DecorationImage(
                                    image: AssetImage(popularBooks![index]['img']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: NestedScrollView(
                      controller: scrollController,
                      headerSliverBuilder: (BuildContext context, bool isScrolled)
                      {
                        return [
                          SliverAppBar(
                            pinned: true,
                            backgroundColor: AppColors.sliverBackground,
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(50),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20 , left: 15),
                                child: TabBar(
                                  indicatorPadding: const EdgeInsets.all(0) ,
                                  indicatorSize: TabBarIndicatorSize.label ,
                                  labelPadding:const EdgeInsets.only(right: 10) ,
                                  controller: tabController,
                                  isScrollable: true,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color:Colors.grey.withOpacity(.2),
                                        blurRadius: 7,
                                        offset: const Offset(0,0),
                                      ),
                                    ],
                                  ),
                                  tabs: [
                                    AppTabs(color: AppColors.menu1Color,text: 'New',),
                                    AppTabs(color: AppColors.menu2Color,text: 'Popular',),
                                    AppTabs(color: AppColors.menu3Color,text: 'Trending',),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        controller: tabController,
                        children: [
                          ListView.builder(
                            itemCount: books == null ? 0 : books!.length,
                            itemBuilder: (_, index)
                          {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                  MaterialPageRoute(builder:(context) =>  AudioScreen(booksData: books,index:index),),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(0,0),
                                        color: Colors.grey.withOpacity(.2),

                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image:  DecorationImage(
                                              image: AssetImage(books![index]['img']),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star ,
                                                  size: 24,
                                                  color: AppColors.starColor,
                                                ),
                                                const SizedBox(width: 5.0,),
                                                Text(
                                                  books![index]['rating'],
                                                  style: TextStyle(
                                                    color: AppColors.menu2Color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              books![index]['title'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Avenir',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              books![index]['text'],
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 15.0,),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 60,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: AppColors.loveColor,
                                              ),
                                              child: const Text(
                                                'Love',
                                                style:  TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          ),
                          Material(
                            child: ListTile(
                              onTap: (){},
                              leading: const CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: const Text('content'),
                            ),
                          ),
                          Material(
                            child: ListTile(
                              onTap: (){},
                              leading: const CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: const Text('content'),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


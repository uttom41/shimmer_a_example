import 'package:flutter/material.dart';
import 'package:shimmer_a/shimmer_a.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer_a Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeShimmer(),
    );
  }
}

class HomeShimmer extends StatefulWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  State<HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<HomeShimmer> {
  bool _isLoading = true;
  List<String> data=[];
  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async{
    data = await getAPIData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ShimmerA example"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ShimmerA(
              shimmerCount: 35,
              isShimmer: _isLoading,
              shimmerAxis: Axis.horizontal,
              shimmerWidget: const [
                ShimmerWidget(
                  height: 50,
                  width: 50,
                  radius: 50,
                ),
              ],
              child: ListView.builder(
                itemCount:data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 40,
                      child: ClipOval(
                        child: Image.asset(
                          data[index],
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ShimmerA(
                    shimmerCount: 5,
                    isShimmer: _isLoading,
                    shimmerWidget: [
                      ShimmerWidget(
                        height: 150,
                        width: MediaQuery.of(context).size.width/2-14,
                        radius: 15,
                      ),
                      ShimmerARow(
                          children: [
                            const ShimmerWidget(
                              height: 50,
                              width: 50,
                              radius: 50,
                            ),
                            ShimmerWidget(
                              height: 24,
                              width: MediaQuery.of(context).size.width / 4,
                              radius: 8,
                            )
                          ]
                      ),
                      ShimmerWidget(
                        height: 24,
                        width: MediaQuery.of(context).size.width / 4,
                        radius: 8,
                        margin: const EdgeInsets.only(left: 8),
                      ),
                    ],
                    child: ListView.builder(
                      itemCount:data.length,
                      itemBuilder: (context, index) {
                        return CardListItem(imagePath:data[index]);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ShimmerA(
                    shimmerCount: 5,
                    isShimmer: _isLoading,
                    ownGradient: LinearGradient(
                        colors: [
                               Color(0xEC212105),
                               Color(0x4299EFFF),
                               Color(0x5B191905),
                             ],
                             stops: [0.0, 0.5, 1.0],
                             begin: Alignment.centerRight,
                             end: Alignment.centerLeft,
                             tileMode: TileMode.clamp,
                    ),
                    shimmerWidget: [
                      ShimmerWidget(
                        height: 150,
                        width: MediaQuery.of(context).size.width/2-14,
                        radius: 15,
                      ),
                      ShimmerWidget(
                        height: 24,
                        width: MediaQuery.of(context).size.width / 3,
                        radius: 8,
                      ),
                      ShimmerWidget(
                        height: 24,
                        width: MediaQuery.of(context).size.width / 4,
                        radius: 8,
                        margin: const EdgeInsets.only(left: 8),
                      ),
                    ],
                    child: ListView.builder(
                      itemCount:data.length,
                      itemBuilder: (context, index) {
                        return CardListItem(imagePath:data[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isLoading = !_isLoading;
          });
        },
        child: Icon(
          _isLoading ? Icons.hourglass_full : Icons.hourglass_bottom,
        ),
      ),
    );
  }

  Future<List<String>> getAPIData() async {
    await Future.delayed(const Duration(seconds: 10));
    List<String> imagePath = [
      "images/pexels-kaique-rocha-775203.jpg",
      "images/pexels-max-andrey-1366630.jpg",
      "images/pexels-todd-trapani-1535162.jpg",
      "images/pexels-kaique-rocha-775203.jpg",
      "images/pexels-max-andrey-1366630.jpg",
      "images/pexels-todd-trapani-1535162.jpg",
      "images/pexels-kaique-rocha-775203.jpg",
      "images/pexels-max-andrey-1366630.jpg",
      "images/pexels-todd-trapani-1535162.jpg",
      "images/pexels-kaique-rocha-775203.jpg",
      "images/pexels-max-andrey-1366630.jpg",
      "images/pexels-todd-trapani-1535162.jpg",
    ];
    setState(() {
      _isLoading = !_isLoading;
    });
    return imagePath;
  }
}

class CardListItem extends StatelessWidget {
  final String imagePath;
  const CardListItem({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(imagePath),
          const SizedBox(height: 16),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildImage(String path) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(path, fit: BoxFit.cover,),
        ),
      ),
    );
  }

  Widget _buildText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'Show some text.',
      ),
    );
  }
}

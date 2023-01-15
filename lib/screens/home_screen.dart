import 'package:colorful_background/colorful_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_shortner/methods/shorten_url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController longUrlController = TextEditingController();
    TextEditingController customUrlController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: ColorfulBackground(
          duration: const Duration(milliseconds: 1500),
          backgroundColors: const [
            Color(0xFFFF5ACD),
            Color(0xFFFBDA61),
            Color(0xFFFBAB7E),
            Color(0xFFF7CE68),
            Color(0xFFFFFB7D),
          ],
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 0.1 * width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Long URL",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height * 0.026),
                ),
                TextField(
                  controller: longUrlController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText:
                        "https://www.youtube.com/watch?v=6Vs0to5a6bs&ab_channel=Broood",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Custom URL",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: height * 0.026),
                ),
                TextField(
                  controller: customUrlController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: "Optional",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (((Uri.tryParse("${longUrlController.text}/")
                                      ?.hasAbsolutePath ??
                                  false) ||
                              (Uri.tryParse("https://${longUrlController.text}")
                                      ?.hasAbsolutePath ??
                                  false) ||
                              (Uri.tryParse(longUrlController.text)
                                      ?.hasAbsolutePath ??
                                  false)) &&
                          (longUrlController.text.isNotEmpty)) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: FutureBuilder(
                                    future: getUrl(customUrlController.text,
                                        longUrlController.text),
                                    builder: (context, snap) {
                                      if (snap.hasData) {
                                        if (snap.connectionState ==
                                            ConnectionState.done) {
                                          if (!snap.data!.contains("ERROR")) {
                                            return Container(
                                              height: height * 0.25,
                                              width: width * 0.8,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                color: Colors.white,
                                              ),
                                              child: ColorfulBackground(
                                                duration: const Duration(
                                                    milliseconds: 1500),
                                                backgroundColors: const [
                                                  Color(0xFFFF5ACD),
                                                  Color(0xFFFBDA61),
                                                  Color(0xFFFBAB7E),
                                                  Color(0xFFF7CE68),
                                                  Color(0xFFFFFB7D),
                                                ],
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        snap.data!,
                                                        style: TextStyle(
                                                            color: Colors.black.withOpacity(0.5),
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                await Clipboard.setData(
                                                                    ClipboardData(
                                                                        text: snap
                                                                            .data));
                                                                SnackBar p =
                                                                    const SnackBar(
                                                                        content:
                                                                            Text("Copied!"));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        p);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.copy))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const Material(
                                              child: Text(
                                                  "Either Custom URL is taken or Long url is not valid"),
                                            );
                                          }
                                        }
                                      } else if (snap.connectionState ==
                                          ConnectionState.waiting) {
                                        LoadingAnimationWidget.twistingDots(
                                          leftDotColor: const Color(0xFF1A1A3F),
                                          rightDotColor:
                                              const Color(0xFFEA3799),
                                          size: 200,
                                        );
                                      }
                                      return LoadingAnimationWidget
                                          .twistingDots(
                                        leftDotColor: const Color(0xFF1A1A3F),
                                        rightDotColor: const Color(0xFFEA3799),
                                        size: 200,
                                      );
                                    }),
                              );
                            });
                      } else {
                        SnackBar x = const SnackBar(
                            content: Text("Please enter valid URL!"));
                        ScaffoldMessenger.of(context).showSnackBar(x);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5ACD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            color: Color(0xFFFBAB7E), width: 5),
                      ),
                    ),
                    child: const Text("Get short url!"),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rye_coffee/components/shimmer/my.shimmer.dart';

class ModalProductDescription extends StatelessWidget {
  final String description;
  final List<dynamic> packages;
  final ScrollController scrollController;
  final bool onLoading;

  const ModalProductDescription({
    Key? key,
    required this.description,
    required this.packages,
    required this.scrollController,
    required this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: MyShimmer(
                    height: 18,
                    width: 120,
                    radius: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: MyShimmer(
                    height: 12,
                    width: double.infinity,
                    radius: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: MyShimmer(
                    height: 12,
                    width: double.infinity,
                    radius: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: MyShimmer(
                    height: 18,
                    width: 120,
                    radius: 5,
                  ),
                ),
                Expanded(
                    child: MyShimmer(
                  height: double.infinity,
                  width: double.infinity,
                  radius: 5,
                ))
              ],
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Text(
                          'Packages',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: packages.length,
                          itemBuilder: (context, index) {
                            String image = packages[index]['image'] as String;
                            String name = packages[index]['name'] as String;
                            int qty = packages[index]['qty'] as int;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(
                                          4, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(image),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          qty.toString(),
                                          style: const TextStyle(
                                              color: Colors.brown,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}


// LayoutBuilder(
                //   builder: (context, constraints) {
                //     return SingleChildScrollView(
                //       child: ConstrainedBox(
                //         constraints:
                //             BoxConstraints(minHeight: constraints.maxHeight),
                //         child: IntrinsicHeight(
                //           child: Column(
                //             children: <Widget>[
                //               Text("Header"),
                //               Expanded(
                //                 child: Container(
                //                   color: Colors.red,
                //                 ),
                //               ),
                //               Text("Footer"),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //     // return SingleChildScrollView(
                //     //   child: ConstrainedBox(
                //     //     constraints: BoxConstraints(
                //     //       minHeight: constraints.maxHeight,
                //     //     ),
                //     //     child: IntrinsicHeight(
                //     //       child: Column(
                //     //         mainAxisAlignment: MainAxisAlignment.start,
                //     //         crossAxisAlignment: CrossAxisAlignment.start,
                //     //         children: packages.map((e) {
                //     //           String image = e['image'] as String;
                //     //           return Container(
                //     //             width: double.infinity,
                //     //             height: 80,
                //     //             margin: const EdgeInsets.only(bottom: 10),
                //     //             padding: const EdgeInsets.symmetric(
                //     //               horizontal: 5,
                //     //               vertical: 5,
                //     //             ),
                //     //             decoration: BoxDecoration(
                //     //               borderRadius: BorderRadius.circular(10),
                //     //               color: Colors.white,
                //     //               boxShadow: [
                //     //                 BoxShadow(
                //     //                   color: Colors.grey.withOpacity(0.2),
                //     //                   spreadRadius: 1,
                //     //                   blurRadius: 4,
                //     //                   offset: const Offset(
                //     //                       4, 4), // changes position of shadow
                //     //                 ),
                //     //               ],
                //     //             ),
                //     //             child: Row(
                //     //               mainAxisAlignment: MainAxisAlignment.start,
                //     //               crossAxisAlignment: CrossAxisAlignment.center,
                //     //               children: [
                //     //                 Container(
                //     //                   height: 70,
                //     //                   width: 70,
                //     //                   margin: const EdgeInsets.only(right: 10),
                //     //                   decoration: BoxDecoration(
                //     //                     borderRadius: BorderRadius.circular(5),
                //     //                     image: DecorationImage(
                //     //                       image: NetworkImage(image),
                //     //                       fit: BoxFit.cover,
                //     //                       alignment: Alignment.center,
                //     //                     ),
                //     //                   ),
                //     //                 ),
                //     //               ],
                //     //             ),
                //     //           );
                //     //         }).toList(),
                //     //       ),
                //     //     ),
                //     //   ),
                //     // );
                //   },
                // ),
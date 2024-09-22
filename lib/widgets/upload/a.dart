// static processing(
//     BuildContext context,
//     ) {
//   return showDialog(
//     context: context,
//     builder: (context) => BlocBuilder<ApiCubit, ApiState>(
//       builder: (context, state) {
//         var cubit = ApiCubit.get(context);
//         ItemModel model = ApiCubit.get(context).items.last;
//         return AlertDialog(
//           backgroundColor:
//           state is LoadingConvert ? Colors.transparent : Colors.white,
//           contentPadding: EdgeInsets.zero,
//           content: SingleChildScrollView(
//               child: state is LoadingConvert
//                   ? Container(
//                 width: 350.w,
//                 height: 450,
//                 decoration: BoxDecoration(
//                   color: AppColors.transparent,
//                 ),
//                 child: Lottie.asset(
//                   'assets/lotte_files/processing.json',
//                 ),
//               )
//                   : Container(
//                 height: 450.h,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(25),
//                     color: Colors.white,
//                   ),
//                   height: 150.h,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: Column(children: [
//                             Container(
//                               child: cubit.edit
//                                   ? Padding(
//                                 padding:
//                                 const EdgeInsets.all(8.0),
//                                 child: TextField(
//                                   controller:
//                                   ApiCubit.get(context)
//                                       .titleController,
//                                   onTap: () {
//                                     ApiCubit.get(context)
//                                         .showScribe();
//                                     ;
//                                   },
//                                   maxLines: null,
//                                   decoration: InputDecoration(
//                                       hintStyle: TextStyle(
//                                         // fontSize: 15,
//                                         // height: 300,
//                                           color: Colors.black),
//                                       // hintText: '',
//                                       labelText: "Title",
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                           BorderRadius
//                                               .circular(12))),
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       // height: 30,
//                                       fontSize: 14),
//                                 ),
//                               )
//                                   : Padding(
//                                 padding:
//                                 const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   ApiCubit.get(context)
//                                       .titleController
//                                       .text,
//                                   style: TextStyle(
//                                       color: Colors.black),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10.h,
//                             ),
//                             Container(
//                               height: 300,
//                               child: cubit.edit
//                                   ? Padding(
//                                 padding:
//                                 const EdgeInsets.all(8.0),
//                                 child: TextField(
//                                   controller:
//                                   ApiCubit.get(context)
//                                       .scribe,
//                                   onTap: () {
//                                     ApiCubit.get(context)
//                                         .showScribe();
//                                   },
//                                   maxLines: null,
//                                   decoration: InputDecoration(
//                                       hintStyle: TextStyle(
//                                         // fontSize: 15,
//                                         // height: 300,
//                                           color: Colors.black),
//                                       // hintText: '',
//                                       labelText: "Content",
//                                       helperText:
//                                       'Edit scribe here',
//                                       border: OutlineInputBorder(
//                                           borderRadius:
//                                           BorderRadius
//                                               .circular(12))),
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       // height: 30,
//                                       fontSize: 14),
//                                 ),
//                               )
//                                   : ListView(
//                                 children: [
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       ApiCubit.get(context)
//                                           .content ??
//                                           '',
//                                       style: TextStyle(
//                                           color: Colors.black),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(top: 20),
//                         decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(25),
//                                 bottomLeft: Radius.circular(25),
//                                 topRight: Radius.circular(60),
//                                 topLeft: Radius.circular(8))),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   SaveRecord.saving(context);
//
//                                   Future.delayed(
//                                     Duration(seconds: 3),
//                                         () => Navigator.pop(context),
//                                   ).then((_) {
//                                     Navigator.pop(context);
//                                     ApiCubit.get(context).save();
//                                     ApiCubit.get(context)
//                                         .titleController
//                                         .clear();
//
//                                     SaveRecord.done(context);
//                                   });
//                                 },
//                                 icon: Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(3),
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius:
//                                           BorderRadius.circular(5)),
//                                       child: ImageIcon(
//                                         size: 25,
//                                         color: AppColors.white
//                                             .withOpacity(.5),
//
//                                         AssetImage(
//                                           'assets/icons/save3.png',
//                                         ),
//                                         // color: Colors.white,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       'Save',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 )),
//                             IconButton(
//                                 onPressed: () {
//                                   cubit.editButton();
//                                 },
//                                 icon: Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(3),
//                                       decoration: BoxDecoration(
//                                         // color: Colors.black,
//
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius:
//                                           BorderRadius.circular(5)),
//                                       child: ImageIcon(
//                                         AssetImage(
//                                             'assets/icons/edit.png'),
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       'Edit',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 )),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(3.r),
//                                       decoration: BoxDecoration(
//                                         // color: Colors.black,
//
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius:
//                                           BorderRadius.circular(5)),
//                                       child: ImageIcon(
//                                         AssetImage(
//                                             'assets/icons/download.png'),
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       'Download',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 )),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Column(
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.all(3),
//                                       decoration: BoxDecoration(
//                                         // color: Colors.black,
//
//                                           border: Border.all(
//                                               color: AppColors.black),
//                                           borderRadius:
//                                           BorderRadius.circular(5)),
//                                       child: ImageIcon(
//                                         AssetImage(
//                                             'assets/icons/share.png'),
//                                         color: AppColors.white,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Text(
//                                       'Share',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//         );
//       },
//     ),
//   );
// }
// }

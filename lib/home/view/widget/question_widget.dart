// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:the_qa/_util/extension.dart';
// import 'package:the_qa/home/controller/home_bloc.dart';
// import 'package:the_qa/home/controller/home_event.dart';
// import 'package:the_qa/home/controller/home_state.dart';

// class QuestionWidget extends StatelessWidget {
//   final int questionIndex;
//   const QuestionWidget({super.key, required this.questionIndex});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(12)),
//           border: Border.all(color: Colors.blueAccent),
//           color: Colors.tealAccent,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.grey,
//                   backgroundImage: NetworkImage(state.userModel.imgUrl),
//                   onBackgroundImageError: (exception, stackTrace) {
//                     "onBackgroundImageErrorException : $exception".logIt;
//                   },
//                   foregroundImage: NetworkImage(state.userModel.imgUrl),
//                   onForegroundImageError: (exception, stackTrace) {
//                     "onForegroundImageErrorException : $exception".logIt;
//                   },
//                 ),
//                 const SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       state.userModel.name.split(" ")[0],
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                     Text(state.questionModel[questionIndex].question)
//                   ],
//                 )
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(elevation: 0.0),
//                   onPressed: () {
//                     showCustomBottomSheet(
//                       context,
//                       state,
//                       state.questionModel[questionIndex].questionId,
//                       state.questionModel[questionIndex].userId,
//                     );

//                     // context.read<HomeBloc>().add(
//                     //       GetAnswer(
//                     //         questionId:
//                     //             state.questionModel[questionIndex].questionId,
//                     //         context: context,
//                     //       ),
//                     //     );
//                   },
//                   child:
//                       const Text("View Answer", style: TextStyle(fontSize: 16)),
//                 )
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// Future<void> showCustomBottomSheet(
//   BuildContext hcontext,
//   HomeState state,
//   String questionId,
//   String userId,
// ) async {
//   showModalBottomSheet(
//     context: hcontext,
//     isScrollControlled: true,
//     builder: (context) {
//       hcontext
//           .read<HomeBloc>()
//           .add(GetAnswer(questionId: questionId, context: context));

//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//           ),
//           child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
//             return DraggableScrollableSheet(
//               initialChildSize: 0.5,
//               minChildSize: 0.25,
//               maxChildSize: 0.9,
//               controller: DraggableScrollableController(),
//               expand: false,
//               builder: (context, scrollController) {
//                 if (state.isAnswerLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (state.answerModel.isEmpty) {
//                   return const Center(child: Text('No answers available'));
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: state.answerModel.length,
//                           itemBuilder: (context, index) {
//                             return Text(
//                               key: ValueKey(state.answerModel[index].answerId),
//                               state.answerModel[index].answer,
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Spacer(),
//                       TextFormField(
//                         controller: state.answerController,
//                         decoration: InputDecoration(
//                           labelText: 'Enter your question',
//                           border: const OutlineInputBorder(),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               hcontext.read<HomeBloc>().add(
//                                     PostAnswer(
//                                       questionId: questionId,
//                                       answer: state.answerController.text,
//                                       userId: userId,
//                                     ),
//                                   );
//                               Navigator.of(context).pop();
//                             },
//                             icon: const Icon(Icons.send),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }),
//         ),
//       );
//     },
//   );
// }

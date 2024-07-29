// class AnswerWidget extends StatelessWidget {
//   final double height;
//   final double width;
//   final HomeState state;
//   final String quesionId;
//   final String userId;
//   final BuildContext hcontext;
//   const AnswerWidget({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.state,
//     required this.quesionId,
//     required this.userId,
//     required this.hcontext,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: const BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//       child: state.isAnswerLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Column(
//               children: [
//                 state.answerModel.isEmpty
//                     ? const Center(child: Text("Not Found"))
//                     : Expanded(
//                         child: ListView.builder(
//                           itemCount: state.answerModel.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "Answer : ${state.answerModel[index].answer}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                 state.answerModel.isEmpty ? const Spacer() : const SizedBox(),
//                 TextFormField(
//                   controller: state.answerController,
//                   decoration: InputDecoration(
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                     ),
//                     enabledBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white),
//                       borderRadius: BorderRadius.all(Radius.circular(16)),
//                     ),
//                     hintStyle: const TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                     hintText: "Submit answer",
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         hcontext.read<HomeBloc>().add(
//                               PostAnswer(
//                                   questionId: quesionId,
//                                   answer: state.answerController.text,
//                                   userId: userId,
//                                   context: context),
//                             );
//                       },
//                       icon: const Icon(
//                         Icons.send,
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5)
//               ],
//             ),
//     );
//   }
// }

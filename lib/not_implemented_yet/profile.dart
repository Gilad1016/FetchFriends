// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
//
// import '../auth/auth_provider.dart';
// import '../common/widgets/dog_card/dog_card_hero.dart';
// import '../common/widgets/top_bar/app_bar.dart';
// import '../common/widgets/top_bar/back_button.dart';
// import '../dog_management/dog_item.dart';
// import '../common/router/routes_utils.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // final dataProvider = Provider.of<DataProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return FutureBuilder<List<DogItem>?>(
//         future: authProvider
//         .getMyToken()
//         .then((token) => [DogItem(name: "dogy", ownerUID: "joasnfkjnf")]),
//       //dataProvider.getMyDogs(token))
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           // Handle error case
//           return Text('Error: ${snapshot.error}');
//         }
//
//         if (!snapshot.hasData) {
//           // Handle loading case
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final myDogs = snapshot.data!;
//
//         return Scaffold(
//           appBar: const CustomAppBar(
//             titleText: 'My Dogs',
//             leadingWidget: BackWidget(),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.only(bottom: 40, left: 28, right: 28),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 const SizedBox(height: 20),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: myDogs.length,
//                     itemBuilder: (context, index) {
//                       final dog = myDogs[index];
//                       return DogHero(
//                         dogItem: dog,
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () =>
//                 GoRouter.of(context).pushNamed(AppPage.addDog.toName),
//             child: const Icon(Icons.add),
//           ),
//         );
//       },
//     );
//   }
// }

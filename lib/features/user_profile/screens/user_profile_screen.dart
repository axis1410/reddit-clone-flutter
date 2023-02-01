import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/common/loader.dart';
import '../../../core/common/error_text.dart';

import '../../auth/controller/auth_controller.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;

  const UserProfileScreen({super.key, required this.uid});

  void navigateToEditUser(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    expandedHeight: 250,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(user.banner, fit: BoxFit.cover),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 45,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(15),
                          child: OutlinedButton(
                            onPressed: () => navigateToEditUser(context),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                            ),
                            child: const Text('Edit Profile'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'u/${user.name}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '${user.karma} Karma',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ];
              }),
              body: const Text('Displaying Posts'),
            ),
            error: ((error, stackTrace) => ErrorText(error: error.toString())),
            loading: () => const Loader(),
          ),
    );
  }
}

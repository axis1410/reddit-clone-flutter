import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/pallete.dart';

import '../../../features/auth/controller/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControlProvider.notifier).logOut();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 50,
            ),
            const SizedBox(height: 30),
            Text(
              'u/${user.name}',
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(color: Colors.grey, thickness: 0.1),
            ),
            ListTile(
              title: const Text('View Profile'),
              leading: const Icon(Icons.person),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(Icons.logout, color: Pallete.redColor),
              onTap: () => logOut(ref),
            ),
            Switch.adaptive(
              value: true,
              onChanged: (val) {},
              activeColor: Colors.greenAccent,
            )
          ],
        ),
      ),
    );
  }
}

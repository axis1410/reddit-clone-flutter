import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

import '../../../features/community/controller/community_controller.dart';

import '../../../models/community_model.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});

  void navigtateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/r/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a Community'),
              leading: const Icon(Icons.add),
              onTap: () => navigtateToCreateCommunity(context),
            ),
            ref.watch(userCommunitiesProvider).when(
                  data: (communities) => Expanded(
                    child: ListView.builder(
                      itemCount: communities.length,
                      itemBuilder: (BuildContext context, int index) {
                        final community = communities[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(community.avatar),
                          ),
                          title: Text('r/${community.name}'),
                          onTap: () => navigateToCommunity(context, community),
                        );
                      },
                    ),
                  ),
                  error: ((error, stackTrace) => ErrorText(
                        error: error.toString(),
                      )),
                  loading: () => const Loader(),
                ),
          ],
        ),
      ),
    );
  }
}

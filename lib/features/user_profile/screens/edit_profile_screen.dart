import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/features/user_profile/controller/user_profile_controller.dart';

import '../../../core/utils.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/error_text.dart';
import '../../../core/constants/constants.dart';

import '../../../theme/pallete.dart';

import '../../auth/controller/auth_controller.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;

  const EditProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  File? bannerFile;
  File? profileFile;

  Uint8List? bannerWebFile;
  Uint8List? profileWebFile;
  late TextEditingController _nameController;

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          bannerWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          bannerFile = File(res.files.first.path!);
        });
      }
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          profileWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          profileFile = File(res.files.first.path!);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: ref.read(userProvider)!.name);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void save() {
    ref.read(userProfileControllerProvider.notifier).editProfile(
          profileFile: profileFile,
          bannerFile: bannerFile,
          context: context,
          name: _nameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getUserDataProvider(widget.uid)).when(
          data: (user) => Scaffold(
            backgroundColor: Pallete.darkModeAppTheme.backgroundColor,
            appBar: AppBar(
              title: const Text('Edit Profile'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: save,
                  child: const Text('Save'),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            strokeCap: StrokeCap.round,
                            dashPattern: const [10, 4],
                            color: Pallete.darkModeAppTheme.textTheme.bodyText2!.color!,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: bannerFile != null
                                  ? Image.file(bannerFile!)
                                  : user.banner.isEmpty || user.banner == Constants.bannerDefault
                                      ? const Center(
                                          child: Icon(Icons.camera_alt_outlined, size: 40),
                                        )
                                      : Image.network(user.banner),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: profileFile != null
                                ? CircleAvatar(
                                    radius: 32,
                                    backgroundImage: FileImage(profileFile!),
                                  )
                                : CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(user.profilePic),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}

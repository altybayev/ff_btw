import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../login/login_widget.dart';
import '../../register/register_widget.dart';
import '../../create_dog_profile/create_dog_profile_widget.dart';
import '../../create_your_profile/create_your_profile_widget.dart';
import '../../forgot_password/forgot_password_widget.dart';
import '../../home_page/home_page_widget.dart';
import '../../post_details/post_details_widget.dart';
import '../../create_post/create_post_widget.dart';
import '../../choose_category/choose_category_widget.dart';
import '../../story_details/story_details_widget.dart';
import '../../change_password/change_password_widget.dart';
import '../../view_profile_page_other/view_profile_page_other_widget.dart';
import '../../settings/settings_widget.dart';
import '../../edit_user_profile/edit_user_profile_widget.dart';
import '../../edit_dog_profile/edit_dog_profile_widget.dart';
import '../../create_dog_profile_new/create_dog_profile_new_widget.dart';
import '../../create_story/create_story_widget.dart';
import '../../chat_page/chat_page_widget.dart';
import '../../all_chats_page/all_chats_page_widget.dart';
import '../../add_chat_users/add_chat_users_widget.dart';
import '../../create_group_chat/create_group_chat_widget.dart';
import '../../post_details_copy/post_details_copy_widget.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler(
      {Key key, this.handlePushNotification, this.child})
      : super(key: key);

  final Function(BuildContext) handlePushNotification;
  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    setState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).primaryColor,
          child: Builder(
            builder: (context) => Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'login': (data) async => LoginWidget(),
  'register': (data) async => RegisterWidget(),
  'createDogProfile': (data) async => CreateDogProfileWidget(),
  'createYourProfile': (data) async => CreateYourProfileWidget(),
  'forgotPassword': (data) async => ForgotPasswordWidget(),
  'homePage': (data) async => HomePageWidget(),
  'postDetails': (data) async => PostDetailsWidget(
        postReference: getParameter(data, 'postReference'),
      ),
  'createPost': (data) async => CreatePostWidget(
        postRef: getParameter(data, 'postRef'),
      ),
  'chooseCategory': (data) async => ChooseCategoryWidget(
        postRef: getParameter(data, 'postRef'),
      ),
  'storyDetails': (data) async => StoryDetailsWidget(
        initialStoryIndex: getParameter(data, 'initialStoryIndex'),
      ),
  'changePassword': (data) async => ChangePasswordWidget(),
  'viewProfilePageOther': (data) async => ViewProfilePageOtherWidget(
        userDetails: await getDocumentParameter(
            data, 'userDetails', UsersRecord.serializer),
      ),
  'settings': (data) async => SettingsWidget(),
  'editUserProfile': (data) async => EditUserProfileWidget(),
  'editDogProfile': (data) async => EditDogProfileWidget(
        dogProfile: await getDocumentParameter(
            data, 'dogProfile', DogsRecord.serializer),
      ),
  'createDogProfile_New': (data) async => CreateDogProfileNewWidget(),
  'createStory': (data) async => CreateStoryWidget(),
  'chatPage': (data) async => ChatPageWidget(
        chatUser: await getDocumentParameter(
            data, 'chatUser', UsersRecord.serializer),
        chatRef: getParameter(data, 'chatRef'),
      ),
  'allChatsPage': (data) async => AllChatsPageWidget(),
  'addChatUsers': (data) async => AddChatUsersWidget(
        chat: await getDocumentParameter(data, 'chat', ChatsRecord.serializer),
      ),
  'createGroupChat': (data) async => CreateGroupChatWidget(),
  'profile': (data) async => NavBarPage(initialPage: 'ProfileWidget'),
  'postDetailsCopy': (data) async => PostDetailsCopyWidget(
        postReference: getParameter(data, 'postReference'),
        userRecord: await getDocumentParameter(
            data, 'userRecord', UsersRecord.serializer),
      ),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}

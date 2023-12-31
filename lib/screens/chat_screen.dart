import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/screens/login_screen.dart';
import 'package:messaging_app/utilities/animated_button.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:messaging_app/utilities/message_bubble.dart';
import 'package:messaging_app/utilities/message_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    _setupPushNotifications();

    super.initState();
  }

  void _setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    //This token is for individual device notifications
    //final token = await fcm.getToken();

    //All users of this topic will get notifications
    fcm.subscribeToTopic("chat");

    //print("Token is $token");
  }

  void _signOut() {
    kFirebaseAuth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void _storeMessage(BuildContext context) async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please type something to send!"),
        ),
      );
    } else {
      String messageText = _messageController.text.trim();

      //Clearing the messageField
      _messageController.clear();

      //Closing the keyboard
      FocusScope.of(context).unfocus();

      final currentUser = kFirebaseAuth.currentUser!;

      final currentUserData = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get();

      //We're adding userName and userImage inside the message again to avoid
      //redundant calls for user information insistently
      await FirebaseFirestore.instance.collection("chat").add({
        "message": messageText,
        "createdAt": Timestamp.now(),
        "userId": currentUser.uid,
        "userName": currentUserData.data()!["userName"],
        "userImage": currentUserData.data()!["userImage"],
      });
    }
  }

  AppBar _getBlurredAppBar() => AppBar(
        //iconTheme: const IconThemeData().copyWith(color: kPrimaryColor),
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xffefeeee).withAlpha(200),
        title: Text(
          "Conversa Hub",
          style: kBodyTextStyle,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.5.w),
            child: IconButton(
              onPressed: _signOut,
              icon: const Icon(Icons.power_settings_new),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _getBlurredAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ).copyWith(bottom: 4.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //region Chat

              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chat")
                        .orderBy(
                          "createdAt",
                          descending: true,
                        ) //Arranging the messages in the proper order
                        .snapshots(),
                    builder: (context, snapShot) {
                      //Showing the loader
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      }

                      //Showing the empty message if the collection is empty
                      if (!snapShot.hasData || snapShot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            "No messages found!",
                            style: kBodyTextStyle,
                          ),
                        );
                      }

                      if (snapShot.hasError) {
                        return Text(
                          "Something went wrong...",
                          style: kBodyTextStyle,
                        );
                      }

                      final loadedMessages = snapShot.data!.docs;
                      return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 2.w)
                              .copyWith(bottom: 3.h),
                          reverse: true, //To show the list from bottom to top
                          itemCount: loadedMessages.length,
                          itemBuilder: (context, index) {
                            //As the list is reversed the last index will be the very first message
                            bool isVeryFirstMessage =
                                index == loadedMessages.length - 1;

                            String? userName =
                                loadedMessages[index].data()["userName"];
                            String? userImage =
                                loadedMessages[index].data()["userImage"];
                            String message =
                                loadedMessages[index].data()["message"];
                            bool isMe = kFirebaseAuth.currentUser!.uid ==
                                loadedMessages[index].data()["userId"];

                            bool isLastMessage = false;
                            //Setting just one image and username for consecutive messages from one person

                            if (index != loadedMessages.length - 1 &&
                                loadedMessages[index].data()["userId"] ==
                                    loadedMessages[index + 1]
                                        .data()["userId"]) {
                              userName = userImage = null;
                            }

                            //Getting the last message from the consecutive messages
                            if (index == 0) {
                              isLastMessage = true;
                            } else if (loadedMessages[index].data()["userId"] !=
                                loadedMessages[index - 1].data()["userId"]) {
                              isLastMessage = true;
                            }

                            return MessageBubble(
                              userName: userName,
                              userImageUrl: userImage,
                              message: message.trim(),
                              isMe: isMe,
                              isVeryFirstMessage: isVeryFirstMessage,
                              isLastMessage: isLastMessage,
                            );
                          });
                    }),
              ),
              SizedBox(
                height: 30.sp,
                child: Row(
                  children: [
                    Expanded(
                      child: MessageTextField(
                        messageController: _messageController,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: 30.sp,
                      child: AnimatedButton(
                        onPressed: () => _storeMessage(context),
                      ),
                    ),
                  ],
                ),
              ),

              //endregion
            ],
          ),
        ),
      ),
    );
  }
}

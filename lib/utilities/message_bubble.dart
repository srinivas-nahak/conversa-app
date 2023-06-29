import 'package:flutter/material.dart';
import 'package:messaging_app/utilities/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {this.userName,
      this.userImageUrl,
      required this.message,
      required this.isMe,
      required this.isVeryFirstMessage,
      required this.isLastMessage,
      super.key});

  final bool isMe, isVeryFirstMessage, isLastMessage;
  final String? userImageUrl, userName;
  final String message;

  // double _getBubbleHorizontalPadding() {
  //   if (_getMessageWordsCount() <= 2) {
  //     return 4.w;
  //   }
  //
  //   return 8.w;
  // }

  int _getMessageWordsCount() =>
      RegExp(r"\w+(\'\w+)?").allMatches(message).length;

  List<Widget> _getRowChildren() {
    List<Widget> userInfoList = [];

    if (userName != null) {
      userInfoList = [
        Text(
          userName!,
          style: kBodyTextStyle.copyWith(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        CircleAvatar(
          radius: 15.sp,
          backgroundImage: NetworkImage(userImageUrl!),
          backgroundColor: kPrimaryColor,
        ),

        // Container(
        //   height: 18.sp,
        //   width: 18.sp,
        //   decoration: BoxDecoration(
        //     color: kPrimaryColor,
        //     borderRadius: BorderRadius.circular(11.sp),
        //   ),
        //   clipBehavior: Clip.antiAlias,
        //   child: Image.network(
        //     userImageUrl!,
        //     fit: BoxFit.cover,
        //   ),
        // )
      ];
    }

    final meBorderRadius = BorderRadius.circular(25.sp).copyWith(
      topRight:
          userName == null ? Radius.circular(15.sp) : Radius.circular(25.sp),
      bottomRight:
          isLastMessage ? Radius.circular(25.sp) : Radius.circular(15.sp),
    );
    final otherBorderRadius = BorderRadius.circular(25.sp).copyWith(
      topLeft:
          userName == null ? Radius.circular(15.sp) : Radius.circular(25.sp),
      bottomLeft:
          isLastMessage ? Radius.circular(25.sp) : Radius.circular(15.sp),
    );

    return [
      Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (userName != null && !isMe)
            Row(
              children: isMe ? userInfoList : userInfoList.reversed.toList(),
            ),
          if (userName != null && !isMe)
            SizedBox(
              height: 1.h,
            ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 1.8.h,
              horizontal: 6.5.w,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ? kButtonColor.withOpacity(0.8)
                  : kPrimaryColor.withOpacity(0.15),
              borderRadius: isMe ? meBorderRadius : otherBorderRadius,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 50.w),
              child: Text(
                message,
                style: TextStyle(
                    color: isMe ? kScaffoldBgColor : kPrimaryColor,
                    fontSize: 17.sp,
                    height: 1.3),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    ];
  }

  EdgeInsetsGeometry _getOuterPadding() {
    //Setting the top padding for very first message
    //By setting padding to the parent list view it was being cut from top

    final padding = EdgeInsets.symmetric(vertical: 0.4.h)
        .copyWith(bottom: isLastMessage ? 1.5.h : 0.4.h);

    if (isVeryFirstMessage) {
      return padding.copyWith(top: 4.h);
    }
    return padding;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _getOuterPadding(),
      child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getRowChildren()),
    );
  }
}

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../comment_replies/comment_replies_widget.dart';
import '../components/bs_delete_reply_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import '../profile_show_other/profile_show_other_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplyCardWidget extends StatefulWidget {
  const ReplyCardWidget({
    Key key,
    this.post,
    this.comment,
    this.reply,
    this.replyPivot,
  }) : super(key: key);

  final UserPostsRecord post;
  final PostCommentsRecord comment;
  final PostCommentsRecord reply;
  final CommentRepliesRecord replyPivot;

  @override
  _ReplyCardWidgetState createState() => _ReplyCardWidgetState();
}

class _ReplyCardWidgetState extends State<ReplyCardWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.reply.user),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: SpinKitRipple(
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 20,
              ),
            ),
          );
        }
        final rowUsersRecord = snapshot.data;
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                if ((rowUsersRecord.reference) == (currentUserReference)) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBarPage(initialPage: 'profile'),
                    ),
                  );
                } else {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileShowOtherWidget(
                        ownerRef: rowUsersRecord.reference,
                      ),
                    ),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: rowUsersRecord.photoUrl,
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          onTap: () async {
                            if ((rowUsersRecord.reference) ==
                                (currentUserReference)) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NavBarPage(initialPage: 'profile'),
                                ),
                              );
                            } else {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileShowOtherWidget(
                                    ownerRef: rowUsersRecord.reference,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            rowUsersRecord.userName,
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Lato',
                                      color: Color(0xFF777777),
                                      fontSize: 12,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                            child: Text(
                              dateTimeFormat(
                                  'relative', widget.reply.timePosted),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Lato',
                                    color: Color(0xFF777777),
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        ),
                        if ((widget.reply.user) == (currentUserReference))
                          InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: BsDeleteReplyWidget(
                                      post: widget.post,
                                      comment: widget.comment,
                                      reply: widget.reply,
                                      replyPivot: widget.replyPivot,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.keyboard_control,
                              color: FlutterFlowTheme.of(context).primaryDark,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: CommentRepliesWidget(
                                comment: widget.reply,
                                post: widget.post,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          widget.reply.comment,
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (functions.isCommentDislikedByUser(
                                      widget.reply, currentUserReference)) {
                                    final postCommentsUpdateData = {
                                      'dislikes': FieldValue.arrayRemove(
                                          [currentUserReference]),
                                      'numDislikes': FieldValue.increment(0),
                                      'likes': FieldValue.arrayUnion(
                                          [currentUserReference]),
                                      'numLikes': FieldValue.increment(0),
                                    };
                                    await widget.reply.reference
                                        .update(postCommentsUpdateData);
                                  } else {
                                    final postCommentsUpdateData = {
                                      'likes': FieldValue.arrayUnion(
                                          [currentUserReference]),
                                      'numLikes': FieldValue.increment(0),
                                    };
                                    await widget.reply.reference
                                        .update(postCommentsUpdateData);
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.thumb_up_alt_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryDark,
                                      size: 14,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          4, 0, 0, 0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          formatNumber(
                                            widget.reply.numLikes,
                                            formatType: FormatType.compact,
                                          ),
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Lato',
                                              fontSize: 12,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (functions.isCommentLikedByUser(
                                      widget.reply, currentUserReference) ??
                                  true)
                                InkWell(
                                  onTap: () async {
                                    final postCommentsUpdateData = {
                                      'likes': FieldValue.arrayRemove(
                                          [currentUserReference]),
                                      'numLikes': FieldValue.increment(0),
                                    };
                                    await widget.reply.reference
                                        .update(postCommentsUpdateData);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.thumb_up_alt_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        size: 14,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              widget.reply.numLikes,
                                              formatType: FormatType.compact,
                                            ),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (functions.isCommentLikedByUser(
                                        widget.reply, currentUserReference)) {
                                      final postCommentsUpdateData = {
                                        'likes': FieldValue.arrayRemove(
                                            [currentUserReference]),
                                        'numLikes': FieldValue.increment(0),
                                        'dislikes': FieldValue.arrayUnion(
                                            [currentUserReference]),
                                        'numDislikes': FieldValue.increment(0),
                                      };
                                      await widget.reply.reference
                                          .update(postCommentsUpdateData);
                                    } else {
                                      final postCommentsUpdateData = {
                                        'dislikes': FieldValue.arrayUnion(
                                            [currentUserReference]),
                                        'numDislikes': FieldValue.increment(0),
                                      };
                                      await widget.reply.reference
                                          .update(postCommentsUpdateData);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.thumb_down_alt_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryDark,
                                        size: 14,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            formatNumber(
                                              widget.reply.numDislikes,
                                              formatType: FormatType.compact,
                                            ),
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (functions.isCommentDislikedByUser(
                                        widget.reply, currentUserReference) ??
                                    true)
                                  InkWell(
                                    onTap: () async {
                                      final postCommentsUpdateData = {
                                        'dislikes': FieldValue.arrayRemove(
                                            [currentUserReference]),
                                        'numDislikes': FieldValue.increment(0),
                                      };
                                      await widget.reply.reference
                                          .update(postCommentsUpdateData);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.thumb_down_alt_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          size: 14,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4, 0, 0, 0),
                                          child: Text(
                                            valueOrDefault<String>(
                                              formatNumber(
                                                widget.reply.numDislikes,
                                                formatType: FormatType.compact,
                                              ),
                                              '0',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Lato',
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: CommentRepliesWidget(
                                      comment: widget.reply,
                                      post: widget.post,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.message,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryDark,
                                    size: 14,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        4, 0, 0, 0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        formatNumber(
                                          widget.reply.numReplies,
                                          formatType: FormatType.compact,
                                        ),
                                        '0',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Lato',
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((widget.comment.numReplies) > 0)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((widget.reply.numReplies) > 0)
                              InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 300),
                                      reverseDuration:
                                          Duration(milliseconds: 300),
                                      child: CommentRepliesWidget(
                                        comment: widget.reply,
                                        post: widget.post,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  '${widget.reply.numReplies.toString()} REPLIES',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                      ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

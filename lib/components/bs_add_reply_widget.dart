import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BsAddReplyWidget extends StatefulWidget {
  const BsAddReplyWidget({
    Key key,
    this.comment,
    this.post,
  }) : super(key: key);

  final PostCommentsRecord comment;
  final UserPostsRecord post;

  @override
  _BsAddReplyWidgetState createState() => _BsAddReplyWidgetState();
}

class _BsAddReplyWidgetState extends State<BsAddReplyWidget> {
  PostCommentsRecord newReply;
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Color(0x98D9DFEB),
            offset: Offset(0, 10),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthUserStreamWidget(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: currentUserPhoto,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: TextFormField(
                  onChanged: (_) => EasyDebounce.debounce(
                    'textController',
                    Duration(milliseconds: 200),
                    () => setState(() {}),
                  ),
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Add a reply...',
                    hintStyle: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Lato',
                          color: FlutterFlowTheme.of(context).gray,
                          fontSize: 16,
                        ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            if (textController.text != null && textController.text != '')
              FFButtonWidget(
                onPressed: () async {
                  final postCommentsCreateData = createPostCommentsRecordData(
                    timePosted: getCurrentTimestamp,
                    comment: textController.text,
                    user: currentUserReference,
                    post: widget.post.reference,
                  );
                  var postCommentsRecordReference =
                      PostCommentsRecord.collection.doc();
                  await postCommentsRecordReference.set(postCommentsCreateData);
                  newReply = PostCommentsRecord.getDocumentFromData(
                      postCommentsCreateData, postCommentsRecordReference);

                  final commentRepliesCreateData =
                      createCommentRepliesRecordData(
                    createdAt: getCurrentTimestamp,
                    commentRef: widget.comment.reference,
                    replyRef: newReply.reference,
                  );
                  await CommentRepliesRecord.collection
                      .doc()
                      .set(commentRepliesCreateData);

                  final userPostsUpdateData = {
                    'numComments': FieldValue.increment(0),
                  };
                  await widget.post.reference.update(userPostsUpdateData);

                  final postCommentsUpdateData = {
                    'numReplies': FieldValue.increment(0),
                  };
                  await widget.comment.reference.update(postCommentsUpdateData);
                  Navigator.pop(context);

                  setState(() {});
                },
                text: 'OK',
                options: FFButtonOptions(
                  width: 60,
                  height: 40,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Lato',
                        color: Colors.white,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

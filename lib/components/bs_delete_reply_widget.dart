import '../backend/backend.dart';
import '../components/bs_edit_reply_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BsDeleteReplyWidget extends StatefulWidget {
  const BsDeleteReplyWidget({
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
  _BsDeleteReplyWidgetState createState() => _BsDeleteReplyWidgetState();
}

class _BsDeleteReplyWidgetState extends State<BsDeleteReplyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FFButtonWidget(
            onPressed: () async {
              Navigator.pop(context);
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: BsEditReplyWidget(
                      post: widget.post,
                      comment: widget.comment,
                      reply: widget.reply,
                      replyPivot: widget.replyPivot,
                    ),
                  );
                },
              );
            },
            text: 'EDIT',
            options: FFButtonOptions(
              width: double.infinity,
              height: 60,
              color: FlutterFlowTheme.of(context).primaryColor,
              textStyle: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 16,
                  ),
              elevation: 1,
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: 12,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                var confirmDialogResponse = await showDialog<bool>(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Delete'),
                          content: Text('Are you sure?'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
                if (confirmDialogResponse) {
                  await actions.deleteComments(
                    widget.reply,
                    widget.post,
                  );
                  Navigator.pop(context);
                }
              },
              text: 'DELETE',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60,
                color: FlutterFlowTheme.of(context).background,
                textStyle: FlutterFlowTheme.of(context).title3.override(
                      fontFamily: 'Lato',
                      color: FlutterFlowTheme.of(context).primaryDark,
                      fontSize: 16,
                    ),
                elevation: 1,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

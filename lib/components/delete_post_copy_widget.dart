import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/bs_add_comment_copy_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DeletePostCopyWidget extends StatefulWidget {
  const DeletePostCopyWidget({
    Key key,
    this.comment,
    this.post,
  }) : super(key: key);

  final PostCommentsRecord comment;
  final UserPostsRecord post;

  @override
  _DeletePostCopyWidgetState createState() => _DeletePostCopyWidgetState();
}

class _DeletePostCopyWidgetState extends State<DeletePostCopyWidget> {
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
                    child: BsAddCommentCopyWidget(
                      userPost: widget.post,
                      comment: widget.comment,
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
                  await widget.comment.reference.delete();

                  final userPostsUpdateData = {
                    'numComments': FieldValue.increment(0),
                  };
                  await widget.post.reference.update(userPostsUpdateData);
                  await actions.updateConnection(
                    currentUserReference,
                    widget.post.postUser,
                    -15,
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

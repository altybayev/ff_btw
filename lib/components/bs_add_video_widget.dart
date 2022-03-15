import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BsAddVideoWidget extends StatefulWidget {
  const BsAddVideoWidget({
    Key key,
    this.postRef,
  }) : super(key: key);

  final DocumentReference postRef;

  @override
  _BsAddVideoWidgetState createState() => _BsAddVideoWidgetState();
}

class _BsAddVideoWidgetState extends State<BsAddVideoWidget> {
  String uploadedFileUrl = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add image',
                style: FlutterFlowTheme.of(context).title2,
              ),
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).primaryDark,
                  size: 32,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: InkWell(
                  onTap: () async {
                    setState(() => FFAppState().imageUploading = true);
                    final selectedMedia =
                        await selectMediaWithSourceBottomSheet(
                      context: context,
                      allowPhoto: false,
                      allowVideo: true,
                      backgroundColor: Colors.white,
                      textColor: FlutterFlowTheme.of(context).primaryDark,
                      pickerFontFamily: 'Lato',
                    );
                    if (selectedMedia != null &&
                        validateFileFormat(
                            selectedMedia.storagePath, context)) {
                      showUploadMessage(
                        context,
                        'Uploading file...',
                        showLoading: true,
                      );
                      final downloadUrl = await uploadData(
                          selectedMedia.storagePath, selectedMedia.bytes);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (downloadUrl != null) {
                        setState(() => uploadedFileUrl = downloadUrl);
                        showUploadMessage(
                          context,
                          'Success!',
                        );
                      } else {
                        showUploadMessage(
                          context,
                          'Failed to upload media',
                        );
                        return;
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x2E000000),
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!(FFAppState().imageUploading) ?? true)
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              '+Add video',
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                          ),
                        if (FFAppState().imageUploading ?? true)
                          Text(
                            'Uploading video, wait...',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (uploadedFileUrl != null && uploadedFileUrl != '')
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: FlutterFlowVideoPlayer(
                    path: uploadedFileUrl,
                    videoType: VideoType.network,
                    height: 200,
                    autoPlay: false,
                    looping: false,
                    showControls: true,
                    allowFullScreen: true,
                    allowPlaybackSpeedMenu: false,
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                final blocksCreateData = createBlocksRecordData(
                  postRef: widget.postRef,
                  type: 'video',
                  createdAt: getCurrentTimestamp,
                  videoUrl: uploadedFileUrl,
                );
                await BlocksRecord.collection.doc().set(blocksCreateData);
                Navigator.pop(context);
              },
              text: 'ADD',
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
          ),
        ],
      ),
    );
  }
}

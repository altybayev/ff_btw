import '../backend/backend.dart';
import '../components/bs_add_header_copy_widget.dart';
import '../components/bs_add_text_copy_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class BlockItemCopyWidget extends StatefulWidget {
  const BlockItemCopyWidget({
    Key key,
    this.block,
  }) : super(key: key);

  final BlocksRecord block;

  @override
  _BlockItemCopyWidgetState createState() => _BlockItemCopyWidgetState();
}

class _BlockItemCopyWidgetState extends State<BlockItemCopyWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((widget.block.type) == 'header')
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Text(
                        widget.block.content,
                        style: FlutterFlowTheme.of(context).title3,
                      ),
                    ),
                  if ((widget.block.type) == 'text')
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: Text(
                        widget.block.content,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  if ((widget.block.type) == 'image')
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: FlutterFlowExpandedImageView(
                                image: CachedNetworkImage(
                                  imageUrl: widget.block.imageUrl,
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: false,
                                tag: widget.block.imageUrl,
                                useHeroAnimation: true,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: widget.block.imageUrl,
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: CachedNetworkImage(
                              imageUrl: widget.block.imageUrl,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if ((widget.block.type) == 'video')
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: FlutterFlowVideoPlayer(
                        path: widget.block.videoUrl,
                        videoType: VideoType.network,
                        autoPlay: false,
                        looping: true,
                        showControls: true,
                        allowFullScreen: true,
                        allowPlaybackSpeedMenu: false,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (widget.block.content != null && widget.block.content != '')
          Align(
            alignment: AlignmentDirectional(1, -1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 72, 0),
              child: InkWell(
                onTap: () async {
                  if ((widget.block.type) == 'text') {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: BsAddTextCopyWidget(
                            block: widget.block,
                          ),
                        );
                      },
                    );
                  } else {
                    if ((widget.block.type) == 'header') {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: BsAddHeaderCopyWidget(
                              block: widget.block,
                            ),
                          );
                        },
                      );
                    }
                  }
                },
                child: Icon(
                  Icons.edit_sharp,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
        Align(
          alignment: AlignmentDirectional(1, -1),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: InkWell(
              onTap: () async {
                var confirmDialogResponse = await showDialog<bool>(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Block will be deleted'),
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
                  await widget.block.reference.delete();
                }
              },
              child: Icon(
                Icons.cancel_outlined,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

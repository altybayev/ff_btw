import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class BlockItemWidget extends StatefulWidget {
  const BlockItemWidget({
    Key key,
    this.block,
  }) : super(key: key);

  final BlocksRecord block;

  @override
  _BlockItemWidgetState createState() => _BlockItemWidgetState();
}

class _BlockItemWidgetState extends State<BlockItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
    );
  }
}

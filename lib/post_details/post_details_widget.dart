import '../backend/backend.dart';
import '../components/block_item_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class PostDetailsWidget extends StatefulWidget {
  const PostDetailsWidget({
    Key key,
    this.postReference,
  }) : super(key: key);

  final DocumentReference postReference;

  @override
  _PostDetailsWidgetState createState() => _PostDetailsWidgetState();
}

class _PostDetailsWidgetState extends State<PostDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserPostsRecord>(
      future: UserPostsRecord.getDocumentOnce(widget.postReference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        final postDetailsUserPostsRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 46,
              icon: Icon(
                Icons.arrow_back_ios,
                color: FlutterFlowTheme.of(context).primaryColor,
                size: 24,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: Text(
              ' ',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                child: Icon(
                  Icons.keyboard_control_rounded,
                  color: FlutterFlowTheme.of(context).primaryDark,
                  size: 32,
                ),
              ),
            ],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postDetailsUserPostsRecord.postTitle,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: FlutterFlowExpandedImageView(
                            image: CachedNetworkImage(
                              imageUrl: postDetailsUserPostsRecord.postPhoto,
                              fit: BoxFit.contain,
                            ),
                            allowRotation: false,
                            tag: postDetailsUserPostsRecord.postPhoto,
                            useHeroAnimation: true,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: postDetailsUserPostsRecord.postPhoto,
                      transitionOnUserGestures: true,
                      child: CachedNetworkImage(
                        imageUrl: postDetailsUserPostsRecord.postPhoto,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FutureBuilder<UsersRecord>(
                    future: UsersRecord.getDocumentOnce(
                        postDetailsUserPostsRecord.postUser),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      final rowUsersRecord = snapshot.data;
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CachedNetworkImage(
                            imageUrl: rowUsersRecord.photoUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            rowUsersRecord.userName,
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      );
                    },
                  ),
                  FutureBuilder<List<BlocksRecord>>(
                    future: queryBlocksRecordOnce(
                      queryBuilder: (blocksRecord) => blocksRecord
                          .where('postRef', isEqualTo: widget.postReference)
                          .orderBy('createdAt'),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      List<BlocksRecord> columnBlocksRecordList = snapshot.data;
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(columnBlocksRecordList.length,
                            (columnIndex) {
                          final columnBlocksRecord =
                              columnBlocksRecordList[columnIndex];
                          return BlockItemWidget(
                            block: columnBlocksRecord,
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

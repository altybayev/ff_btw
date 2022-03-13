import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_media_display.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../main.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key key}) : super(key: key);

  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  String uploadedFileUrl = '';
  TextEditingController postTitleController;
  UserPostsRecord currentPost;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final userPostsCreateData = createUserPostsRecordData(
        isDraft: true,
        postUser: currentUserReference,
      );
      var userPostsRecordReference = UserPostsRecord.collection.doc();
      await userPostsRecordReference.set(userPostsCreateData);
      currentPost = UserPostsRecord.getDocumentFromData(
          userPostsCreateData, userPostsRecordReference);
    });

    postTitleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Create Post',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF090F13),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).primaryDark,
                size: 30,
              ),
              onPressed: () async {
                if (currentPost.reference != null) {
                  await currentPost.reference.delete();
                }
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavBarPage(initialPage: 'home'),
                  ),
                  (r) => false,
                );
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: TextFormField(
                                  controller: postTitleController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    hintText: 'Enter post title...',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .gray200,
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .gray200,
                                        width: 0,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            0, 14, 0, 0),
                                  ),
                                  style: FlutterFlowTheme.of(context).title2,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add tags',
                                    style: FlutterFlowTheme.of(context)
                                        .subtitle1
                                        .override(
                                          fontFamily: 'Lato',
                                          fontSize: 21,
                                        ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 30,
                                    borderWidth: 1,
                                    buttonSize: 60,
                                    icon: Icon(
                                      Icons.add_box_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: StreamBuilder<List<TagsRecord>>(
                                  stream: queryTagsRecord(
                                    queryBuilder: (tagsRecord) => tagsRecord
                                        .where('postRef',
                                            isEqualTo: currentPost.reference)
                                        .orderBy('name'),
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryColor,
                                          ),
                                        ),
                                      );
                                    }
                                    List<TagsRecord> columnTagsRecordList =
                                        snapshot.data;
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          columnTagsRecordList.length,
                                          (columnIndex) {
                                        final columnTagsRecord =
                                            columnTagsRecordList[columnIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(75),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(16, 4, 4, 4),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    columnTagsRecord.name,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 0, 0, 0),
                                                    child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .gray200,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await columnTagsRecord
                                                              .reference
                                                              .delete();
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Container(
                                  height: 220,
                                  child: Stack(
                                    children: [
                                      if (!(functions.hasUploadedMedia(
                                              uploadedFileUrl)) ??
                                          true)
                                        InkWell(
                                          onTap: () async {
                                            final selectedMedia =
                                                await selectMediaWithSourceBottomSheet(
                                              context: context,
                                              allowPhoto: true,
                                              allowVideo: true,
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .red200,
                                              textColor:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              pickerFontFamily: 'Lexend Deca',
                                            );
                                            if (selectedMedia != null &&
                                                validateFileFormat(
                                                    selectedMedia.storagePath,
                                                    context)) {
                                              showUploadMessage(
                                                context,
                                                'Uploading file...',
                                                showLoading: true,
                                              );
                                              final downloadUrl =
                                                  await uploadData(
                                                      selectedMedia.storagePath,
                                                      selectedMedia.bytes);
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              if (downloadUrl != null) {
                                                setState(() => uploadedFileUrl =
                                                    downloadUrl);
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 220,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF1F5F8),
                                              image: DecorationImage(
                                                fit: BoxFit.fitHeight,
                                                image: Image.network(
                                                  '',
                                                ).image,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 3,
                                                  color: Color(0x2D000000),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                '+ Add main photo',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .title2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (functions.hasUploadedMedia(
                                              uploadedFileUrl) ??
                                          true)
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: FlutterFlowMediaDisplay(
                                            path: uploadedFileUrl,
                                            imageBuilder: (path) =>
                                                Image.network(
                                              path,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            videoPlayerBuilder: (path) =>
                                                FlutterFlowVideoPlayer(
                                              path: path,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              autoPlay: false,
                                              looping: true,
                                              showControls: true,
                                              allowFullScreen: true,
                                              allowPlaybackSpeedMenu: false,
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20),
                child: FFButtonWidget(
                  onPressed: () async {
                    final userPostsUpdateData = createUserPostsRecordData(
                      postPhoto: uploadedFileUrl,
                      postTitle: postTitleController.text,
                      postUser: currentUserReference,
                      timePosted: getCurrentTimestamp,
                      isDraft: true,
                    );
                    await currentPost.reference.update(userPostsUpdateData);

                    final usersUpdateData = {
                      'posts_count': FieldValue.increment(1),
                    };
                    await currentUserReference.update(usersUpdateData);
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 250),
                        reverseDuration: Duration(milliseconds: 250),
                        child: NavBarPage(initialPage: 'profile'),
                      ),
                    );
                  },
                  text: 'Create Post',
                  options: FFButtonOptions(
                    width: 270,
                    height: 50,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/block_item_widget.dart';
import '../components/bs_add_comment_widget.dart';
import '../components/comment_card_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import '../profile_show_other/profile_show_other_widget.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final userPostsUpdateData = {
        'numViews': FieldValue.increment(0),
      };
      await widget.postReference.update(userPostsUpdateData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(32, 0, 0, 0),
          child: FlutterFlowIconButton(
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
        ),
        title: Text(
          ' ',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
      body: SafeArea(
        child: StreamBuilder<UserPostsRecord>(
          stream: UserPostsRecord.getDocument(widget.postReference),
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
            final stackUserPostsRecord = snapshot.data;
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Color(0xFFF4F7FF)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(-1, -0.34),
                      end: AlignmentDirectional(1, 0.34),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 16, 0, 40),
                        child: Text(
                          stackUserPostsRecord.postTitle,
                          style: FlutterFlowTheme.of(context).title1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                        child: FutureBuilder<UsersRecord>(
                          future: UsersRecord.getDocumentOnce(
                              stackUserPostsRecord.postUser),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SpinKitRipple(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    size: 20,
                                  ),
                                ),
                              );
                            }
                            final rowUsersRecord = snapshot.data;
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if ((rowUsersRecord.reference) ==
                                        (currentUserReference)) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NavBarPage(
                                              initialPage: 'profile'),
                                        ),
                                      );
                                    } else {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileShowOtherWidget(
                                            ownerRef: rowUsersRecord.reference,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: rowUsersRecord.photoUrl,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if ((rowUsersRecord.reference) ==
                                                (currentUserReference)) {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NavBarPage(
                                                          initialPage:
                                                              'profile'),
                                                ),
                                              );
                                            } else {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileShowOtherWidget(
                                                    ownerRef: rowUsersRecord
                                                        .reference,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            rowUsersRecord.userName,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                        Text(
                                          dateTimeFormat('relative',
                                              stackUserPostsRecord.timePosted),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryDark,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.share_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  size: 32,
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          final favoritesCreateData =
                                              createFavoritesRecordData(
                                            userRef: currentUserReference,
                                            createdAt: getCurrentTimestamp,
                                            postRef: widget.postReference,
                                          );
                                          await FavoritesRecord.collection
                                              .doc()
                                              .set(favoritesCreateData);

                                          final userPostsUpdateData = {
                                            'favorites': FieldValue.arrayUnion(
                                                [currentUserReference]),
                                            'numFavorites':
                                                FieldValue.increment(0),
                                          };
                                          await widget.postReference
                                              .update(userPostsUpdateData);
                                          await actions.updateConnection(
                                            currentUserReference,
                                            stackUserPostsRecord.postUser,
                                            10,
                                          );
                                        },
                                        child: Icon(
                                          Icons.outlined_flag,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    if (functions.isFavoritedByUser(
                                            stackUserPostsRecord,
                                            currentUserReference) ??
                                        true)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                        child: StreamBuilder<
                                            List<FavoritesRecord>>(
                                          stream: queryFavoritesRecord(
                                            queryBuilder: (favoritesRecord) =>
                                                favoritesRecord
                                                    .where('userRef',
                                                        isEqualTo:
                                                            currentUserReference)
                                                    .where('postRef',
                                                        isEqualTo: widget
                                                            .postReference),
                                            singleRecord: true,
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: SpinKitRipple(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              );
                                            }
                                            List<FavoritesRecord>
                                                removeFromFavBtnFavoritesRecordList =
                                                snapshot.data;
                                            // Return an empty Container when the document does not exist.
                                            if (snapshot.data.isEmpty) {
                                              return Container();
                                            }
                                            final removeFromFavBtnFavoritesRecord =
                                                removeFromFavBtnFavoritesRecordList
                                                        .isNotEmpty
                                                    ? removeFromFavBtnFavoritesRecordList
                                                        .first
                                                    : null;
                                            return InkWell(
                                              onTap: () async {
                                                final userPostsUpdateData = {
                                                  'favorites':
                                                      FieldValue.arrayRemove([
                                                    currentUserReference
                                                  ]),
                                                  'numFavorites':
                                                      FieldValue.increment(0),
                                                };
                                                await widget.postReference
                                                    .update(
                                                        userPostsUpdateData);
                                                await removeFromFavBtnFavoritesRecord
                                                    .reference
                                                    .delete();
                                                await actions.updateConnection(
                                                  currentUserReference,
                                                  stackUserPostsRecord.postUser,
                                                  -10,
                                                );
                                              },
                                              child: Icon(
                                                Icons.flag_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                size: 32,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional(0, 1),
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 25, 0, 25),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: FlutterFlowExpandedImageView(
                                      image: CachedNetworkImage(
                                        imageUrl:
                                            stackUserPostsRecord.postPhoto,
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: stackUserPostsRecord.postPhoto,
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: stackUserPostsRecord.postPhoto,
                                transitionOnUserGestures: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(28),
                                    topRight: Radius.circular(28),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: stackUserPostsRecord.postPhoto,
                                    width: double.infinity,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (!(functions.isLikedByUser(stackUserPostsRecord,
                                  currentUserReference)) ??
                              true)
                            Align(
                              alignment: AlignmentDirectional(1, 1),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                                child: InkWell(
                                  onTap: () async {
                                    final userPostsUpdateData = {
                                      'likes': FieldValue.arrayUnion(
                                          [currentUserReference]),
                                      'numLikes': FieldValue.increment(0),
                                    };
                                    await widget.postReference
                                        .update(userPostsUpdateData);
                                    await actions.updateConnection(
                                      currentUserReference,
                                      stackUserPostsRecord.postUser,
                                      5,
                                    );
                                  },
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .background,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 18,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          offset: Offset(0, 4),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 12, 24, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.thumb_up_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryDark,
                                            size: 24,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8, 0, 0, 0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                formatNumber(
                                                  stackUserPostsRecord.numLikes,
                                                  formatType:
                                                      FormatType.compact,
                                                ),
                                                '0',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Lato',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryDark,
                                                        fontSize: 16,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (functions.isLikedByUser(
                                  stackUserPostsRecord, currentUserReference) ??
                              true)
                            Align(
                              alignment: AlignmentDirectional(1, 1),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                                child: InkWell(
                                  onTap: () async {
                                    final userPostsUpdateData = {
                                      'likes': FieldValue.arrayRemove(
                                          [currentUserReference]),
                                      'numLikes': FieldValue.increment(0),
                                    };
                                    await widget.postReference
                                        .update(userPostsUpdateData);
                                    await actions.updateConnection(
                                      currentUserReference,
                                      stackUserPostsRecord.postUser,
                                      -5,
                                    );
                                  },
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 18,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          offset: Offset(0, 4),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 12, 24, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.thumb_up_alt_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8, 0, 0, 0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                formatNumber(
                                                  stackUserPostsRecord.numLikes,
                                                  formatType:
                                                      FormatType.compact,
                                                ),
                                                '0',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Lato',
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 0),
                        child: FutureBuilder<List<BlocksRecord>>(
                          future: queryBlocksRecordOnce(
                            queryBuilder: (blocksRecord) => blocksRecord
                                .where('postRef',
                                    isEqualTo: widget.postReference)
                                .orderBy('createdAt'),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SpinKitRipple(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    size: 20,
                                  ),
                                ),
                              );
                            }
                            List<BlocksRecord> columnBlocksRecordList =
                                snapshot.data;
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  columnBlocksRecordList.length, (columnIndex) {
                                final columnBlocksRecord =
                                    columnBlocksRecordList[columnIndex];
                                return BlockItemWidget(
                                  block: columnBlocksRecord,
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Comments ',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            Text(
                              '(',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            Text(
                              valueOrDefault<String>(
                                formatNumber(
                                  stackUserPostsRecord.numComments,
                                  formatType: FormatType.compact,
                                ),
                                '0',
                              ),
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                            Text(
                              ')',
                              style: FlutterFlowTheme.of(context).title2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 16, 40, 0),
                        child: InkWell(
                          onTap: () async {
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: BsAddCommentWidget(
                                    userPost: stackUserPostsRecord,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 10, 16, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 0, 0, 0),
                                    child: Text(
                                      'Add a comment...',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20),
                        child: StreamBuilder<List<PostCommentsRecord>>(
                          stream: queryPostCommentsRecord(
                            queryBuilder: (postCommentsRecord) =>
                                postCommentsRecord
                                    .where('post',
                                        isEqualTo:
                                            stackUserPostsRecord.reference)
                                    .where('level', isEqualTo: 0)
                                    .orderBy('timePosted', descending: true),
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SpinKitRipple(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    size: 20,
                                  ),
                                ),
                              );
                            }
                            List<PostCommentsRecord>
                                columnPostCommentsRecordList = snapshot.data;
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(
                                  columnPostCommentsRecordList.length,
                                  (columnIndex) {
                                final columnPostCommentsRecord =
                                    columnPostCommentsRecordList[columnIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 30),
                                  child: CommentCardWidget(
                                    comment: columnPostCommentsRecord,
                                    post: stackUserPostsRecord,
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

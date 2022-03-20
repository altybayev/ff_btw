import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../category_details/category_details_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../post_details/post_details_widget.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PostPreviewCardCopyWidget extends StatefulWidget {
  const PostPreviewCardCopyWidget({
    Key key,
    this.post,
  }) : super(key: key);

  final UserPostsRecord post;

  @override
  _PostPreviewCardCopyWidgetState createState() =>
      _PostPreviewCardCopyWidgetState();
}

class _PostPreviewCardCopyWidgetState extends State<PostPreviewCardCopyWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              await actions.updateConnection(
                currentUserReference,
                widget.post.postUser,
                20,
              );
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  child: PostDetailsWidget(
                    postReference: widget.post.reference,
                  ),
                ),
              );
            },
            child: Hero(
              tag: widget.post.postPhoto,
              transitionOnUserGestures: true,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.post.postPhoto,
                  width: 92,
                  height: 141,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: CategoryDetailsWidget(
                                  categoryRef: widget.post.category,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            widget.post.categoryName,
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Lato',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                final favoritesCreateData =
                                    createFavoritesRecordData(
                                  userRef: currentUserReference,
                                  createdAt: getCurrentTimestamp,
                                  postRef: widget.post.reference,
                                );
                                await FavoritesRecord.collection
                                    .doc()
                                    .set(favoritesCreateData);

                                final userPostsUpdateData = {
                                  'favorites': FieldValue.arrayUnion(
                                      [currentUserReference]),
                                  'numFavorites': FieldValue.increment(0),
                                };
                                await widget.post.reference
                                    .update(userPostsUpdateData);
                              },
                              child: Icon(
                                Icons.outlined_flag,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                          if (functions.isFavoritedByUser(
                                  widget.post, currentUserReference) ??
                              true)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: StreamBuilder<List<FavoritesRecord>>(
                                stream: queryFavoritesRecord(
                                  queryBuilder: (favoritesRecord) =>
                                      favoritesRecord
                                          .where('userRef',
                                              isEqualTo: currentUserReference)
                                          .where('postRef',
                                              isEqualTo: widget.post.reference),
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
                                          color: FlutterFlowTheme.of(context)
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
                                        'favorites': FieldValue.arrayRemove(
                                            [currentUserReference]),
                                        'numFavorites': FieldValue.increment(0),
                                      };
                                      await widget.post.reference
                                          .update(userPostsUpdateData);
                                      await removeFromFavBtnFavoritesRecord
                                          .reference
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.flag_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      size: 24,
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: InkWell(
                      onTap: () async {
                        await actions.updateConnection(
                          currentUserReference,
                          widget.post.postUser,
                          20,
                        );
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: PostDetailsWidget(
                              postReference: widget.post.reference,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.post.postTitle,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.thumbsUp,
                          color: FlutterFlowTheme.of(context).primaryDark,
                          size: 16,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            valueOrDefault<String>(
                              formatNumber(
                                widget.post.numLikes,
                                formatType: FormatType.compact,
                              ),
                              '0',
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.clock,
                            color: FlutterFlowTheme.of(context).primaryDark,
                            size: 16,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(
                            valueOrDefault<String>(
                              dateTimeFormat(
                                  'relative', widget.post.timePosted),
                              '...',
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
          ),
        ],
      ),
    );
  }
}

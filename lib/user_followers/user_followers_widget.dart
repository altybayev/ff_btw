import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UserFollowersWidget extends StatefulWidget {
  const UserFollowersWidget({
    Key key,
    this.owner,
  }) : super(key: key);

  final UsersRecord owner;

  @override
  _UserFollowersWidgetState createState() => _UserFollowersWidgetState();
}

class _UserFollowersWidgetState extends State<UserFollowersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
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
          StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget.owner.reference),
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
              final mainContainerUsersRecord = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 44, 40, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 30,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Followers',
                                  style: FlutterFlowTheme.of(context)
                                      .title1
                                      .override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryDark,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 40),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                          child: StreamBuilder<List<FollowersRecord>>(
                            stream: queryFollowersRecord(
                              queryBuilder: (followersRecord) =>
                                  followersRecord.where('followingRef',
                                      isEqualTo: widget.owner.reference),
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
                              List<FollowersRecord> columnFollowersRecordList =
                                  snapshot.data;
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    columnFollowersRecordList.length,
                                    (columnIndex) {
                                  final columnFollowersRecord =
                                      columnFollowersRecordList[columnIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: StreamBuilder<UsersRecord>(
                                      stream: UsersRecord.getDocument(
                                          columnFollowersRecord.followerRef),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                              ),
                                            ),
                                          );
                                        }
                                        final rowUsersRecord = snapshot.data;
                                        return Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 84,
                                              height: 84,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(28),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .darkBlue,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 8, 8),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        valueOrDefault<String>(
                                                      rowUsersRecord.photoUrl,
                                                      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y&s=200',
                                                    ),
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(20, 0, 0, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      rowUsersRecord.userName,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title3,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 4, 0, 0),
                                                      child: Text(
                                                        rowUsersRecord.position,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText2
                                                                .override(
                                                                  fontFamily:
                                                                      'Lato',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .darkBlue,
                                                                  fontSize: 16,
                                                                ),
                                                      ),
                                                    ),
                                                    Stack(
                                                      children: [
                                                        if (!(functions.isFollowingByUser(
                                                                rowUsersRecord,
                                                                currentUserReference)) ??
                                                            true)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        12,
                                                                        0,
                                                                        0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                final usersUpdateData =
                                                                    {
                                                                  'followers_count':
                                                                      FieldValue
                                                                          .increment(
                                                                              1),
                                                                  'followers':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    currentUserReference
                                                                  ]),
                                                                };
                                                                await rowUsersRecord
                                                                    .reference
                                                                    .update(
                                                                        usersUpdateData);

                                                                final followersCreateData =
                                                                    createFollowersRecordData(
                                                                  followerRef:
                                                                      currentUserReference,
                                                                  createdAt:
                                                                      getCurrentTimestamp,
                                                                  followingRef:
                                                                      rowUsersRecord
                                                                          .reference,
                                                                );
                                                                await FollowersRecord
                                                                    .collection
                                                                    .doc()
                                                                    .set(
                                                                        followersCreateData);
                                                              },
                                                              text: 'Follow',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: 122,
                                                                height: 25,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Lato',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    12,
                                                              ),
                                                            ),
                                                          ),
                                                        if (!(functions.isFollowingByUser(
                                                                rowUsersRecord,
                                                                currentUserReference)) ??
                                                            true)
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        12,
                                                                        0,
                                                                        0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                final usersUpdateData =
                                                                    {
                                                                  'followers':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    currentUserReference
                                                                  ]),
                                                                  'followers_count':
                                                                      FieldValue
                                                                          .increment(
                                                                              -1),
                                                                };
                                                                await rowUsersRecord
                                                                    .reference
                                                                    .update(
                                                                        usersUpdateData);
                                                                await actions
                                                                    .deleteFromFollowers(
                                                                  rowUsersRecord
                                                                      .reference,
                                                                  currentUserReference,
                                                                );
                                                              },
                                                              text: 'Unfollow',
                                                              options:
                                                                  FFButtonOptions(
                                                                width: 122,
                                                                height: 25,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .background,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2
                                                                    .override(
                                                                      fontFamily:
                                                                          'Lato',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  width: 1,
                                                                ),
                                                                borderRadius:
                                                                    12,
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
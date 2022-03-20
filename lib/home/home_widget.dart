import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/no_data_widget.dart';
import '../components/post_preview_card_copy_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(40, 72, 40, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Hi, ',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.of(context)
                                            .darkBlue,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                AuthUserStreamWidget(
                                  child: Text(
                                    currentUserDocument?.userName,
                                    style: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
                                          fontFamily: 'Lato',
                                          color: FlutterFlowTheme.of(context)
                                              .darkBlue,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                ),
                                Text(
                                  '!',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Lato',
                                        color: FlutterFlowTheme.of(context)
                                            .darkBlue,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'Welcome back',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Lato',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryDark,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.bell,
                        color: FlutterFlowTheme.of(context).primaryDark,
                        size: 32,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(40, 40, 40, 0),
                  child: StreamBuilder<List<FeedsRecord>>(
                    stream: queryFeedsRecord(
                      queryBuilder: (feedsRecord) => feedsRecord
                          .where('userRef', isEqualTo: currentUserReference)
                          .orderBy('rank', descending: true)
                          .orderBy('createdAt', descending: true),
                    ),
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
                      List<FeedsRecord> columnFeedsRecordList = snapshot.data;
                      if (columnFeedsRecordList.isEmpty) {
                        return NoDataWidget();
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(columnFeedsRecordList.length,
                            (columnIndex) {
                          final columnFeedsRecord =
                              columnFeedsRecordList[columnIndex];
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: StreamBuilder<UserPostsRecord>(
                              stream: UserPostsRecord.getDocument(
                                  columnFeedsRecord.postRef),
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
                                final containerUserPostsRecord = snapshot.data;
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: PostPreviewCardCopyWidget(
                                    post: containerUserPostsRecord,
                                  ),
                                );
                              },
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
      ),
    );
  }
}

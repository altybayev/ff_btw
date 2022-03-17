import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserProfileWidget extends StatefulWidget {
  const EditUserProfileWidget({Key key}) : super(key: key);

  @override
  _EditUserProfileWidgetState createState() => _EditUserProfileWidgetState();
}

class _EditUserProfileWidgetState extends State<EditUserProfileWidget> {
  String uploadedFileUrl = '';
  TextEditingController fullnameController;
  TextEditingController positionController;
  TextEditingController bioController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
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
        final editUserProfileUsersRecord = snapshot.data;
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
              'Edit Profile',
              style: FlutterFlowTheme.of(context).title2,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
          body: SafeArea(
            child: Stack(
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Stack(
                          alignment: AlignmentDirectional(0, 1),
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 40, 30),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 15,
                                      color: Color(0x0F5282FF),
                                      offset: Offset(0, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      32, 32, 32, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Stack(
                                          alignment: AlignmentDirectional(0, 1),
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 24),
                                              child: Container(
                                                width: 144,
                                                height: 144,
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
                                                      .fromSTEB(15, 15, 15, 15),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            22),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        editUserProfileUsersRecord
                                                            .photoUrl,
                                                        'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y&s=200',
                                                      ),
                                                      width: 112,
                                                      height: 112,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (uploadedFileUrl != null &&
                                                uploadedFileUrl != '')
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 15, 15, 40),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  child: Image.network(
                                                    uploadedFileUrl,
                                                    width: 112,
                                                    height: 112,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 24,
                                              borderWidth: 1,
                                              buttonSize: 48,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .darkBlue,
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                final selectedMedia =
                                                    await selectMediaWithSourceBottomSheet(
                                                  context: context,
                                                  allowPhoto: true,
                                                  backgroundColor: Colors.white,
                                                  textColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryDark,
                                                  pickerFontFamily: 'Lato',
                                                );
                                                if (selectedMedia != null &&
                                                    validateFileFormat(
                                                        selectedMedia
                                                            .storagePath,
                                                        context)) {
                                                  showUploadMessage(
                                                    context,
                                                    'Uploading file...',
                                                    showLoading: true,
                                                  );
                                                  final downloadUrl =
                                                      await uploadData(
                                                          selectedMedia
                                                              .storagePath,
                                                          selectedMedia.bytes);
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  if (downloadUrl != null) {
                                                    setState(() =>
                                                        uploadedFileUrl =
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 36, 0, 0),
                                        child: TextFormField(
                                          controller: fullnameController ??=
                                              TextEditingController(
                                            text: editUserProfileUsersRecord
                                                .userName,
                                          ),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Full name',
                                            hintText: 'Enter your full name...',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 14, 0, 0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryDark,
                                                fontSize: 16,
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 36, 0, 0),
                                        child: TextFormField(
                                          controller: positionController ??=
                                              TextEditingController(
                                            text: editUserProfileUsersRecord
                                                .position,
                                          ),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Position',
                                            hintText: 'Enter your position...',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 14, 0, 0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryDark,
                                                fontSize: 16,
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 36, 0, 56),
                                        child: TextFormField(
                                          controller: bioController ??=
                                              TextEditingController(
                                            text:
                                                editUserProfileUsersRecord.bio,
                                          ),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Bio',
                                            hintText: 'Enter your bio...',
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE6E6E6),
                                                width: 0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 14, 0, 0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryDark,
                                                fontSize: 16,
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (uploadedFileUrl != null &&
                                        uploadedFileUrl != '') {
                                      final usersUpdateData =
                                          createUsersRecordData(
                                        userName:
                                            fullnameController?.text ?? '',
                                        position:
                                            positionController?.text ?? '',
                                        bio: bioController?.text ?? '',
                                        photoUrl: uploadedFileUrl,
                                      );
                                      await editUserProfileUsersRecord.reference
                                          .update(usersUpdateData);
                                    } else {
                                      final usersUpdateData =
                                          createUsersRecordData(
                                        userName:
                                            fullnameController?.text ?? '',
                                        position:
                                            positionController?.text ?? '',
                                        bio: bioController?.text ?? '',
                                      );
                                      await editUserProfileUsersRecord.reference
                                          .update(usersUpdateData);
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Profile updated successfuly',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Lato',
                                                color: Colors.white,
                                              ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  },
                                  text: 'UPDATE',
                                  options: FFButtonOptions(
                                    width: 180,
                                    height: 60,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .title3
                                        .override(
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

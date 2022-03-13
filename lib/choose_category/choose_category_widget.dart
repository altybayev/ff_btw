import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseCategoryWidget extends StatefulWidget {
  const ChooseCategoryWidget({
    Key key,
    this.postRef,
  }) : super(key: key);

  final DocumentReference postRef;

  @override
  _ChooseCategoryWidgetState createState() => _ChooseCategoryWidgetState();
}

class _ChooseCategoryWidgetState extends State<ChooseCategoryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          'Choose Category',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                  child: Text(
                    'Tap on category',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ),
                FutureBuilder<List<CategoriesRecord>>(
                  future: queryCategoriesRecordOnce(
                    queryBuilder: (categoriesRecord) =>
                        categoriesRecord.orderBy('name'),
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
                    List<CategoriesRecord> categoriesCategoriesRecordList =
                        snapshot.data;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children:
                          List.generate(categoriesCategoriesRecordList.length,
                              (categoriesIndex) {
                        final categoriesCategoriesRecord =
                            categoriesCategoriesRecordList[categoriesIndex];
                        return InkWell(
                          onTap: () async {
                            final userPostsUpdateData =
                                createUserPostsRecordData(
                              category: categoriesCategoriesRecord.reference,
                              categoryName: categoriesCategoriesRecord.name,
                            );
                            await widget.postRef.update(userPostsUpdateData);
                            Navigator.pop(context);
                          },
                          child: ListTile(
                            title: Text(
                              categoriesCategoriesRecord.name,
                              style: FlutterFlowTheme.of(context).title3,
                            ),
                            dense: false,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

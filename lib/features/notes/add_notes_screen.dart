import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reddog_mobile_app/providers/enquiry_provider.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';
import 'package:reddog_mobile_app/services/enquiry_service.dart';

import '../../core/ui_state.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class AddNotesWidget extends StatefulWidget {
  dynamic enquiryId;
   AddNotesWidget(this.enquiryId,{super.key});

  @override
  State<AddNotesWidget> createState() => _AddNotesWidgetState();
}

class _AddNotesWidgetState extends State<AddNotesWidget> {

  String errorMessage = "";
  bool validateNote(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        errorMessage = "Enter a note before pressing submit button";
      });
      return false;
    } else {
      setState(() {
        errorMessage = "";
      });
      return true;
    }
  }

  TextEditingController noteController = TextEditingController();
  TextEditingController updateNoteController = TextEditingController();
  EnquiryProvider enquiryProvider = EnquiryProvider(enquiryRepository: EnquiryRepository());

  @override
  void initState(){
    super.initState();
    enquiryProvider.getCommentsList(widget.enquiryId);
  }

  onSubmitComment() async {
    if (noteController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await enquiryProvider.postComment(
          widget.enquiryId,
          noteController.text
      );
      if(enquiryProvider.postCommentModel.message == "success") {
        enquiryProvider.getCommentsList(widget.enquiryId);
        FocusScope.of(context).unfocus();
        noteController.clear();
        setState(() {
          isLoading = false;
        });
      }else{
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final snackBar = SnackBar(
            backgroundColor: Colors.blue,
            content: Container(
              height: 30,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ooops!!Something went wrong.Please try again later!',
                    // style: submitButtonText,
                  )),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        });
      }
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Enter your comments';
      });
    }
  }

  onUpdateComment(dynamic commentId) async {
    if (updateNoteController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await enquiryProvider.editComment(
          commentId,
          updateNoteController.text
      );
      if(enquiryProvider.updateCommentModel.message == "success") {
        enquiryProvider.getCommentsList(widget.enquiryId);
        FocusScope.of(context).unfocus();
        updateNoteController.clear();
        setState(() {
          isLoading = false;
          onEditClicked = false;
        });
      }else{
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final snackBar = SnackBar(
            backgroundColor: Colors.blue,
            content: Container(
              height: 30,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ooops!!Something went wrong.Please try again later!',
                    // style: submitButtonText,
                  )),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        });
      }
    } else {
      setState(() {
        isLoading = false;
        onEditClicked = false;
        errorMessage = 'Enter your comments';
      });
    }
  }

  bool isLoading = false;
  bool onEditClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commentWidget(),

        const SizedBox(height: 20),
        onEditClicked == false ?
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextField(
            // style: postTextFieldStyle,
            autofocus: true,
            cursorColor: blackColor,
            controller: noteController,
            onChanged: (_) => setState((){}),
            decoration:  InputDecoration(
              fillColor: blackColor,
              isDense: true,
              errorText: noteController.text == '' ? errorMessage : '',
              hintText: 'Enter your Comments',
              hintStyle: hintTextStyle,
              suffixIcon:
              InkWell(
                onTap: (){
                  onSubmitComment();
                },
                child: isLoading == false ?
                const Icon(
                  Icons.send_outlined,
                  color: loginBgColor,
                ) :
                const CircularProgressIndicator(
                  color: loginBgColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: titleTextColor,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: titleTextColor,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: titleTextColor,
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: titleTextColor,
                ),
              ),
              // disabledBorder: InputBorder.none,
            ),
            minLines: 1, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: 25,
          ),
        ) : SizedBox(),
      ],
    );
  }

Widget commentWidget(){
    return ChangeNotifierProvider<EnquiryProvider>(
      create: (ctx) {
        return enquiryProvider;
      },
  child: Consumer<EnquiryProvider>(
    builder: (ctx, data, _) {
      var state = data.getCommentsLiveData().getValue();
      print(state);
      if (state is IsLoading) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Center(
            child: CircularProgressIndicator(
              color: loginBgColor,
            ),
          ),
        );
      }else if (state is Success) {
        return ListView.builder(
          itemCount: data.getCommentModel.data!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, index) =>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            color: unselectedRadioColor
                        ),
                        child: Text(
                          '${data.getCommentModel.data![index].message}',
                          style: noteTextStyle,
                        ),
                      ),

                      const SizedBox(width: 25),

                      PopupMenuButton(
                        child: Icon(
                          Icons.more_vert_outlined,
                          size: 20,
                        ),
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuItem<String>>[
                            PopupMenuItem<String>(
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Edit',
                                      style: popupMenuTextStyle,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    onEditClicked = true;
                                  });
                                  updateNoteController.text = '${data.getCommentModel.data![index].message}';
                                },
                              ),
                              height: 31,
                            ),
                            PopupMenuItem<String>(
                              child: TextButton(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text('Remove',
                                        style: popupMenuTextStyle
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  deleteCommentApi(
                                      widget.enquiryId,
                                      '${data.getCommentModel.data![index].id}');
                                  enquiryProvider.getCommentsList(widget.enquiryId);
                                },
                              ),
                              height: 31,
                            ),
                          ];
                        },
                      )
                    ],
                  ),

                  const SizedBox(height: 8),

                  onEditClicked == true ?
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TextField(
                      // style: postTextFieldStyle,
                      autofocus: true,
                      cursorColor: blackColor,
                      controller: updateNoteController,
                      onChanged: (_) => setState((){}),
                      decoration:  InputDecoration(
                        fillColor: blackColor,
                        isDense: true,
                        errorText: updateNoteController.text == '' ? errorMessage : '',
                        hintText: 'Enter your Comments',
                        hintStyle: hintTextStyle,
                        suffixIcon:
                        InkWell(
                          onTap: (){
                            onUpdateComment(
                              '${data.getCommentModel.data![index].id}'
                            );
                          },
                          child: isLoading == false ?
                          const Icon(
                            Icons.send_outlined,
                            color: loginBgColor,
                          ) :
                          const CircularProgressIndicator(
                            color: loginBgColor,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: titleTextColor,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: titleTextColor,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: titleTextColor,
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: titleTextColor,
                          ),
                        ),
                        // disabledBorder: InputBorder.none,
                      ),
                      minLines: 1, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: 25,
                    ),
                  ) : SizedBox()
                ],
              ),
        );
      }else if (state is Failure) {
        return Center(
            child: Text('No Comments')
        );
      } else {
        return Container();
      }
    },
  ),
    );
}
}

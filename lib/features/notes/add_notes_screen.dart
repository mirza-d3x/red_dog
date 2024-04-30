import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/providers/enquiry_provider.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';

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
  EnquiryProvider enquiryProvider = EnquiryProvider(enquiryRepository: EnquiryRepository());

  // onSubmit(){
  //   final isValidNote = validateNote(noteController.text);
  //   if(isValidNote){
  //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  TabViewScreen(false)));
  //   }
  // }
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
        // enquiryProvider.getChannelConnectPost(widget.channelId);
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: 5,
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
                          'Previous notes',
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
                ],
              ),
        ),

        const SizedBox(height: 20),
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
        ),
      ],
    );
  }
}

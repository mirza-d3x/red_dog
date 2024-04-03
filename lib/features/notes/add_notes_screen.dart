import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class AddNotesWidget extends StatefulWidget {
  const AddNotesWidget({super.key});

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

  onSubmit(){
    final isValidNote = validateNote(noteController.text);
    if(isValidNote){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  TabViewScreen(false)));
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              onSubmit();
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
    );
  }
}

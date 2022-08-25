import 'package:fast_and_yummy/api/api.dart';
import 'package:fast_and_yummy/api/linkapi.dart';
import 'package:fast_and_yummy/main.dart';
import 'package:flutter/material.dart';

class support extends StatefulWidget {
  support({Key? key}) : super(key: key);

  @override
  State<support> createState() => _supportState();
}

class _supportState extends State<support> {
  Color basicColor = const Color.fromARGB(255, 37, 179, 136);
  String? questionString;
  bool loading = true;

  List<dynamic> questions = [];
  /******************** Start Api Functions *********************** */
  Api api = Api();
  bringAllSupport() async {
    var response = await api
        .postReq(bringSupportQuestions, {"id": sharedPref.getString("id")});
    if (response['status'] == "suc") {
      setState(() {
        questions = response['data'];
      });
    }
    setState(() {
      loading = false;
    });
  }

  addQuestion(String ques) async {
    setState(() {
      loading = true;
    });
    var response = await api.postReq(addSupportQuestion,
        {"id": sharedPref.getString("id"), "question": ques});
    bringAllSupport();
  }

  deleteQuestion(String id) async {
    setState(() {
      loading = true;
    });
    var response = await api.postReq(deleteSupportQues, {"id": id});
    bringAllSupport();
  }

  /******************** End Api Functions *********************** */
  @override
  void initState() {
    bringAllSupport();
    super.initState();
  }

  GlobalKey<FormState> textFormState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    bool sendQuestion() {
      var formData = textFormState.currentState;

      if (formData!.validate()) {
        formData.save();

        addQuestion(questionString!);

        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: basicColor,
        title: const Text("Support Section"),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: loading
          ? SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
                child: CircularProgressIndicator(color: basicColor),
              ),
            )
          : Form(
              key: textFormState,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: const Text(
                      "This section is for inquiries and complaints about the application and how to use it",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "You cannot send empty question !";
                        } else if (value.length < 10) {
                          return "invalid Question !";
                        } else {
                          return null;
                        }
                      }),
                      onSaved: (value) {
                        questionString = value;
                      },
                      maxLines: 5,
                      maxLength: 250,
                      cursorColor: basicColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: basicColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: basicColor)),
                        labelText: "Ask your question",
                        labelStyle: TextStyle(color: basicColor),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: MaterialButton(
                      color: basicColor,
                      onPressed: () {
                        if (sendQuestion()) {
                          setState(() {
                            showSuccessSnackBarMSG("Send");
                          });
                        } else {
                          showFaildSnackBarMSG();
                        }
                      },
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    trailing: Icon(
                      Icons.question_mark,
                      color: basicColor,
                    ),
                    title: const Text("My Questions"),
                  ),
                  ...List.generate(
                      questions.length,
                      (index) => ListTile(
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deleteQuestion(questions[index]["questionID"]);
                                setState(() {
                                  showSuccessSnackBarMSG("Deleted");
                                });
                              },
                            ),
                            leading: Icon(
                              Icons.question_answer,
                              color: basicColor,
                            ),
                            title: Text(questions[index]["question"]),
                            subtitle:
                                Text("Answer: ${questions[index]["answer"]}"),
                          ))
                ],
              )),
            ),
    );
  }

  /************************** Start Functions ********************* */
  showSuccessSnackBarMSG(String msg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: basicColor.withOpacity(0.7),
      content: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          Text(
            msg,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
    ));
  }

  showFaildSnackBarMSG() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red.withOpacity(0.7),
      content: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 35,
            ),
          ),
          const Text(
            "Not Send",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(20),
    ));
  }
  /***************************** End Functions *********************** */
}

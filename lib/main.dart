import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:youtube/user.dart';

import 'package:youtube/user_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserNotifier(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/listscreen': (BuildContext context) => const NoteList(),
      },
      home: const Home(),
    );
  }
}

//                                  HOME

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String title = '';
  String note = '';
  get onSaved => null;
  @override
  Widget build(BuildContext context) {
    // UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Note Pad'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: (context.watch<UserNotifier>().title),
                  onSaved: onSaved,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white12,
                    helperText: 'Input your note title',
                    labelText: 'Title:',
                    suffixIcon: const Icon(Icons.topic),
                    hintText: ('Title:'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    contentPadding: const EdgeInsets.only(left: 8, right: 0),
                  ),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'mumu input something';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autocorrect: true,
                  onSaved: (value) {
                    (context.watch<User>().note);
                  },
                  controller: (context.watch<UserNotifier>().note),
                  decoration: InputDecoration(
                    labelText: 'Notes:',
                    filled: true,
                    suffixIcon: const Icon(Icons.note_add),
                    fillColor: Colors.white12,
                    helperText: 'Type your note here',
                    hintText: ('Notes:'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    contentPadding: const EdgeInsets.only(left: 8, right: 0),
                  ),

//  validator: (String value) {
//         return value.isEmpty ? '$labelText is required' : null;
//       },

                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Chey your brain dinnor tell you that you should fill it ni?';
                    }
                    return null;
                  },
                  // validator: (value) {
                  //   if (value.toString().isEmpty) {
                  //     return 'mumu input something';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (!_formkey.currentState!.validate()) {
                          return _formkey.currentState!.save();
                        }
                        (context
                            .read<UserNotifier>()
                            .addUser(User(note, title)));
                      },
                      child: const Text('Add Note'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoteList()),
                        );
                      },
                      child: const Text('Notes'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const ListBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//                                  NOTE LIST

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   showDialog(context: context, builder:  (context){
      //     return AlertDialog(
      //       content:

      //           Column(
      //             children: [
      //               Text(context.read<UserNotifier>().title.text),
      //               Text(context.read<UserNotifier>().note.text )
      //             ],
      //           ),

      //     );
      //   });
      // }),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Notes'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ListBuilder(),
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({Key? key}) : super(key: key);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) => Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title: ${context.read<UserNotifier>().title.text}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Note: ${context.read<UserNotifier>().note.text} ',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  (context.read<UserNotifier>().deleteUser(index));
                },
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        ),
      ),
      itemCount: context.watch<UserNotifier>().userList.length,
    );
  }
}

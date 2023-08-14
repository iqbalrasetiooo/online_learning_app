import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:online_learning_app/export.dart';

class AddVideoScreen extends StatefulWidget {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController titleC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  String? selectedCategory;
  String categoryValue = '';

  AddVideoScreen({super.key});
  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  TextEditingController txtFilePicker = TextEditingController();
  File? _video;
  List<int>? videoBytes;
  String? videoBase64;

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _video = File(pickedFile.path);
      videoBytes = await _video!.readAsBytes();
      videoBase64 = base64Encode(videoBytes!);
      print(videoBase64);
    }
  }

  @override
  Widget build(BuildContext context) {
    //fungsi untuk select file

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Video'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      readOnly: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'File harus diupload';
                        } else {
                          return null;
                        }
                      },
                      controller: txtFilePicker,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(color: Colors.white, width: 2)),
                        hintText: 'Upload File',
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      style: const TextStyle(fontSize: 16.0)),
                ),
                const SizedBox(width: 5),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.upload_file,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text('Pilih File', style: TextStyle(fontSize: 16.0)),
                  onPressed: () {
                    _pickVideo();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    minimumSize: const Size(122, 48),
                    maximumSize: const Size(122, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Add Video'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'dart:ffi';
import 'dart:convert';
import 'package:ffi/ffi.dart';

typedef ConvertFunc = Pointer<Int8> Function(
    Pointer<Int8> input, Pointer<Int8> lang);

class NumStringPage extends StatefulWidget {
  const NumStringPage({super.key});
  @override
  State<NumStringPage> createState() => _NumStringPageState();
}

class _NumStringPageState extends State<NumStringPage> {
  String result = '';
  String rustLang = '';
  var rustConvert;
  final TextEditingController controller = TextEditingController();

  int cStringLength(Pointer<Int8> string) {
    int length = 0;
    while (string[length] != 0) {
      length++;
    }
    return length;
  }

  String convert(String input) {
    final Pointer<Int8> resultPointer = rustConvert(
        input.toNativeUtf8().cast<Int8>(),
        rustLang.toNativeUtf8().cast<Int8>());
    final String result =
        utf8.decode(resultPointer.asTypedList(cStringLength(resultPointer)));
    calloc.free(resultPointer);
    return result;
  }

  DynamicLibrary loadLibrary() {
    rootBundle.loadString('assets/langs/italian.txt').then((value) {
      rustLang = value;
    });
    if (Platform.isAndroid) {
      return DynamicLibrary.open('lib/arm64-v8a/libnum_string.so');
    } else if (Platform.isLinux) {
      return DynamicLibrary.open('lib/libnum_string.so');
    } else if (Platform.isWindows) {
      return DynamicLibrary.open('libnum_string.dll');
    } else {
      throw Exception('Unsupported platform');
    }
  }

  @override
  void initState() {
    super.initState();
    final dylib = loadLibrary();
    rustConvert = dylib
        .lookup<NativeFunction<ConvertFunc>>('convert')
        .asFunction<ConvertFunc>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'e.g. 6.9',
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: controller.clear,
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  result = convert(value);
                });
              }),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: result));
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied to clipboard')));
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.vertical,
              child:
                  Text(convert(controller.text), textAlign: TextAlign.justify),
            ),
          ),
        ),
      ],
    );
  }
}

library;

export './feather_core_default.dart'
    if (dart.library.html) './feather_core_web.dart'
    //export form web - wasm
    if (dart.library.js_interop) './feather_core_web.dart';

use godot::prelude::*;

struct CatalystExtension;

#[gdextension]
unsafe impl ExtensionLibrary for CatalystExtension {}

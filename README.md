# catalyst

# Prerequisite

-   [Godot](https://godotengine.org/) : >= 4.2
-   [Rust](https://www.rust-lang.org/)

# Getting Started

1. Clone this repository.

```shell
git clone https://github.com/nonanonno/catalyst.git
```

2. Build the rust project: catalyst-lib.

```shell
cd catalyst-lib
cargo build
```

For convenience, I recommend to use [cargo-watch](https://crates.io/crates/cargo-watch) to automate build process instead.

```shell
cargo watch -C catalyst-lib -x build
```

3. Open godot project

```shell
godot --path catalyst -e
```

# Testing

```shell
cd catalyst-lib
cargo test
```

# Export (Release build)

To make release build image via CLI, execute the following commands.

```shell
# Release build Rust project
cd catalyst-lib
cargo build --release
cd ..

# Export godot application
# Make sure that the output directory is relative to the project.godot existent directory.
mkdir -p build
# For Linux
godot --path catalyst --export-release ../build/catalyst

# For macOC
godot --path catalyst --export-release ../build/catalyst.dmg
```

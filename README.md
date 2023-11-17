# IREE Runtime Hello World with vcpkg

## Instructions

### Cloning the Repository

Use GitHub's "Use this template" feature to create a new repository or clone it
manually:

```sh
$ git clone https://github.com/iree-org/iree-template-runtime-vcpkg.git
$ cd iree-template-runtime-vcpkg
$ git submodule update --init
```

This template has no requirement for iree as a submodule. But, vcpkg is required to
be added as a submodule. Microsoft suggests using vcpkg as a submodule so the consuming 
repo can stay self-contained.

### Building the Runtime

The [portfile.cmake](./iree/portfile.cmake) configures it for runtime-only compilation.
It also uses only submodules needed for iree-runtime for fastest installation.
A project wanting to build the compiler from source or include other HAL drivers 
(CUDA, Vulkan, multi-threaded CPU, etc) can change which options they set 
in the `vcpkg_cmake_configure` function of the portfile.cmake file.

### User Implementation Instructions

As a user, if you want to build the runtime for your particular sample, simply
change the last 8 lines of [CMakeLists.txt](./iree/CMakeLists.txt).

```
iree_cc_binary(
  NAME
    hello_world
  SRCS
    "hello_world.c"
  DEPS
    iree::runtime
)
```

Change this s.t. it is your intended exectuable name, sources, and dependencies.
Make sure the source files are also in the iree folder.

### Installation

Here are the actual installation instructions that will build the iree-runtime and
create the executable:

```sh
$ cp -r ./iree ./vcpkg/ports (also can mv instead of cp)
$ ./vcpkg/vcpkg/bootstrap-vcpkg.sh
$ ./vcpkg/vcpkg install iree
```

You will find the executable in the package's bin dir 
(./vcpkg/packages/iree_x64-linux/bin/hello_world)

### Compiling the Sample Module

This sample assumes that the latest IREE compiler release is installed and used
to compile the module. For many users upgrading their `iree-compiler` install
when they bump their submodule should be sufficient to ensure the compiler and
runtime are compatible. In the future the compiler and runtime will have more
support for version shifting.

The sample currently assumes a CPU HAL driver and only produces a VMFB
supporting that. Additional compiler options can be used to change the target
HAL driver, target device architecture, etc. IREE supports multi-targeting both
across device types (CPU/GPU/etc) and architectures (AArch64/x86-64/etc) but the
command line interfaces are still under development. Basic CPU cross-compiling
can be accomplished with the `--iree-llvm-target-triple=` flag specifying the
CPU architecture.

```sh
$ python -m pip install iree-compiler --upgrade --user
$ iree-compile \
    --iree-hal-target-backends=llvm-cpu \
    --iree-llvmcpu-target-triple=x86_64 \
    simple_mul.mlir \
    -o simple_mul.vmfb
```

### Running the Sample

The included sample program takes the device URI (in this case `local-sync`) and
compiled module file (`simple_mul.vmfb` as output from above) and prints the
output of a simple calculation. More advanced features like asynchronous
execution, providing output storage buffers for results, and stateful programs
are covered in other IREE samples.

```sh
$ ./vcpkg/packages/iree_x64-linux/bin/hello_world local-sync simple_mul.vmfb
4xf32=1 1.1 1.2 1.3
 *
4xf32=10 100 1000 10000
 =
4xf32=10 110 1200 13000
```

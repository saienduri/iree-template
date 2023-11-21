vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/openxla/iree.git
    REF 522fac0bfc3e933817b0e64ced377b0314363115
    PATCHES
        configuration.patch
)

vcpkg_from_git(
    OUT_SOURCE_PATH GOOGLETEST_SOURCE_PATH
    URL https://github.com/google/googletest.git
    REF 518387203b573f35477fa6872dd54620e70d2bdb
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/googletest/CMakeLists.txt")
    file(COPY "${GOOGLETEST_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/googletest")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH BENCHMARK_SOURCE_PATH
    URL https://github.com/google/benchmark.git
    REF da652a748675b679947710117329e9f77f374f2d
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/benchmark/CMakeLists.txt")
    file(COPY "${BENCHMARK_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/benchmark")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH CPUINFO_SOURCE_PATH
    URL https://github.com/pytorch/cpuinfo.git
    REF f44a9dabb2192ffb203ddd0c71f6373c7d82faed
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/cpuinfo/CMakeLists.txt")
    file(COPY "${CPUINFO_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/cpuinfo")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH FLATCC_SOURCE_PATH
    URL https://github.com/dvidelabs/flatcc.git
    REF b20f5d1059d50394415453e2a6f719532ee6278d
    HEAD_REF master
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/flatcc/readme.md")
    file(COPY "${FLATCC_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/flatcc")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH HIP-BUILD-DEPS_SOURCE_PATH
    URL https://github.com/shark-infra/hip-build-deps.git
    REF dedd03ce0e5d01f000dce60e463d0423cef1a62a
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/hip-build-deps/readme.md")
    file(COPY "${HIP-BUILD-DEPS_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/hip-build-deps")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH LIBYAML_SOURCE_PATH
    URL https://github.com/yaml/libyaml.git
    REF f8f760f7387d2cc56a2fc7b1be313a3bf3f7f58c
    HEAD_REF master
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/libyaml/readme.md")
    file(COPY "${LIBYAML_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/libyaml")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH MUSL_SOURCE_PATH
    URL https://github.com/powderluv/musl.git
    REF 3f701faace7addc75d16dea8a6cd769fa5b3f260
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/musl/readme")
    file(COPY "${MUSL_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/musl")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH PYBIND11_SOURCE_PATH
    URL https://github.com/pybind/pybind11.git
    REF 80dc998efced8ceb2be59756668a7e90e8bef917
    HEAD_REF master
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/pybind11/readme.rst")
    file(COPY "${PYBIND11_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/pybind11")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH SPIRV_CROSS_SOURCE_PATH
    URL https://github.com/KhronosGroup/SPIRV-Cross.git
    REF 6e1fb9b09efadee38748e0fd0e6210d329087e89
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/spirv_cross/readme.md")
    file(COPY "${SPIRV_CROSS_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/spirv_cross")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH SPIRV_HEADERS_SOURCE_PATH
    URL https://github.com/KhronosGroup/SPIRV-Headers.git
    REF b730938c033ede3572b660ab019b438509ba24d9
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/spirv_headers/readme.md")
    file(COPY "${SPIRV_HEADERS_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/spirv_headers")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH TRACY_SOURCE_PATH
    URL https://github.com/wolfpld/tracy.git
    REF 52b6af88ca0dccfd6b16eab9d518aeac802c0b0a
    HEAD_REF master
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/tracy/readme.md")
    file(COPY "${TRACY_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/tracy")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH VULKAN_HEADERS_SOURCE_PATH
    URL https://github.com/KhronosGroup/Vulkan-Headers.git
    REF df60f0316899460eeaaefa06d2dd7e4e300c1604
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/vulkan_headers/readme.md")
    file(COPY "${VULKAN_HEADERS_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/vulkan_headers")
endif()

vcpkg_from_git(
    OUT_SOURCE_PATH WEBGPU-HEADERS_SOURCE_PATH
    URL https://github.com/webgpu-native/webgpu-headers.git
    REF fa1c6ab4927ef1fa5731907b42b62ea93119866c
    HEAD_REF main
)

if (NOT EXISTS "${SOURCE_PATH}/third_party/webgpu-headers/readme.md")
    file(COPY "${WEBGPU-HEADERS_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/third_party/webgpu-headers")
endif()

file(COPY "${CMAKE_CURRENT_LIST_DIR}/ireeConfig.cmake" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/hello_world.c" DESTINATION "${SOURCE_PATH}")
file(READ "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" CONTENTS)
file(APPEND "${SOURCE_PATH}/CMakeLists.txt" "${CONTENTS}")

SET(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DIREE_BUILD_COMPILER=OFF
        -DIREE_BUILD_TESTS=OFF
        -DIREE_BUILD_SAMPLES=OFF
        -DIREE_HAL_DRIVER_DEFAULTS=OFF
        -DIREE_HAL_DRIVER_LOCAL_SYNC=ON
        -DIREE_HAL_EXECUTABLE_LOADER_DEFAULTS=OFF
        -DIREE_HAL_EXECUTABLE_LOADER_EMBEDDED_ELF=ON    
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/ireeConfig.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/iree")
vcpkg_cmake_config_fixup(CONFIG_PATH "lib/cmake/iree")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib" "${CURRENT_PACKAGES_DIR}/lib")


file(
    INSTALL "${SOURCE_PATH}/LICENSE"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    RENAME copyright
)
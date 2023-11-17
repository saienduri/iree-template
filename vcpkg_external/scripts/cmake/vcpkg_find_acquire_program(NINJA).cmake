set(program_name ninja)
set(program_version 1.10.2)
set(supported_on_unix ON)
set(version_command --version)
if(CMAKE_HOST_WIN32)
    set(download_filename "ninja-win-${program_version}.zip")
    set(tool_subdirectory "${program_version}-windows")
    set(download_urls "https://github.com/ninja-build/ninja/releases/download/v${program_version}/ninja-win.zip")
    set(download_sha512 6004140d92e86afbb17b49c49037ccd0786ce238f340f7d0e62b4b0c29ed0d6ad0bab11feda2094ae849c387d70d63504393714ed0a1f4d3a1f155af7a4f1ba3)
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    set(download_filename "ninja-mac-${program_version}.zip")
    set(download_urls "https://github.com/ninja-build/ninja/releases/download/v${program_version}/ninja-mac.zip")
    set(tool_subdirectory "${program_version}-osx")
    set(paths_to_search "${DOWNLOADS}/tools/ninja-${program_version}-osx")
    set(download_sha512 bcd12f6a3337591306d1b99a7a25a6933779ba68db79f17c1d3087d7b6308d245daac08df99087ff6be8dc7dd0dcdbb3a50839a144745fa719502b3a7a07260b)
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "FreeBSD")
    set(paths_to_search "${DOWNLOADS}/tools/${tool_subdirectory}-freebsd")
    set(supported_on_unix OFF)
else()
    execute_process(COMMAND "uname" "-m" OUTPUT_VARIABLE HOST_ARCH OUTPUT_STRIP_TRAILING_WHITESPACE)
    if(HOST_ARCH MATCHES "x86_64|amd64|AMD64")
        set(download_filename "ninja-linux-${program_version}.zip")
        set(download_urls "https://github.com/ninja-build/ninja/releases/download/v${program_version}/ninja-linux.zip")
        set(tool_subdirectory "${program_version}-linux")
        set(paths_to_search "${DOWNLOADS}/tools/ninja-${program_version}-linux")
        set(download_sha512 93e802e9c17fb59636cddde4bad1ddaadad624f4ecfee00d5c78790330a4e9d433180e795718cda27da57215ce643c3929cf72c85337ee019d868c56f2deeef3)
    else()
        set(version_command "") # somewhat hacky way to skip version check and use system binary
    endif()
endif()

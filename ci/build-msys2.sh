#!/bin/sh -e

if [ "$1" = "meson" ]; then
    meson setup build_meson      \
      -D cdda=enabled            \
      -D d3d-hwaccel=enabled     \
      -D d3d11=enabled           \
      -D dvdnav=enabled          \
      -D egl-angle-win32=enabled \
      -D jpeg=enabled            \
      -D lcms2=enabled           \
      -D libarchive=enabled      \
      -D libbluray=enabled       \
      -D libmpv=true             \
      -D libplacebo=enabled      \
      -D lua=luajit              \
      -D pdf-build=enabled       \
      -D rubberband=enabled      \
      -D shaderc=enabled         \
      -D spirv-cross=enabled     \
      -D tests=true              \
      -D uchardet=enabled        \
      -D vapoursynth=enabled     \
      -D vulkan=enabled
    meson compile -C build_meson --verbose
    cp ./build_meson/generated/mpv.com ./build_meson
    meson test -C build_meson
    ./build_meson/mpv.com --no-config -v --unittest=all-simple
fi

if [ "$1" = "waf" ]; then
    ./bootstrap.py
    ./waf configure            \
      --enable-cdda            \
      --enable-d3d-hwaccel     \
      --enable-d3d11           \
      --enable-dvdnav          \
      --enable-egl-angle-win32 \
      --enable-jpeg            \
      --enable-lcms2           \
      --enable-libarchive      \
      --enable-libbluray       \
      --enable-libmpv-shared   \
      --enable-libplacebo      \
      --enable-pdf-build       \
      --enable-rubberband      \
      --enable-shaderc         \
      --enable-spirv-cross     \
      --enable-tests           \
      --enable-uchardet        \
      --enable-vapoursynth     \
      --lua=luajit             \
      --enable-vulkan
    ./waf build --verbose
    ./build/mpv.com -v --no-config -v --unittest=all-simple
fi

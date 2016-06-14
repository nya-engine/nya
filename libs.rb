FFIGen.generate(
  module_name: "SDL2",
  ffi_lib:     "sdl2",
  headers:     %w[
    SDL2/SDL.h
    SDL2/SDL_main.h
    SDL2/SDL_stdinc.h
    SDL2/SDL_assert.h
    SDL2/SDL_atomic.h
    SDL2/SDL_audio.h
    SDL2/SDL_clipboard.h
    SDL2/SDL_cpuinfo.h
    SDL2/SDL_endian.h
    SDL2/SDL_error.h
    SDL2/SDL_events.h
    SDL2/SDL_filesystem.h
    SDL2/SDL_joystick.h
    SDL2/SDL_gamecontroller.h
    SDL2/SDL_haptic.h
    SDL2/SDL_hints.h
    SDL2/SDL_loadso.h
    SDL2/SDL_log.h
    SDL2/SDL_messagebox.h
    SDL2/SDL_mutex.h
    SDL2/SDL_power.h
    SDL2/SDL_render.h
    SDL2/SDL_rwops.h
    SDL2/SDL_system.h
    SDL2/SDL_thread.h
    SDL2/SDL_timer.h
    SDL2/SDL_version.h
    SDL2/SDL_video.h
  ],
  prefixes:    ["SDL_"],
  cflags:      ['-msse','-mmmx','-msse2','-msse3','-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include','-ferror-limit=0','-w'],
  output:      "cbind/sdl2.cr"
)

FFIGen.generate(
  module_name: "GL",
  ffi_lib:     "GL",
  headers:     %w[GL/gl.h],
  prefixes:    ["gl","GL"],
  cflags:      ['-msse','-mmmx','-msse2','-msse3','-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include'],
  output:      "cbind/gl.cr"
)

FFIGen.generate(
  module_name: "GLU",
  ffi_lib:     "GLU",
  headers:     %w[GL/glu.h],
  prefixes:    ["glu","GLU"],
  cflags:      ['-msse','-mmmx','-msse2','-msse3','-I/usr/lib/gcc/x86_64-linux-gnu/4.8/include'],
  output:      "cbind/glu.cr"
)

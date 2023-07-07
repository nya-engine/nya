{% begin %}
  @[Link(ldflags: {{ `pkgconf --libs sdl2 || pkg-config --libs sdl2`.stringify.chomp }})]
{%end%}
lib LibSDL2
  ASSERT_LEVEL                            =          2
  LIL_ENDIAN                              =       1234
  BIG_ENDIAN                              =       4321
  MUTEX_TIMEDOUT                          =          1
  RWOPS_UNKNOWN                           =          0
  RWOPS_WINFILE                           =          1
  RWOPS_STDFILE                           =          2
  RWOPS_JNIFILE                           =          3
  RWOPS_MEMORY                            =          4
  RWOPS_MEMORY_RO                         =          5
  RW_SEEK_SET                             =          0
  RW_SEEK_CUR                             =          1
  RW_SEEK_END                             =          2
  AUDIO_U8                                =     0x0008
  AUDIO_S8                                =     0x8008
  AUDIO_U16LSB                            =     0x0010
  AUDIO_S16LSB                            =     0x8010
  AUDIO_U16MSB                            =     0x1010
  AUDIO_S16MSB                            =     0x9010
  AUDIO_S32LSB                            =     0x8020
  AUDIO_S32MSB                            =     0x9020
  AUDIO_F32LSB                            =     0x8120
  AUDIO_F32MSB                            =     0x9120
  AUDIO_ALLOW_FREQUENCY_CHANGE            = 0x00000001
  AUDIO_ALLOW_FORMAT_CHANGE               = 0x00000002
  AUDIO_ALLOW_CHANNELS_CHANGE             = 0x00000004
  MIX_MAXVOLUME                           =        128
  CACHELINE_SIZE                          =        128
  WINDOWPOS_UNDEFINED_MASK                = 0x1FFF0000
  WINDOWPOS_CENTERED_MASK                 = 0x2FFF0000
  HAT_CENTERED                            =       0x00
  HAT_UP                                  =       0x01
  HAT_RIGHT                               =       0x02
  HAT_DOWN                                =       0x04
  HAT_LEFT                                =       0x08
  RELEASED                                =          0
  PRESSED                                 =          1
  IGNORE                                  =          0
  DISABLE                                 =          0
  ENABLE                                  =          1
  HAPTIC_POLAR                            =          0
  HAPTIC_CARTESIAN                        =          1
  HAPTIC_SPHERICAL                        =          2
  HAPTIC_INFINITY                         = 4294967295
  HINT_FRAMEBUFFER_ACCELERATION           = "SDL_FRAMEBUFFER_ACCELERATION"
  HINT_RENDER_DRIVER                      = "SDL_RENDER_DRIVER"
  HINT_RENDER_OPENGL_SHADERS              = "SDL_RENDER_OPENGL_SHADERS"
  HINT_RENDER_DIRECT3D_THREADSAFE         = "SDL_RENDER_DIRECT3D_THREADSAFE"
  HINT_RENDER_SCALE_QUALITY               = "SDL_RENDER_SCALE_QUALITY"
  HINT_RENDER_VSYNC                       = "SDL_RENDER_VSYNC"
  HINT_VIDEO_ALLOW_SCREENSAVER            = "SDL_VIDEO_ALLOW_SCREENSAVER"
  HINT_VIDEO_X11_XVIDMODE                 = "SDL_VIDEO_X11_XVIDMODE"
  HINT_VIDEO_X11_XINERAMA                 = "SDL_VIDEO_X11_XINERAMA"
  HINT_VIDEO_X11_XRANDR                   = "SDL_VIDEO_X11_XRANDR"
  HINT_GRAB_KEYBOARD                      = "SDL_GRAB_KEYBOARD"
  HINT_MOUSE_RELATIVE_MODE_WARP           = "SDL_MOUSE_RELATIVE_MODE_WARP"
  HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS       = "SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS"
  HINT_IDLE_TIMER_DISABLED                = "SDL_IOS_IDLE_TIMER_DISABLED"
  HINT_ORIENTATIONS                       = "SDL_IOS_ORIENTATIONS"
  HINT_ACCELEROMETER_AS_JOYSTICK          = "SDL_ACCELEROMETER_AS_JOYSTICK"
  HINT_XINPUT_ENABLED                     = "SDL_XINPUT_ENABLED"
  HINT_GAMECONTROLLERCONFIG               = "SDL_GAMECONTROLLERCONFIG"
  HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS   = "SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS"
  HINT_ALLOW_TOPMOST                      = "SDL_ALLOW_TOPMOST"
  HINT_TIMER_RESOLUTION                   = "SDL_TIMER_RESOLUTION"
  HINT_VIDEO_HIGHDPI_DISABLED             = "SDL_VIDEO_HIGHDPI_DISABLED"
  HINT_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK = "SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK"
  HINT_VIDEO_WIN_D3DCOMPILER              = "SDL_VIDEO_WIN_D3DCOMPILER"
  HINT_VIDEO_WINDOW_SHARE_PIXEL_FORMAT    = "SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT"
  HINT_VIDEO_MAC_FULLSCREEN_SPACES        = "SDL_VIDEO_MAC_FULLSCREEN_SPACES"
  MAX_LOG_MESSAGE                         =       4096
  MAJOR_VERSION                           =          2
  MINOR_VERSION                           =          0
  PATCHLEVEL                              =          2
  INIT_TIMER                              = 0x00000001
  INIT_AUDIO                              = 0x00000010
  INIT_VIDEO                              = 0x00000020
  INIT_JOYSTICK                           = 0x00000200
  INIT_HAPTIC                             = 0x00001000
  INIT_GAMECONTROLLER                     = 0x00002000
  INIT_EVENTS                             = 0x00004000
  INIT_NOPARACHUTE                        = 0x00100000
  enum Bool
    FALSE = 0
    TRUE  = 1
  end

  enum Scancode : UInt32
    UNKNOWN = 0

    A =  4
    B =  5
    C =  6
    D =  7
    E =  8
    F =  9
    G = 10
    H = 11
    I = 12
    J = 13
    K = 14
    L = 15
    M = 16
    N = 17
    O = 18
    P = 19
    Q = 20
    R = 21
    S = 22
    T = 23
    U = 24
    V = 25
    W = 26
    X = 27
    Y = 28
    Z = 29

    A1 = 30
    A2 = 31
    A3 = 32
    A4 = 33
    A5 = 34
    A6 = 35
    A7 = 36
    A8 = 37
    A9 = 38
    A0 = 39

    RETURN    = 40
    ESCAPE    = 41
    BACKSPACE = 42
    TAB       = 43
    SPACE     = 44

    MINUS        = 45
    EQUALS       = 46
    LEFTBRACKET  = 47
    RIGHTBRACKET = 48
    BACKSLASH    = 49
    NONUSHASH    = 50
    SEMICOLON    = 51
    APOSTROPHE   = 52
    GRAVE        = 53
    COMMA        = 54
    PERIOD       = 55
    SLASH        = 56

    CAPSLOCK = 57

    F1  = 58
    F2  = 59
    F3  = 60
    F4  = 61
    F5  = 62
    F6  = 63
    F7  = 64
    F8  = 65
    F9  = 66
    F10 = 67
    F11 = 68
    F12 = 69

    PRINTSCREEN = 70
    SCROLLLOCK  = 71
    PAUSE       = 72
    INSERT      = 73
    HOME        = 74
    PAGEUP      = 75
    DELETE      = 76
    END         = 77
    PAGEDOWN    = 78
    RIGHT       = 79
    LEFT        = 80
    DOWN        = 81
    UP          = 82

    NUMLOCKCLEAR = 83
    KP_DIVIDE    = 84
    KP_MULTIPLY  = 85
    KP_MINUS     = 86
    KP_PLUS      = 87
    KP_ENTER     = 88
    KP_1         = 89
    KP_2         = 90
    KP_3         = 91
    KP_4         = 92
    KP_5         = 93
    KP_6         = 94
    KP_7         = 95
    KP_8         = 96
    KP_9         = 97
    KP_0         = 98
    KP_PERIOD    = 99

    NONUSBACKSLASH = 100
    APPLICATION    = 101
    POWER          = 102
    KP_EQUALS      = 103
    F13            = 104
    F14            = 105
    F15            = 106
    F16            = 107
    F17            = 108
    F18            = 109
    F19            = 110
    F20            = 111
    F21            = 112
    F22            = 113
    F23            = 114
    F24            = 115
    EXECUTE        = 116
    HELP           = 117
    MENU           = 118
    SELECT         = 119
    STOP           = 120
    AGAIN          = 121
    UNDO           = 122
    CUT            = 123
    COPY           = 124
    PASTE          = 125
    FIND           = 126
    MUTE           = 127
    VOLUMEUP       = 128
    VOLUMEDOWN     = 129

    KP_COMMA       = 133
    KP_EQUALSAS400 = 134

    INTERNATIONAL1 = 135
    INTERNATIONAL2 = 136
    INTERNATIONAL3 = 137
    INTERNATIONAL4 = 138
    INTERNATIONAL5 = 139
    INTERNATIONAL6 = 140
    INTERNATIONAL7 = 141
    INTERNATIONAL8 = 142
    INTERNATIONAL9 = 143
    LANG1          = 144
    LANG2          = 145
    LANG3          = 146
    LANG4          = 147
    LANG5          = 148
    LANG6          = 149
    LANG7          = 150
    LANG8          = 151
    LANG9          = 152

    ALTERASE   = 153
    SYSREQ     = 154
    CANCEL     = 155
    CLEAR      = 156
    PRIOR      = 157
    RETURN2    = 158
    SEPARATOR  = 159
    OUT        = 160
    OPER       = 161
    CLEARAGAIN = 162
    CRSEL      = 163
    EXSEL      = 164

    KP_00              = 176
    KP_000             = 177
    THOUSANDSSEPARATOR = 178
    DECIMALSEPARATOR   = 179
    CURRENCYUNIT       = 180
    CURRENCYSUBUNIT    = 181
    KP_LEFTPAREN       = 182
    KP_RIGHTPAREN      = 183
    KP_LEFTBRACE       = 184
    KP_RIGHTBRACE      = 185
    KP_TAB             = 186
    KP_BACKSPACE       = 187
    KP_A               = 188
    KP_B               = 189
    KP_C               = 190
    KP_D               = 191
    KP_E               = 192
    KP_F               = 193
    KP_XOR             = 194
    KP_POWER           = 195
    KP_PERCENT         = 196
    KP_LESS            = 197
    KP_GREATER         = 198
    KP_AMPERSAND       = 199
    KP_DBLAMPERSAND    = 200
    KP_VERTICALBAR     = 201
    KP_DBLVERTICALBAR  = 202
    KP_COLON           = 203
    KP_HASH            = 204
    KP_SPACE           = 205
    KP_AT              = 206
    KP_EXCLAM          = 207
    KP_MEMSTORE        = 208
    KP_MEMRECALL       = 209
    KP_MEMCLEAR        = 210
    KP_MEMADD          = 211
    KP_MEMSUBTRACT     = 212
    KP_MEMMULTIPLY     = 213
    KP_MEMDIVIDE       = 214
    KP_PLUSMINUS       = 215
    KP_CLEAR           = 216
    KP_CLEARENTRY      = 217
    KP_BINARY          = 218
    KP_OCTAL           = 219
    KP_DECIMAL         = 220
    KP_HEXADECIMAL     = 221

    LCTRL  = 224
    LSHIFT = 225
    LALT   = 226
    LGUI   = 227
    RCTRL  = 228
    RSHIFT = 229
    RALT   = 230
    RGUI   = 231

    MODE         = 257
    AUDIONEXT    = 258
    AUDIOPREV    = 259
    AUDIOSTOP    = 260
    AUDIOPLAY    = 261
    AUDIOMUTE    = 262
    MEDIASELECT  = 263
    WWW          = 264
    MAIL         = 265
    CALCULATOR   = 266
    COMPUTER     = 267
    AC_SEARCH    = 268
    AC_HOME      = 269
    AC_BACK      = 270
    AC_FORWARD   = 271
    AC_STOP      = 272
    AC_REFRESH   = 273
    AC_BOOKMARKS = 274

    BRIGHTNESSDOWN = 275
    BRIGHTNESSUP   = 276
    DISPLAYSWITCH  = 277
    KBDILLUMTOGGLE = 278
    KBDILLUMDOWN   = 279
    KBDILLUMUP     = 280
    EJECT          = 281
    SLEEP          = 282

    APP1 = 283
    APP2 = 284

    SDL_NUM_SCANCODES = 512
  end

  enum Keycode : UInt32
    UNKNOWN = 0

    RETURN     = 13
    ESCAPE     = 27
    BACKSPACE  =  8
    TAB        =  9
    SPACE      = 32
    EXCLAIM    = 33
    QUOTEDBL   = 34
    HASH       = 35
    PERCENT    = 36
    DOLLAR     = 37
    AMPERSAND  = 38
    QUOTE      = 39
    LEFTPAREN  = 40
    RIGHTPAREN = 41
    ASTERISK   = 42
    PLUS       = 43
    COMMA      = 44
    MINUS      = 45
    PERIOD     = 46
    SLASH      = 47
    A0         = 48
    A1         = 49
    A2         = 50
    A3         = 51
    A4         = 52
    A5         = 53
    A6         = 54
    A7         = 55
    A8         = 56
    A9         = 57
    COLON      = 58
    SEMICOLON  = 59
    LESS       = 60
    EQUALS     = 61
    GREATER    = 62
    QUESTION   = 63
    AT         = 64
    # Skip uppercase letters
    LEFTBRACKET  =  91
    BACKSLASH    =  92
    RIGHTBRACKET =  93
    CARET        =  94
    UNDERSCORE   =  95
    BACKQUOTE    =  96
    A            =  97
    B            =  98
    C            =  99
    D            = 100
    E            = 101
    F            = 102
    G            = 103
    H            = 104
    I            = 105
    J            = 106
    K            = 107
    L            = 108
    M            = 109
    N            = 110
    O            = 111
    P            = 112
    Q            = 113
    R            = 114
    S            = 115
    T            = 116
    U            = 117
    V            = 118
    W            = 119
    X            = 120
    Y            = 121
    Z            = 122

    CAPSLOCK = (1 << 30) | Scancode::CAPSLOCK

    F1  = (1 << 30) | Scancode::F1
    F2  = (1 << 30) | Scancode::F2
    F3  = (1 << 30) | Scancode::F3
    F4  = (1 << 30) | Scancode::F4
    F5  = (1 << 30) | Scancode::F5
    F6  = (1 << 30) | Scancode::F6
    F7  = (1 << 30) | Scancode::F7
    F8  = (1 << 30) | Scancode::F8
    F9  = (1 << 30) | Scancode::F9
    F10 = (1 << 30) | Scancode::F10
    F11 = (1 << 30) | Scancode::F11
    F12 = (1 << 30) | Scancode::F12

    PRINTSCREEN = (1 << 30) | Scancode::PRINTSCREEN
    SCROLLLOCK  = (1 << 30) | Scancode::SCROLLLOCK
    PAUSE       = (1 << 30) | Scancode::PAUSE
    INSERT      = (1 << 30) | Scancode::INSERT
    HOME        = (1 << 30) | Scancode::HOME
    PAGEUP      = (1 << 30) | Scancode::PAGEUP
    DELETE      = 127
    END         = (1 << 30) | Scancode::END
    PAGEDOWN    = (1 << 30) | Scancode::PAGEDOWN
    RIGHT       = (1 << 30) | Scancode::RIGHT
    LEFT        = (1 << 30) | Scancode::LEFT
    DOWN        = (1 << 30) | Scancode::DOWN
    UP          = (1 << 30) | Scancode::UP

    NUMLOCKCLEAR = (1 << 30) | Scancode::NUMLOCKCLEAR
    KP_DIVIDE    = (1 << 30) | Scancode::KP_DIVIDE
    KP_MULTIPLY  = (1 << 30) | Scancode::KP_MULTIPLY
    KP_MINUS     = (1 << 30) | Scancode::KP_MINUS
    KP_PLUS      = (1 << 30) | Scancode::KP_PLUS
    KP_ENTER     = (1 << 30) | Scancode::KP_ENTER
    KP_1         = (1 << 30) | Scancode::KP_1
    KP_2         = (1 << 30) | Scancode::KP_2
    KP_3         = (1 << 30) | Scancode::KP_3
    KP_4         = (1 << 30) | Scancode::KP_4
    KP_5         = (1 << 30) | Scancode::KP_5
    KP_6         = (1 << 30) | Scancode::KP_6
    KP_7         = (1 << 30) | Scancode::KP_7
    KP_8         = (1 << 30) | Scancode::KP_8
    KP_9         = (1 << 30) | Scancode::KP_9
    KP_0         = (1 << 30) | Scancode::KP_0
    KP_PERIOD    = (1 << 30) | Scancode::KP_PERIOD

    APPLICATION    = (1 << 30) | Scancode::APPLICATION
    POWER          = (1 << 30) | Scancode::POWER
    KP_EQUALS      = (1 << 30) | Scancode::KP_EQUALS
    F13            = (1 << 30) | Scancode::F13
    F14            = (1 << 30) | Scancode::F14
    F15            = (1 << 30) | Scancode::F15
    F16            = (1 << 30) | Scancode::F16
    F17            = (1 << 30) | Scancode::F17
    F18            = (1 << 30) | Scancode::F18
    F19            = (1 << 30) | Scancode::F19
    F20            = (1 << 30) | Scancode::F20
    F21            = (1 << 30) | Scancode::F21
    F22            = (1 << 30) | Scancode::F22
    F23            = (1 << 30) | Scancode::F23
    F24            = (1 << 30) | Scancode::F24
    EXECUTE        = (1 << 30) | Scancode::EXECUTE
    HELP           = (1 << 30) | Scancode::HELP
    MENU           = (1 << 30) | Scancode::MENU
    SELECT         = (1 << 30) | Scancode::SELECT
    STOP           = (1 << 30) | Scancode::STOP
    AGAIN          = (1 << 30) | Scancode::AGAIN
    UNDO           = (1 << 30) | Scancode::UNDO
    CUT            = (1 << 30) | Scancode::CUT
    COPY           = (1 << 30) | Scancode::COPY
    PASTE          = (1 << 30) | Scancode::PASTE
    FIND           = (1 << 30) | Scancode::FIND
    MUTE           = (1 << 30) | Scancode::MUTE
    VOLUMEUP       = (1 << 30) | Scancode::VOLUMEUP
    VOLUMEDOWN     = (1 << 30) | Scancode::VOLUMEDOWN
    KP_COMMA       = (1 << 30) | Scancode::KP_COMMA
    KP_EQUALSAS400 = (1 << 30) | Scancode::KP_EQUALSAS400

    ALTERASE   = (1 << 30) | Scancode::ALTERASE
    SYSREQ     = (1 << 30) | Scancode::SYSREQ
    CANCEL     = (1 << 30) | Scancode::CANCEL
    CLEAR      = (1 << 30) | Scancode::CLEAR
    PRIOR      = (1 << 30) | Scancode::PRIOR
    RETURN2    = (1 << 30) | Scancode::RETURN2
    SEPARATOR  = (1 << 30) | Scancode::SEPARATOR
    OUT        = (1 << 30) | Scancode::OUT
    OPER       = (1 << 30) | Scancode::OPER
    CLEARAGAIN = (1 << 30) | Scancode::CLEARAGAIN
    CRSEL      = (1 << 30) | Scancode::CRSEL
    EXSEL      = (1 << 30) | Scancode::EXSEL

    KP_00              = (1 << 30) | Scancode::KP_00
    KP_000             = (1 << 30) | Scancode::KP_000
    THOUSANDSSEPARATOR = (1 << 30) | Scancode::THOUSANDSSEPARATOR
    DECIMALSEPARATOR   = (1 << 30) | Scancode::DECIMALSEPARATOR
    CURRENCYUNIT       = (1 << 30) | Scancode::CURRENCYUNIT
    CURRENCYSUBUNIT    = (1 << 30) | Scancode::CURRENCYSUBUNIT
    KP_LEFTPAREN       = (1 << 30) | Scancode::KP_LEFTPAREN
    KP_RIGHTPAREN      = (1 << 30) | Scancode::KP_RIGHTPAREN
    KP_LEFTBRACE       = (1 << 30) | Scancode::KP_LEFTBRACE
    KP_RIGHTBRACE      = (1 << 30) | Scancode::KP_RIGHTBRACE
    KP_TAB             = (1 << 30) | Scancode::KP_TAB
    KP_BACKSPACE       = (1 << 30) | Scancode::KP_BACKSPACE
    KP_A               = (1 << 30) | Scancode::KP_A
    KP_B               = (1 << 30) | Scancode::KP_B
    KP_C               = (1 << 30) | Scancode::KP_C
    KP_D               = (1 << 30) | Scancode::KP_D
    KP_E               = (1 << 30) | Scancode::KP_E
    KP_F               = (1 << 30) | Scancode::KP_F
    KP_XOR             = (1 << 30) | Scancode::KP_XOR
    KP_POWER           = (1 << 30) | Scancode::KP_POWER
    KP_PERCENT         = (1 << 30) | Scancode::KP_PERCENT
    KP_LESS            = (1 << 30) | Scancode::KP_LESS
    KP_GREATER         = (1 << 30) | Scancode::KP_GREATER
    KP_AMPERSAND       = (1 << 30) | Scancode::KP_AMPERSAND
    KP_DBLAMPERSAND    = (1 << 30) | Scancode::KP_DBLAMPERSAND
    KP_VERTICALBAR     = (1 << 30) | Scancode::KP_VERTICALBAR
    KP_DBLVERTICALBAR  = (1 << 30) | Scancode::KP_DBLVERTICALBAR
    KP_COLON           = (1 << 30) | Scancode::KP_COLON
    KP_HASH            = (1 << 30) | Scancode::KP_HASH
    KP_SPACE           = (1 << 30) | Scancode::KP_SPACE
    KP_AT              = (1 << 30) | Scancode::KP_AT
    KP_EXCLAM          = (1 << 30) | Scancode::KP_EXCLAM
    KP_MEMSTORE        = (1 << 30) | Scancode::KP_MEMSTORE
    KP_MEMRECALL       = (1 << 30) | Scancode::KP_MEMRECALL
    KP_MEMCLEAR        = (1 << 30) | Scancode::KP_MEMCLEAR
    KP_MEMADD          = (1 << 30) | Scancode::KP_MEMADD
    KP_MEMSUBTRACT     = (1 << 30) | Scancode::KP_MEMSUBTRACT
    KP_MEMMULTIPLY     = (1 << 30) | Scancode::KP_MEMMULTIPLY
    KP_MEMDIVIDE       = (1 << 30) | Scancode::KP_MEMDIVIDE
    KP_PLUSMINUS       = (1 << 30) | Scancode::KP_PLUSMINUS
    KP_CLEAR           = (1 << 30) | Scancode::KP_CLEAR
    KP_CLEARENTRY      = (1 << 30) | Scancode::KP_CLEARENTRY
    KP_BINARY          = (1 << 30) | Scancode::KP_BINARY
    KP_OCTAL           = (1 << 30) | Scancode::KP_OCTAL
    KP_DECIMAL         = (1 << 30) | Scancode::KP_DECIMAL
    KP_HEXADECIMAL     = (1 << 30) | Scancode::KP_HEXADECIMAL

    LCTRL  = (1 << 30) | Scancode::LCTRL
    LSHIFT = (1 << 30) | Scancode::LSHIFT
    LALT   = (1 << 30) | Scancode::LALT
    LGUI   = (1 << 30) | Scancode::LGUI
    RCTRL  = (1 << 30) | Scancode::RCTRL
    RSHIFT = (1 << 30) | Scancode::RSHIFT
    RALT   = (1 << 30) | Scancode::RALT
    RGUI   = (1 << 30) | Scancode::RGUI

    MODE = (1 << 30) | Scancode::MODE

    AUDIONEXT    = (1 << 30) | Scancode::AUDIONEXT
    AUDIOPREV    = (1 << 30) | Scancode::AUDIOPREV
    AUDIOSTOP    = (1 << 30) | Scancode::AUDIOSTOP
    AUDIOPLAY    = (1 << 30) | Scancode::AUDIOPLAY
    AUDIOMUTE    = (1 << 30) | Scancode::AUDIOMUTE
    MEDIASELECT  = (1 << 30) | Scancode::MEDIASELECT
    WWW          = (1 << 30) | Scancode::WWW
    MAIL         = (1 << 30) | Scancode::MAIL
    CALCULATOR   = (1 << 30) | Scancode::CALCULATOR
    COMPUTER     = (1 << 30) | Scancode::COMPUTER
    AC_SEARCH    = (1 << 30) | Scancode::AC_SEARCH
    AC_HOME      = (1 << 30) | Scancode::AC_HOME
    AC_BACK      = (1 << 30) | Scancode::AC_BACK
    AC_FORWARD   = (1 << 30) | Scancode::AC_FORWARD
    AC_STOP      = (1 << 30) | Scancode::AC_STOP
    AC_REFRESH   = (1 << 30) | Scancode::AC_REFRESH
    AC_BOOKMARKS = (1 << 30) | Scancode::AC_BOOKMARKS

    BRIGHTNESSDOWN = (1 << 30) | Scancode::BRIGHTNESSDOWN
    BRIGHTNESSUP   = (1 << 30) | Scancode::BRIGHTNESSUP
    DISPLAYSWITCH  = (1 << 30) | Scancode::DISPLAYSWITCH
    KBDILLUMTOGGLE = (1 << 30) | Scancode::KBDILLUMTOGGLE
    KBDILLUMDOWN   = (1 << 30) | Scancode::KBDILLUMDOWN
    KBDILLUMUP     = (1 << 30) | Scancode::KBDILLUMUP
    EJECT          = (1 << 30) | Scancode::EJECT
    SLEEP          = (1 << 30) | Scancode::SLEEP
  end

  enum DUMMYENUM
    DUMMYENUMVALUE = 0
  end

  enum AssertState
    ASSERTIONRETRY        = 0
    ASSERTIONBREAK        = 1
    ASSERTIONABORT        = 2
    ASSERTIONIGNORE       = 3
    ASSERTIONALWAYSIGNORE = 4
  end

  enum Errorcode
    ENOMEM      = 0
    EFREAD      = 1
    EFWRITE     = 2
    EFSEEK      = 3
    UNSUPPORTED = 4
    LASTERROR   = 5
  end

  enum ThreadPriority
    THREADPRIORITYLOW    = 0
    THREADPRIORITYNORMAL = 1
    THREADPRIORITYHIGH   = 2
  end

  enum AudioStatus
    AUDIOSTOPPED = 0
    AUDIOPLAYING = 1
    AUDIOPAUSED  = 2
  end

  enum WindowFlags
    WINDOWFULLSCREEN   =    1
    WINDOWOPENGL       =    2
    WINDOWSHOWN        =    4
    WINDOWHIDDEN       =    8
    WINDOWBORDERLESS   =   16
    WINDOWRESIZABLE    =   32
    WINDOWMINIMIZED    =   64
    WINDOWMAXIMIZED    =  128
    WINDOWINPUTGRABBED =  256
    WINDOWINPUTFOCUS   =  512
    WINDOWMOUSEFOCUS   = 1024
    WINDOWFOREIGN      = 2048
  end

  enum WindowEventID
    WINDOWEVENTNONE        =  0
    WINDOWEVENTSHOWN       =  1
    WINDOWEVENTHIDDEN      =  2
    WINDOWEVENTEXPOSED     =  3
    WINDOWEVENTMOVED       =  4
    WINDOWEVENTRESIZED     =  5
    WINDOWEVENTSIZECHANGED =  6
    WINDOWEVENTMINIMIZED   =  7
    WINDOWEVENTMAXIMIZED   =  8
    WINDOWEVENTRESTORED    =  9
    WINDOWEVENTENTER       = 10
    WINDOWEVENTLEAVE       = 11
    WINDOWEVENTFOCUSGAINED = 12
    WINDOWEVENTFOCUSLOST   = 13
    WINDOWEVENTCLOSE       = 14
  end

  enum GLattr
    GLREDSIZE                 =  0
    GLGREENSIZE               =  1
    GLBLUESIZE                =  2
    GLALPHASIZE               =  3
    GLBUFFERSIZE              =  4
    GLDOUBLEBUFFER            =  5
    GLDEPTHSIZE               =  6
    GLSTENCILSIZE             =  7
    GLACCUMREDSIZE            =  8
    GLACCUMGREENSIZE          =  9
    GLACCUMBLUESIZE           = 10
    GLACCUMALPHASIZE          = 11
    GLSTEREO                  = 12
    GLMULTISAMPLEBUFFERS      = 13
    GLMULTISAMPLESAMPLES      = 14
    GLACCELERATEDVISUAL       = 15
    GLRETAINEDBACKING         = 16
    GLCONTEXTMAJORVERSION     = 17
    GLCONTEXTMINORVERSION     = 18
    GLCONTEXTEGL              = 19
    GLCONTEXTFLAGS            = 20
    GLCONTEXTPROFILEMASK      = 21
    GLSHAREWITHCURRENTCONTEXT = 22
    GLFRAMEBUFFERSRGBCAPABLE  = 23
  end

  enum GLprofile
    GLCONTEXTPROFILECORE          = 1
    GLCONTEXTPROFILECOMPATIBILITY = 2
  end

  enum GLcontextFlag
    GLCONTEXTDEBUGFLAG             = 1
    GLCONTEXTFORWARDCOMPATIBLEFLAG = 2
    GLCONTEXTROBUSTACCESSFLAG      = 4
    GLCONTEXTRESETISOLATIONFLAG    = 8
  end

  enum GameControllerBindType
    CONTROLLERBINDTYPENONE   = 0
    CONTROLLERBINDTYPEBUTTON = 1
    CONTROLLERBINDTYPEAXIS   = 2
    CONTROLLERBINDTYPEHAT    = 3
  end

  enum GameControllerAxis
    CONTROLLERAXISINVALID      = -1
    CONTROLLERAXISLEFTX        =  0
    CONTROLLERAXISLEFTY        =  1
    CONTROLLERAXISRIGHTX       =  2
    CONTROLLERAXISRIGHTY       =  3
    CONTROLLERAXISTRIGGERLEFT  =  4
    CONTROLLERAXISTRIGGERRIGHT =  5
    CONTROLLERAXISMAX          =  6
  end

  enum GameControllerButton
    CONTROLLERBUTTONINVALID       = -1
    CONTROLLERBUTTONA             =  0
    CONTROLLERBUTTONB             =  1
    CONTROLLERBUTTONX             =  2
    CONTROLLERBUTTONY             =  3
    CONTROLLERBUTTONBACK          =  4
    CONTROLLERBUTTONGUIDE         =  5
    CONTROLLERBUTTONSTART         =  6
    CONTROLLERBUTTONLEFTSTICK     =  7
    CONTROLLERBUTTONRIGHTSTICK    =  8
    CONTROLLERBUTTONLEFTSHOULDER  =  9
    CONTROLLERBUTTONRIGHTSHOULDER = 10
    CONTROLLERBUTTONDPADUP        = 11
    CONTROLLERBUTTONDPADDOWN      = 12
    CONTROLLERBUTTONDPADLEFT      = 13
    CONTROLLERBUTTONDPADRIGHT     = 14
    CONTROLLERBUTTONMAX           = 15
  end

  enum EventType : UInt32
    FIRSTEVENT               =     0
    QUIT                     =   256
    APPTERMINATING           =   257
    APPLOWMEMORY             =   258
    APPWILLENTERBACKGROUND   =   259
    APPDIDENTERBACKGROUND    =   260
    APPWILLENTERFOREGROUND   =   261
    APPDIDENTERFOREGROUND    =   262
    WINDOWEVENT              =   512
    SYSWMEVENT               =   513
    KEYDOWN                  =   768
    KEYUP                    =   769
    TEXTEDITING              =   770
    TEXTINPUT                =   771
    MOUSEMOTION              =  1024
    MOUSEBUTTONDOWN          =  1025
    MOUSEBUTTONUP            =  1026
    MOUSEWHEEL               =  1027
    JOYAXISMOTION            =  1536
    JOYBALLMOTION            =  1537
    JOYHATMOTION             =  1538
    JOYBUTTONDOWN            =  1539
    JOYBUTTONUP              =  1540
    JOYDEVICEADDED           =  1541
    JOYDEVICEREMOVED         =  1542
    CONTROLLERAXISMOTION     =  1616
    CONTROLLERBUTTONDOWN     =  1617
    CONTROLLERBUTTONUP       =  1618
    CONTROLLERDEVICEADDED    =  1619
    CONTROLLERDEVICEREMOVED  =  1620
    CONTROLLERDEVICEREMAPPED =  1621
    FINGERDOWN               =  1792
    FINGERUP                 =  1793
    FINGERMOTION             =  1794
    DOLLARGESTURE            =  2048
    DOLLARRECORD             =  2049
    MULTIGESTURE             =  2050
    CLIPBOARDUPDATE          =  2304
    DROPFILE                 =  4096
    RENDERTARGETSRESET       =  8192
    USEREVENT                = 32768
    LASTEVENT                = 65535
  end

  enum Eventaction
    ADDEVENT  = 0
    PEEKEVENT = 1
    GETEVENT  = 2
  end

  enum HintPriority
    HINTDEFAULT  = 0
    HINTNORMAL   = 1
    HINTOVERRIDE = 2
  end

  enum LogCategory
    LOGCATEGORYAPPLICATION =  0
    LOGCATEGORYERROR       =  1
    LOGCATEGORYASSERT      =  2
    LOGCATEGORYSYSTEM      =  3
    LOGCATEGORYAUDIO       =  4
    LOGCATEGORYVIDEO       =  5
    LOGCATEGORYRENDER      =  6
    LOGCATEGORYINPUT       =  7
    LOGCATEGORYTEST        =  8
    LOGCATEGORYRESERVED1   =  9
    LOGCATEGORYRESERVED2   = 10
    LOGCATEGORYRESERVED3   = 11
    LOGCATEGORYRESERVED4   = 12
    LOGCATEGORYRESERVED5   = 13
    LOGCATEGORYRESERVED6   = 14
    LOGCATEGORYRESERVED7   = 15
    LOGCATEGORYRESERVED8   = 16
    LOGCATEGORYRESERVED9   = 17
    LOGCATEGORYRESERVED10  = 18
    LOGCATEGORYCUSTOM      = 19
  end

  enum LogPriority
    LOGPRIORITYVERBOSE  = 1
    LOGPRIORITYDEBUG    = 2
    LOGPRIORITYINFO     = 3
    LOGPRIORITYWARN     = 4
    LOGPRIORITYERROR    = 5
    LOGPRIORITYCRITICAL = 6
    NUMLOGPRIORITIES    = 7
  end

  enum MessageBoxFlags
    MESSAGEBOXERROR   = 16
    MESSAGEBOXWARNING = 32
  end

  enum MessageBoxButtonFlags
    MESSAGEBOXBUTTONRETURNKEYDEFAULT = 1
  end

  enum MessageBoxColorType
    MESSAGEBOXCOLORBACKGROUND       = 0
    MESSAGEBOXCOLORTEXT             = 1
    MESSAGEBOXCOLORBUTTONBORDER     = 2
    MESSAGEBOXCOLORBUTTONBACKGROUND = 3
    MESSAGEBOXCOLORBUTTONSELECTED   = 4
    MESSAGEBOXCOLORMAX              = 5
  end

  enum PowerState
    POWERSTATEUNKNOWN   = 0
    POWERSTATEONBATTERY = 1
    POWERSTATENOBATTERY = 2
    POWERSTATECHARGING  = 3
    POWERSTATECHARGED   = 4
  end

  enum RendererFlags
    RENDERERSOFTWARE     = 1
    RENDERERACCELERATED  = 2
    RENDERERPRESENTVSYNC = 4
  end

  enum TextureAccess
    TEXTUREACCESSSTATIC    = 0
    TEXTUREACCESSSTREAMING = 1
    TEXTUREACCESSTARGET    = 2
  end

  enum TextureModulate
    TEXTUREMODULATENONE  = 0
    TEXTUREMODULATECOLOR = 1
  end

  enum RendererFlip
    FLIPNONE       = 0
    FLIPHORIZONTAL = 1
  end

  alias SDLIconvT = Void

  struct AssertData
    always_ignore : Int16
    trigger_count : UInt16
    condition : UInt8*
    filename : UInt8*
    linenum : Int16
    function : UInt8*
    next_ : AssertData*
  end

  struct AtomicT
    value : Int16
  end

  alias Mutex = Void
  alias Semaphore = Void
  alias Cond = Void
  alias Thread = Void

  struct Stdio
    autoclose : Bool
    fp : Void*
  end

  struct Mem
    base : Void*
    here : Void*
    stop : Void*
  end

  struct Unknown
    data1 : Void*
    data2 : Void*
  end

  union RWopsHidden
    stdio : Stdio
    mem : Mem
    unknown : Unknown
  end

  struct RWops
    size : Void*
    seek : Void*
    read : Void*
    write : Void*
    close : Void*
    type : UInt16
    hidden : RWopsHidden
  end

  struct AudioSpec
    freq : Int16
    format : UInt16
    channels : UInt8
    silence : UInt8
    samples : UInt16
    padding : UInt16
    size : UInt16
    callback : Void*
    userdata : Void*
  end

  struct AudioCVT
    needed : Int16
    rate_incr : Float64
    buf : Void*
    len : Int16
    len_cvt : Int16
    len_mult : Int16
    len_ratio : Float64
    filters : StaticArray(Void*, 10)
    filter_index : Int16
  end

  struct DisplayMode
    format : UInt16
    w : Int16
    h : Int16
    refresh_rate : Int16
    driverdata : Void*
  end

  alias Window = Void
  alias SDLJoystick = Void

  struct JoystickGUID
    data : StaticArray(UInt8, 16)
  end

  alias SDLGameController = Void

  struct Hat
    hat : Int16
    hat_mask : Int16
  end

  union GameControllerButtonBindValue
    button : Int16
    axis : Int16
    hat : Hat
  end

  struct GameControllerButtonBind
    bind_type : GameControllerBindType
    value : GameControllerButtonBindValue
  end

  struct CommonEvent
    type : EventType
    timestamp : UInt32
  end

  struct WindowEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt32
    event : UInt8
    padding1 : UInt8
    padding2 : UInt8
    padding3 : UInt8
    data1 : Int16
    data2 : Int16
  end

  struct Keysym
    scancode : Scancode
    keycode : Keycode
    mod : UInt32
    unused : UInt32
  end

  struct KeyboardEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt32
    state : UInt8
    repeat : UInt8
    padding2 : UInt8
    padding3 : UInt8
    keysym : Keysym
  end

  struct TextEditingEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt16
    text : StaticArray(UInt8, 32)
    start : Int16
    length : Int16
  end

  struct TextInputEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt16
    text : StaticArray(UInt8, 32)
  end

  struct MouseMotionEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt32
    which : UInt32
    state : UInt32
    x : Int32
    y : Int32
    xrel : Int32
    yrel : Int32
  end

  struct MouseButtonEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt32
    which : UInt32
    button : UInt8
    state : UInt8
    clicks : UInt8
    padding1 : UInt8
    x : Int32
    y : Int32
  end

  struct MouseWheelEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt32
    which : UInt32
    x : Int32
    y : Int32
  end

  struct JoyAxisEvent
    type : EventType
    timestamp : UInt32
    which : Int16
    axis : UInt8
    padding1 : UInt8
    padding2 : UInt8
    padding3 : UInt8
    value : Int16
    padding4 : UInt16
  end

  struct JoyBallEvent
    type : EventType
    timestamp : UInt32
    which : Int16
    ball : UInt8
    padding1 : UInt8
    padding2 : UInt8
    padding3 : UInt8
    xrel : Int16
    yrel : Int16
  end

  struct JoyHatEvent
    type : EventType
    timestamp : UInt32
    which : Int16
    hat : UInt8
    value : UInt8
    padding1 : UInt8
    padding2 : UInt8
  end

  struct JoyButtonEvent
    type : EventType
    timestamp : UInt32
    which : Int16
    button : UInt8
    state : UInt8
    padding1 : UInt8
    padding2 : UInt8
  end

  struct JoyDeviceEvent
    type : EventType
    timestamp : UInt32
    which : Int16
  end

  struct ControllerAxisEvent
    type : EventType
    timestamp : UInt32
    which : Int16
    axis : UInt8
    padding1 : UInt8
    padding2 : UInt8
    padding3 : UInt8
    value : Int16
    padding4 : UInt16
  end

  struct ControllerButtonEvent
    type : EventType
    timestamp : UInt32
    which : Int16
    button : UInt8
    state : UInt8
    padding1 : UInt8
    padding2 : UInt8
  end

  struct ControllerDeviceEvent
    type : EventType
    timestamp : UInt32
    which : Int16
  end

  struct TouchFingerEvent
    type : EventType
    timestamp : UInt32
    touch_id : Int32
    finger_id : Int32
    x : Float32
    y : Float32
    dx : Float32
    dy : Float32
    pressure : Float32
  end

  struct MultiGestureEvent
    type : EventType
    timestamp : UInt32
    touch_id : Int32
    d_theta : Float32
    d_dist : Float32
    x : Float32
    y : Float32
    num_fingers : UInt16
    padding : UInt16
  end

  struct DollarGestureEvent
    type : EventType
    timestamp : UInt32
    touch_id : Int32
    gesture_id : Int32
    num_fingers : UInt16
    error : Float32
    x : Float32
    y : Float32
  end

  struct DropEvent
    type : EventType
    timestamp : UInt32
    file : UInt8*
  end

  struct QuitEvent
    type : EventType
    timestamp : UInt32
  end

  struct OSEvent
    type : EventType
    timestamp : UInt32
  end

  struct UserEvent
    type : EventType
    timestamp : UInt32
    window_id : UInt16
    code : Int16
    data1 : Void*
    data2 : Void*
  end

  enum SysWMType
    UNKNOWN
    WINDOWS
    X11
    DIRECTFB
    COCOA
    UIKIT
    WAYLAND
    MIR
  end

  struct WinMsg
    hwnd : Void*
    lparam : Int64
    wparam : UInt64
    msg : UInt32
  end

  struct X11Msg
    event : UInt64[24] # TODO : Implement X11 Events
  end

  # TODO : Implement all SDL events

  union Msg
    winmsg : WinMsg
    x11msg : X11Msg
  end

  struct SysWMmsg
    version : Version
    subsystem : SysWMType
    msg : Msg
  end

  struct SysWMEvent
    type : EventType
    timestamp : UInt32
    msg : SysWMmsg*
  end

  union Event
    type : EventType
    common : CommonEvent
    window : WindowEvent
    key : KeyboardEvent
    edit : TextEditingEvent
    text : TextInputEvent
    motion : MouseMotionEvent
    button : MouseButtonEvent
    wheel : MouseWheelEvent
    jaxis : JoyAxisEvent
    jball : JoyBallEvent
    jhat : JoyHatEvent
    jbutton : JoyButtonEvent
    jdevice : JoyDeviceEvent
    caxis : ControllerAxisEvent
    cbutton : ControllerButtonEvent
    cdevice : ControllerDeviceEvent
    quit : QuitEvent
    user : UserEvent
    syswm : SysWMEvent
    tfinger : TouchFingerEvent
    mgesture : MultiGestureEvent
    dgesture : DollarGestureEvent
    drop : DropEvent
    padding : StaticArray(UInt8, 56)
  end

  alias SDLHaptic = Void

  struct HapticDirection
    type : UInt8
    dir : StaticArray(Int16, 3)
  end

  struct HapticConstant
    type : UInt16
    direction : HapticDirection
    length : UInt16
    delay : UInt16
    button : UInt16
    interval : UInt16
    level : Int16
    attack_length : UInt16
    attack_level : UInt16
    fade_length : UInt16
    fade_level : UInt16
  end

  struct HapticPeriodic
    type : UInt16
    direction : HapticDirection
    length : UInt16
    delay : UInt16
    button : UInt16
    interval : UInt16
    period : UInt16
    magnitude : Int16
    offset : Int16
    phase : UInt16
    attack_length : UInt16
    attack_level : UInt16
    fade_length : UInt16
    fade_level : UInt16
  end

  struct HapticCondition
    type : UInt16
    direction : HapticDirection
    length : UInt16
    delay : UInt16
    button : UInt16
    interval : UInt16
    right_sat : StaticArray(UInt16, 3)
    left_sat : StaticArray(UInt16, 3)
    right_coeff : StaticArray(Int16, 3)
    left_coeff : StaticArray(Int16, 3)
    deadband : StaticArray(UInt16, 3)
    center : StaticArray(Int16, 3)
  end

  struct HapticRamp
    type : UInt16
    direction : HapticDirection
    length : UInt16
    delay : UInt16
    button : UInt16
    interval : UInt16
    start : Int16
    end_ : Int16
    attack_length : UInt16
    attack_level : UInt16
    fade_length : UInt16
    fade_level : UInt16
  end

  struct HapticLeftRight
    type : UInt16
    length : UInt16
    large_magnitude : UInt16
    small_magnitude : UInt16
  end

  struct HapticCustom
    type : UInt16
    direction : HapticDirection
    length : UInt16
    delay : UInt16
    button : UInt16
    interval : UInt16
    channels : UInt8
    period : UInt16
    samples : UInt16
    data : Void*
    attack_length : UInt16
    attack_level : UInt16
    fade_length : UInt16
    fade_level : UInt16
  end

  union HapticEffect
    type : UInt16
    constant : HapticConstant
    periodic : HapticPeriodic
    condition : HapticCondition
    ramp : HapticRamp
    leftright : HapticLeftRight
    custom : HapticCustom
  end

  struct MessageBoxButtonData
    flags : UInt16
    buttonid : Int16
    text : UInt8*
  end

  struct MessageBoxColor
    r : UInt8
    g : UInt8
    b : UInt8
  end

  struct MessageBoxColorScheme
    colors : StaticArray(MessageBoxColor, 5)
  end

  struct MessageBoxData
    flags : UInt16
    window : Window*
    title : UInt8*
    message : UInt8*
    numbuttons : Int16
    buttons : MessageBoxButtonData*
    color_scheme : MessageBoxColorScheme*
  end

  struct RendererInfo
    name : UInt8*
    flags : UInt16
    num_texture_formats : UInt16
    texture_formats : StaticArray(UInt16, 16)
    max_texture_width : Int16
    max_texture_height : Int16
  end

  alias Renderer = Void

  alias Texture = Void

  struct Version
    major : UInt8
    minor : UInt8
    patch : UInt8
  end

  alias EventFilter = Void*, Event* -> Int32
  alias LogOutputFunction = Void*

  fun malloc = "SDL_malloc"(size : UInt32) : Void*
  fun calloc = "SDL_calloc"(nmemb : UInt32, size : UInt32) : Void*
  fun realloc = "SDL_realloc"(mem : Void*, size : UInt32) : Void*
  fun free = "SDL_free"(mem : Void*) : Void
  fun getenv = "SDL_getenv"(name : UInt8*) : UInt8*
  fun setenv = "SDL_setenv"(name : UInt8*, value : UInt8*, overwrite : Int16) : Int16
  fun qsort = "SDL_qsort"(base : Void*, nmemb : UInt32, size : UInt32, compare : Void*) : Void
  fun abs = "SDL_abs"(x : Int16) : Int16
  fun isdigit = "SDL_isdigit"(x : Int16) : Int16
  fun isspace = "SDL_isspace"(x : Int16) : Int16
  fun toupper = "SDL_toupper"(x : Int16) : Int16
  fun tolower = "SDL_tolower"(x : Int16) : Int16
  fun memset = "SDL_memset"(dst : Void*, c : Int16, len : UInt32) : Void*
  fun memset4 = "SDL_memset4"(dst : Void*, val : UInt16, dwords : UInt32) : Void
  fun memcpy = "SDL_memcpy"(dst : Void*, src : Void*, len : UInt32) : Void*
  fun memcpy4 = "SDL_memcpy4"(dst : Void*, src : Void*, dwords : UInt32) : Void*
  fun memmove = "SDL_memmove"(dst : Void*, src : Void*, len : UInt32) : Void*
  fun memcmp = "SDL_memcmp"(s1 : Void*, s2 : Void*, len : UInt32) : Int16
  fun wcslen = "SDL_wcslen"(wstr : Void*) : UInt32
  fun wcslcpy = "SDL_wcslcpy"(dst : Void*, src : Void*, maxlen : UInt32) : UInt32
  fun wcslcat = "SDL_wcslcat"(dst : Void*, src : Void*, maxlen : UInt32) : UInt32
  fun strlen = "SDL_strlen"(str : UInt8*) : UInt32
  fun strlcpy = "SDL_strlcpy"(dst : UInt8*, src : UInt8*, maxlen : UInt32) : UInt32
  fun utf8strlcpy = "SDL_utf8strlcpy"(dst : UInt8*, src : UInt8*, dst_bytes : UInt32) : UInt32
  fun strlcat = "SDL_strlcat"(dst : UInt8*, src : UInt8*, maxlen : UInt32) : UInt32
  fun strdup = "SDL_strdup"(str : UInt8*) : UInt8*
  fun strrev = "SDL_strrev"(str : UInt8*) : UInt8*
  fun strupr = "SDL_strupr"(str : UInt8*) : UInt8*
  fun strlwr = "SDL_strlwr"(str : UInt8*) : UInt8*
  fun strchr = "SDL_strchr"(str : UInt8*, c : Int16) : UInt8*
  fun strrchr = "SDL_strrchr"(str : UInt8*, c : Int16) : UInt8*
  fun strstr = "SDL_strstr"(haystack : UInt8*, needle : UInt8*) : UInt8*
  fun itoa = "SDL_itoa"(value : Int16, str : UInt8*, radix : Int16) : UInt8*
  fun uitoa = "SDL_uitoa"(value : UInt16, str : UInt8*, radix : Int16) : UInt8*
  fun ltoa = "SDL_ltoa"(value : Int32, str : UInt8*, radix : Int16) : UInt8*
  fun ultoa = "SDL_ultoa"(value : UInt32, str : UInt8*, radix : Int16) : UInt8*
  fun lltoa = "SDL_lltoa"(value : Int32, str : UInt8*, radix : Int16) : UInt8*
  fun ulltoa = "SDL_ulltoa"(value : UInt32, str : UInt8*, radix : Int16) : UInt8*
  fun atoi = "SDL_atoi"(str : UInt8*) : Int16
  fun atof = "SDL_atof"(str : UInt8*) : Float64
  fun strtol = "SDL_strtol"(str : UInt8*, endp : Void**, base : Int16) : Int32
  fun strtoul = "SDL_strtoul"(str : UInt8*, endp : Void**, base : Int16) : UInt32
  fun strtoll = "SDL_strtoll"(str : UInt8*, endp : Void**, base : Int16) : Int32
  fun strtoull = "SDL_strtoull"(str : UInt8*, endp : Void**, base : Int16) : UInt32
  fun strtod = "SDL_strtod"(str : UInt8*, endp : Void**) : Float64
  fun strcmp = "SDL_strcmp"(str1 : UInt8*, str2 : UInt8*) : Int16
  fun strncmp = "SDL_strncmp"(str1 : UInt8*, str2 : UInt8*, maxlen : UInt32) : Int16
  fun strcasecmp = "SDL_strcasecmp"(str1 : UInt8*, str2 : UInt8*) : Int16
  fun strncasecmp = "SDL_strncasecmp"(str1 : UInt8*, str2 : UInt8*, len : UInt32) : Int16
  fun sscanf = "SDL_sscanf"(text : UInt8*, fmt : UInt8*) : Int16
  fun vsscanf = "SDL_vsscanf"(text : UInt8*, fmt : UInt8*, ap : StaticArray(Int32, 1)) : Int16
  fun snprintf = "SDL_snprintf"(text : UInt8*, maxlen : UInt32, fmt : UInt8*) : Int16
  fun vsnprintf = "SDL_vsnprintf"(text : UInt8*, maxlen : UInt32, fmt : UInt8*, ap : StaticArray(Int32, 1)) : Int16
  fun acos = "SDL_acos"(x : Float64) : Float64
  fun asin = "SDL_asin"(x : Float64) : Float64
  fun atan = "SDL_atan"(x : Float64) : Float64
  fun atan2 = "SDL_atan2"(x : Float64, y : Float64) : Float64
  fun ceil = "SDL_ceil"(x : Float64) : Float64
  fun copysign = "SDL_copysign"(x : Float64, y : Float64) : Float64
  fun cos = "SDL_cos"(x : Float64) : Float64
  fun cosf = "SDL_cosf"(x : Float32) : Float32
  fun fabs = "SDL_fabs"(x : Float64) : Float64
  fun floor = "SDL_floor"(x : Float64) : Float64
  fun mlog = "SDL_log"(x : Float64) : Float64
  fun pow = "SDL_pow"(x : Float64, y : Float64) : Float64
  fun scalbn = "SDL_scalbn"(x : Float64, n : Int16) : Float64
  fun sin = "SDL_sin"(x : Float64) : Float64
  fun sinf = "SDL_sinf"(x : Float32) : Float32
  fun sqrt = "SDL_sqrt"(x : Float64) : Float64
  fun iconv_open = "SDL_iconv_open"(tocode : UInt8*, fromcode : UInt8*) : SDLIconvT*
  fun iconv_close = "SDL_iconv_close"(cd : SDLIconvT*) : Int16
  fun iconv = "SDL_iconv"(cd : SDLIconvT*, inbuf : Void**, inbytesleft : Void*, outbuf : Void**, outbytesleft : Void*) : UInt32
  fun iconv_string = "SDL_iconv_string"(tocode : UInt8*, fromcode : UInt8*, inbuf : UInt8*, inbytesleft : UInt32) : UInt8*
  fun set_main_ready = "SDL_SetMainReady" : Void
  fun report_assertion = "SDL_ReportAssertion"(assertdata : AssertData*, uint8 : UInt8*, _uint8 : UInt8*, int16 : Int16) : AssertState
  fun assertion_handler = "SDL_AssertionHandler"(data : AssertData*, userdata : Void*) : AssertState
  fun set_assertion_handler = "SDL_SetAssertionHandler"(handler : Void*, userdata : Void*) : Void
  fun get_default_assertion_handler = "SDL_GetDefaultAssertionHandler" : Void*
  fun get_assertion_handler = "SDL_GetAssertionHandler"(puserdata : Void**) : Void*
  fun get_assertion_report = "SDL_GetAssertionReport" : AssertData*
  fun reset_assertion_report = "SDL_ResetAssertionReport" : Void
  fun atomic_try_lock = "SDL_AtomicTryLock"(lock : Void*) : Bool
  fun atomic_lock = "SDL_AtomicLock"(lock : Void*) : Void
  fun atomic_unlock = "SDL_AtomicUnlock"(lock : Void*) : Void
  fun atomic_cas = "SDL_AtomicCAS"(a : AtomicT*, oldval : Int16, newval : Int16) : Bool
  fun atomic_set = "SDL_AtomicSet"(a : AtomicT*, v : Int16) : Int16
  fun atomic_get = "SDL_AtomicGet"(a : AtomicT*) : Int16
  fun atomic_add = "SDL_AtomicAdd"(a : AtomicT*, v : Int16) : Int16
  fun atomic_cas_ptr = "SDL_AtomicCASPtr"(a : Void**, oldval : Void*, newval : Void*) : Bool
  fun atomic_set_ptr = "SDL_AtomicSetPtr"(a : Void**, v : Void*) : Void*
  fun atomic_get_ptr = "SDL_AtomicGetPtr"(a : Void**) : Void*
  fun set_error = "SDL_SetError"(fmt : UInt8*) : Int16
  fun get_error = "SDL_GetError" : UInt8*
  fun clear_error = "SDL_ClearError" : Void
  fun error = "SDL_Error"(code : Errorcode) : Int16
  fun swap16 = "SDL_Swap16"(x : UInt16) : UInt16
  fun swap32 = "SDL_Swap32"(x : UInt16) : UInt16
  fun swap64 = "SDL_Swap64"(x : UInt32) : UInt32
  fun swap_float = "SDL_SwapFloat"(x : Float32) : Float32
  fun create_mutex = "SDL_CreateMutex" : Mutex*
  fun lock_mutex = "SDL_LockMutex"(mutex : Mutex*) : Int16
  fun try_lock_mutex = "SDL_TryLockMutex"(mutex : Mutex*) : Int16
  fun unlock_mutex = "SDL_UnlockMutex"(mutex : Mutex*) : Int16
  fun destroy_mutex = "SDL_DestroyMutex"(mutex : Mutex*) : Void
  fun create_semaphore = "SDL_CreateSemaphore"(initial_value : UInt16) : Semaphore*
  fun destroy_semaphore = "SDL_DestroySemaphore"(sem : Semaphore*) : Void
  fun sem_wait = "SDL_SemWait"(sem : Semaphore*) : Int16
  fun sem_try_wait = "SDL_SemTryWait"(sem : Semaphore*) : Int16
  fun sem_wait_timeout = "SDL_SemWaitTimeout"(sem : Semaphore*, ms : UInt16) : Int16
  fun sem_post = "SDL_SemPost"(sem : Semaphore*) : Int16
  fun sem_value = "SDL_SemValue"(sem : Semaphore*) : UInt16
  fun create_cond = "SDL_CreateCond" : Cond*
  fun destroy_cond = "SDL_DestroyCond"(cond : Cond*) : Void
  fun cond_signal = "SDL_CondSignal"(cond : Cond*) : Int16
  fun cond_broadcast = "SDL_CondBroadcast"(cond : Cond*) : Int16
  fun cond_wait = "SDL_CondWait"(cond : Cond*, mutex : Mutex*) : Int16
  fun cond_wait_timeout = "SDL_CondWaitTimeout"(cond : Cond*, mutex : Mutex*, ms : UInt16) : Int16
  fun create_thread = "SDL_CreateThread"(fn : Void*, name : UInt8*, data : Void*) : Thread*
  fun get_thread_name = "SDL_GetThreadName"(thread : Thread*) : UInt8*
  fun thread_id = "SDL_ThreadID" : UInt32
  fun get_thread_id = "SDL_GetThreadID"(thread : Thread*) : UInt32
  fun set_thread_priority = "SDL_SetThreadPriority"(priority : ThreadPriority) : Int16
  fun wait_thread = "SDL_WaitThread"(thread : Thread*, status : Void*) : Void
  fun detach_thread = "SDL_DetachThread"(thread : Thread*) : Void
  fun tls_create = "SDL_TLSCreate" : UInt16
  fun tls_get = "SDL_TLSGet"(id : UInt16) : Void*
  fun tls_set = "SDL_TLSSet"(id : UInt16, value : Void*, destructor : Void*) : Int16
  fun rw_from_file = "SDL_RWFromFile"(file : UInt8*, mode : UInt8*) : RWops*
  fun rw_from_fp = "SDL_RWFromFP"(fp : Void*, autoclose : Bool) : RWops*
  fun rw_from_mem = "SDL_RWFromMem"(mem : Void*, size : Int16) : RWops*
  fun rw_from_const_mem = "SDL_RWFromConstMem"(mem : Void*, size : Int16) : RWops*
  fun alloc_rw = "SDL_AllocRW" : RWops*
  fun free_rw = "SDL_FreeRW"(area : RWops*) : Void
  fun read_u8 = "SDL_ReadU8"(src : RWops*) : UInt8
  fun read_le16 = "SDL_ReadLE16"(src : RWops*) : UInt16
  fun read_be16 = "SDL_ReadBE16"(src : RWops*) : UInt16
  fun read_le32 = "SDL_ReadLE32"(src : RWops*) : UInt16
  fun read_be32 = "SDL_ReadBE32"(src : RWops*) : UInt16
  fun read_le64 = "SDL_ReadLE64"(src : RWops*) : UInt32
  fun read_be64 = "SDL_ReadBE64"(src : RWops*) : UInt32
  fun write_u8 = "SDL_WriteU8"(dst : RWops*, value : UInt8) : UInt32
  fun write_le16 = "SDL_WriteLE16"(dst : RWops*, value : UInt16) : UInt32
  fun write_be16 = "SDL_WriteBE16"(dst : RWops*, value : UInt16) : UInt32
  fun write_le32 = "SDL_WriteLE32"(dst : RWops*, value : UInt16) : UInt32
  fun write_be32 = "SDL_WriteBE32"(dst : RWops*, value : UInt16) : UInt32
  fun write_le64 = "SDL_WriteLE64"(dst : RWops*, value : UInt32) : UInt32
  fun write_be64 = "SDL_WriteBE64"(dst : RWops*, value : UInt32) : UInt32
  fun audio_callback = "SDL_AudioCallback"(stream : Void*, len : Int16) : Void*
  fun audio_filter = "SDL_AudioFilter"(format : UInt16) : AudioCVT*
  fun get_num_audio_drivers = "SDL_GetNumAudioDrivers" : Int16
  fun get_audio_driver = "SDL_GetAudioDriver"(index : Int16) : UInt8*
  fun audio_init = "SDL_AudioInit"(driver_name : UInt8*) : Int16
  fun audio_quit = "SDL_AudioQuit" : Void
  fun get_current_audio_driver = "SDL_GetCurrentAudioDriver" : UInt8*
  fun open_audio = "SDL_OpenAudio"(desired : AudioSpec*, obtained : AudioSpec*) : Int16
  fun get_num_audio_devices = "SDL_GetNumAudioDevices"(iscapture : Int16) : Int16
  fun get_audio_device_name = "SDL_GetAudioDeviceName"(index : Int16, iscapture : Int16) : UInt8*
  fun open_audio_device = "SDL_OpenAudioDevice"(device : UInt8*, iscapture : Int16, desired : AudioSpec*, obtained : AudioSpec*, allowed_changes : Int16) : UInt16
  fun get_audio_status = "SDL_GetAudioStatus" : AudioStatus
  fun get_audio_device_status = "SDL_GetAudioDeviceStatus"(dev : UInt16) : AudioStatus
  fun pause_audio = "SDL_PauseAudio"(pause_on : Int16) : Void
  fun pause_audio_device = "SDL_PauseAudioDevice"(dev : UInt16, pause_on : Int16) : Void
  fun load_wav_rw = "SDL_LoadWAV_RW"(src : RWops*, freesrc : Int16, spec : AudioSpec*, audio_buf : Void**, audio_len : Void*) : AudioSpec*
  fun free_wav = "SDL_FreeWAV"(audio_buf : Void*) : Void
  fun build_audio_cvt = "SDL_BuildAudioCVT"(cvt : AudioCVT*, src_format : UInt16, src_channels : UInt8, src_rate : Int16, dst_format : UInt16, dst_channels : UInt8, dst_rate : Int16) : Int16
  fun convert_audio = "SDL_ConvertAudio"(cvt : AudioCVT*) : Int16
  fun mix_audio = "SDL_MixAudio"(dst : Void*, src : Void*, len : UInt16, volume : Int16) : Void
  fun mix_audio_format = "SDL_MixAudioFormat"(dst : Void*, src : Void*, format : UInt16, len : UInt16, volume : Int16) : Void
  fun lock_audio = "SDL_LockAudio" : Void
  fun lock_audio_device = "SDL_LockAudioDevice"(dev : UInt16) : Void
  fun unlock_audio = "SDL_UnlockAudio" : Void
  fun unlock_audio_device = "SDL_UnlockAudioDevice"(dev : UInt16) : Void
  fun close_audio = "SDL_CloseAudio" : Void
  fun close_audio_device = "SDL_CloseAudioDevice"(dev : UInt16) : Void
  fun set_clipboard_text = "SDL_SetClipboardText"(text : UInt8*) : Int16
  fun get_clipboard_text = "SDL_GetClipboardText" : UInt8*
  fun has_clipboard_text = "SDL_HasClipboardText" : Bool
  fun get_cpu_count = "SDL_GetCPUCount" : Int16
  fun get_cpu_cache_line_size = "SDL_GetCPUCacheLineSize" : Int16
  fun has_rdtsc = "SDL_HasRDTSC" : Bool
  fun has_alti_vec = "SDL_HasAltiVec" : Bool
  fun has_mmx = "SDL_HasMMX" : Bool
  fun has3d_now = "SDL_Has3DNow" : Bool
  fun has_sse = "SDL_HasSSE" : Bool
  fun has_sse2 = "SDL_HasSSE2" : Bool
  fun has_sse3 = "SDL_HasSSE3" : Bool
  fun has_sse41 = "SDL_HasSSE41" : Bool
  fun has_sse42 = "SDL_HasSSE42" : Bool
  fun has_avx = "SDL_HasAVX" : Bool
  fun get_system_ram = "SDL_GetSystemRAM" : Int16
  fun get_num_video_drivers = "SDL_GetNumVideoDrivers" : Int16
  fun get_video_driver = "SDL_GetVideoDriver"(index : Int16) : UInt8*
  fun video_init = "SDL_VideoInit"(driver_name : UInt8*) : Int16
  fun video_quit = "SDL_VideoQuit" : Void
  fun get_current_video_driver = "SDL_GetCurrentVideoDriver" : UInt8*
  fun get_num_video_displays = "SDL_GetNumVideoDisplays" : Int16
  fun get_display_name = "SDL_GetDisplayName"(display_index : Int16) : UInt8*
  fun get_display_bounds = "SDL_GetDisplayBounds"(display_index : Int16, rect : Void*) : Int16
  fun get_num_display_modes = "SDL_GetNumDisplayModes"(display_index : Int16) : Int16
  fun get_display_mode = "SDL_GetDisplayMode"(display_index : Int16, mode_index : Int16, mode : DisplayMode*) : Int16
  fun get_desktop_display_mode = "SDL_GetDesktopDisplayMode"(display_index : Int16, mode : DisplayMode*) : Int16
  fun get_current_display_mode = "SDL_GetCurrentDisplayMode"(display_index : Int16, mode : DisplayMode*) : Int16
  fun get_closest_display_mode = "SDL_GetClosestDisplayMode"(display_index : Int16, mode : DisplayMode*, closest : DisplayMode*) : DisplayMode*
  fun get_window_display_index = "SDL_GetWindowDisplayIndex"(window : Window*) : Int16
  fun set_window_display_mode = "SDL_SetWindowDisplayMode"(window : Window*, mode : DisplayMode*) : Int16
  fun get_window_display_mode = "SDL_GetWindowDisplayMode"(window : Window*, mode : DisplayMode*) : Int16
  fun get_window_pixel_format = "SDL_GetWindowPixelFormat"(window : Window*) : UInt16
  fun create_window = "SDL_CreateWindow"(title : UInt8*, x : Int16, y : Int16, w : Int16, h : Int16, flags : UInt16) : Window*
  fun create_window_from = "SDL_CreateWindowFrom"(data : Void*) : Window*
  fun get_window_id = "SDL_GetWindowID"(window : Window*) : UInt16
  fun get_window_from_id = "SDL_GetWindowFromID"(id : UInt16) : Window*
  fun get_window_flags = "SDL_GetWindowFlags"(window : Window*) : UInt16
  fun set_window_title = "SDL_SetWindowTitle"(window : Window*, title : UInt8*) : Void
  fun get_window_title = "SDL_GetWindowTitle"(window : Window*) : UInt8*
  fun set_window_icon = "SDL_SetWindowIcon"(window : Window*, icon : Void*) : Void
  fun set_window_data = "SDL_SetWindowData"(window : Window*, name : UInt8*, userdata : Void*) : Void*
  fun get_window_data = "SDL_GetWindowData"(window : Window*, name : UInt8*) : Void*
  fun set_window_position = "SDL_SetWindowPosition"(window : Window*, x : Int32, y : Int32) : Void
  fun get_window_position = "SDL_GetWindowPosition"(window : Window*, x : Void*, y : Void*) : Void
  fun set_window_size = "SDL_SetWindowSize"(window : Window*, w : Int32, h : Int32) : Void
  fun get_window_size = "SDL_GetWindowSize"(window : Window*, w : Int32*, h : Int32*) : Void
  fun set_window_minimum_size = "SDL_SetWindowMinimumSize"(window : Window*, min_w : Int16, min_h : Int16) : Void
  fun get_window_minimum_size = "SDL_GetWindowMinimumSize"(window : Window*, w : Void*, h : Void*) : Void
  fun set_window_maximum_size = "SDL_SetWindowMaximumSize"(window : Window*, max_w : Int16, max_h : Int16) : Void
  fun get_window_maximum_size = "SDL_GetWindowMaximumSize"(window : Window*, w : Void*, h : Void*) : Void
  fun set_window_bordered = "SDL_SetWindowBordered"(window : Window*, bordered : Bool) : Void
  fun show_window = "SDL_ShowWindow"(window : Window*) : Void
  fun hide_window = "SDL_HideWindow"(window : Window*) : Void
  fun raise_window = "SDL_RaiseWindow"(window : Window*) : Void
  fun maximize_window = "SDL_MaximizeWindow"(window : Window*) : Void
  fun minimize_window = "SDL_MinimizeWindow"(window : Window*) : Void
  fun restore_window = "SDL_RestoreWindow"(window : Window*) : Void
  fun set_window_fullscreen = "SDL_SetWindowFullscreen"(window : Window*, flags : UInt16) : Int16
  fun get_window_surface = "SDL_GetWindowSurface"(window : Window*) : Void*
  fun update_window_surface = "SDL_UpdateWindowSurface"(window : Window*) : Int16
  fun update_window_surface_rects = "SDL_UpdateWindowSurfaceRects"(window : Window*, rects : Void*, numrects : Int16) : Int16
  fun set_window_grab = "SDL_SetWindowGrab"(window : Window*, grabbed : Bool) : Void
  fun get_window_grab = "SDL_GetWindowGrab"(window : Window*) : Bool
  fun set_window_brightness = "SDL_SetWindowBrightness"(window : Window*, brightness : Float32) : Int16
  fun get_window_brightness = "SDL_GetWindowBrightness"(window : Window*) : Float32
  fun set_window_gamma_ramp = "SDL_SetWindowGammaRamp"(window : Window*, red : Void*, green : Void*, blue : Void*) : Int16
  fun get_window_gamma_ramp = "SDL_GetWindowGammaRamp"(window : Window*, red : Void*, green : Void*, blue : Void*) : Int16
  fun set_window_resizable = "SDL_SetWindowResizable"(window : Window*, r : Bool ) : Void
  fun destroy_window = "SDL_DestroyWindow"(window : Window*) : Void
  fun is_screen_saver_enabled = "SDL_IsScreenSaverEnabled" : Bool
  fun enable_screen_saver = "SDL_EnableScreenSaver" : Void
  fun disable_screen_saver = "SDL_DisableScreenSaver" : Void
  fun gl_load_library = "SDL_GL_LoadLibrary"(path : UInt8*) : Int16
  fun gl_get_proc_address = "SDL_GL_GetProcAddress"(proc : UInt8*) : Void*
  fun gl_unload_library = "SDL_GL_UnloadLibrary" : Void
  fun gl_extension_supported = "SDL_GL_ExtensionSupported"(extension : UInt8*) : Bool
  fun gl_reset_attributes = "SDL_GL_ResetAttributes" : Void
  fun gl_set_attribute = "SDL_GL_SetAttribute"(attr : GLattr, value : Int16) : Int16
  fun gl_get_attribute = "SDL_GL_GetAttribute"(attr : GLattr, value : Void*) : Int16
  fun gl_create_context = "SDL_GL_CreateContext"(window : Window*) : Void*
  fun gl_make_current = "SDL_GL_MakeCurrent"(window : Window*, context : Void*) : Int16
  fun gl_get_current_window = "SDL_GL_GetCurrentWindow" : Window*
  fun gl_get_current_context = "SDL_GL_GetCurrentContext" : Void
  fun gl_get_drawable_size = "SDL_GL_GetDrawableSize"(window : Window*, w : Void*, h : Void*) : Void
  fun gl_set_swap_interval = "SDL_GL_SetSwapInterval"(interval : Int16) : Int16
  fun gl_get_swap_interval = "SDL_GL_GetSwapInterval" : Int16
  fun gl_swap_window = "SDL_GL_SwapWindow"(window : Window*) : Void
  fun gl_delete_context = "SDL_GL_DeleteContext"(context : Void*) : Void
  fun num_joysticks = "SDL_NumJoysticks" : Int16
  fun joystick_name_for_index = "SDL_JoystickNameForIndex"(device_index : Int16) : UInt8*
  fun joystick_open = "SDL_JoystickOpen"(device_index : Int16) : SDLJoystick*
  fun joystick_name = "SDL_JoystickName"(joystick : SDLJoystick*) : UInt8*
  fun joystick_get_device_guid = "SDL_JoystickGetDeviceGUID"(device_index : Int16) : JoystickGUID
  fun joystick_get_guid = "SDL_JoystickGetGUID"(joystick : SDLJoystick*) : JoystickGUID
  fun joystick_get_guid_string = "SDL_JoystickGetGUIDString"(guid : JoystickGUID, psz_guid : UInt8*, cb_guid : Int16) : Void
  fun joystick_get_guid_from_string = "SDL_JoystickGetGUIDFromString"(pch_guid : UInt8*) : JoystickGUID
  fun joystick_get_attached = "SDL_JoystickGetAttached"(joystick : SDLJoystick*) : Bool
  fun joystick_instance_id = "SDL_JoystickInstanceID"(joystick : SDLJoystick*) : Int16
  fun joystick_num_axes = "SDL_JoystickNumAxes"(joystick : SDLJoystick*) : Int16
  fun joystick_num_balls = "SDL_JoystickNumBalls"(joystick : SDLJoystick*) : Int16
  fun joystick_num_hats = "SDL_JoystickNumHats"(joystick : SDLJoystick*) : Int16
  fun joystick_num_buttons = "SDL_JoystickNumButtons"(joystick : SDLJoystick*) : Int16
  fun joystick_update = "SDL_JoystickUpdate" : Void
  fun joystick_event_state = "SDL_JoystickEventState"(state : Int16) : Int16
  fun joystick_get_axis = "SDL_JoystickGetAxis"(joystick : SDLJoystick*, axis : Int16) : Int16
  fun joystick_get_hat = "SDL_JoystickGetHat"(joystick : SDLJoystick*, hat : Int16) : UInt8
  fun joystick_get_ball = "SDL_JoystickGetBall"(joystick : SDLJoystick*, ball : Int16, dx : Void*, dy : Void*) : Int16
  fun joystick_get_button = "SDL_JoystickGetButton"(joystick : SDLJoystick*, button : Int16) : UInt8
  fun joystick_close = "SDL_JoystickClose"(joystick : SDLJoystick*) : Void
  fun game_controller_add_mappings_from_rw = "SDL_GameControllerAddMappingsFromRW"(rw : RWops*, freerw : Int16) : Int16
  fun game_controller_add_mapping = "SDL_GameControllerAddMapping"(mapping_string : UInt8*) : Int16
  fun game_controller_mapping_for_guid = "SDL_GameControllerMappingForGUID"(guid : JoystickGUID) : UInt8*
  fun game_controller_mapping = "SDL_GameControllerMapping"(gamecontroller : SDLGameController*) : UInt8*
  fun is_game_controller = "SDL_IsGameController"(joystick_index : Int16) : Bool
  fun game_controller_name_for_index = "SDL_GameControllerNameForIndex"(joystick_index : Int16) : UInt8*
  fun game_controller_open = "SDL_GameControllerOpen"(joystick_index : Int16) : SDLGameController*
  fun game_controller_name = "SDL_GameControllerName"(gamecontroller : SDLGameController*) : UInt8*
  fun game_controller_get_attached = "SDL_GameControllerGetAttached"(gamecontroller : SDLGameController*) : Bool
  fun game_controller_get_joystick = "SDL_GameControllerGetJoystick"(gamecontroller : SDLGameController*) : SDLJoystick*
  fun game_controller_event_state = "SDL_GameControllerEventState"(state : Int16) : Int16
  fun game_controller_update = "SDL_GameControllerUpdate" : Void
  fun game_controller_get_axis_from_string = "SDL_GameControllerGetAxisFromString"(pch_string : UInt8*) : GameControllerAxis
  fun game_controller_get_string_for_axis = "SDL_GameControllerGetStringForAxis"(axis : GameControllerAxis) : UInt8*
  fun game_controller_get_bind_for_axis = "SDL_GameControllerGetBindForAxis"(gamecontroller : SDLGameController*, axis : GameControllerAxis) : GameControllerButtonBind
  fun game_controller_get_axis = "SDL_GameControllerGetAxis"(gamecontroller : SDLGameController*, axis : GameControllerAxis) : Int16
  fun game_controller_get_button_from_string = "SDL_GameControllerGetButtonFromString"(pch_string : UInt8*) : GameControllerButton
  fun game_controller_get_string_for_button = "SDL_GameControllerGetStringForButton"(button : GameControllerButton) : UInt8*
  fun game_controller_get_bind_for_button = "SDL_GameControllerGetBindForButton"(gamecontroller : SDLGameController*, button : GameControllerButton) : GameControllerButtonBind
  fun game_controller_get_button = "SDL_GameControllerGetButton"(gamecontroller : SDLGameController*, button : GameControllerButton) : UInt8
  fun game_controller_close = "SDL_GameControllerClose"(gamecontroller : SDLGameController*) : Void
  fun pump_events = "SDL_PumpEvents" : Void
  fun peep_events = "SDL_PeepEvents"(events : Event*, numevents : Int16, action : Eventaction, min_type : EventType, max_type : EventType) : Int16
  fun has_event = "SDL_HasEvent"(type : EventType) : Bool
  fun has_events = "SDL_HasEvents"(min_type : EventType, max_type : EventType) : Bool
  fun flush_event = "SDL_FlushEvent"(type : EventType) : Void
  fun flush_events = "SDL_FlushEvents"(min_type : EventType, max_type : EventType) : Void
  fun poll_event = "SDL_PollEvent"(event : Event*) : Int16
  fun wait_event = "SDL_WaitEvent"(event : Event*) : Int16
  fun wait_event_timeout = "SDL_WaitEventTimeout"(event : Event*, timeout : Int16) : Int16
  fun push_event = "SDL_PushEvent"(event : Event*) : Int16
  fun event_filter = "SDL_EventFilter"(event : Event*) : Void*
  fun set_event_filter = "SDL_SetEventFilter"(filter : Void*, userdata : Void*) : Void
  fun get_event_filter = "SDL_GetEventFilter"(filter : EventFilter*, userdata : Void**) : Bool
  fun add_event_watch = "SDL_AddEventWatch"(filter : Void*, userdata : Void*) : Void
  fun del_event_watch = "SDL_DelEventWatch"(filter : Void*, userdata : Void*) : Void
  fun filter_events = "SDL_FilterEvents"(filter : Void*, userdata : Void*) : Void
  fun event_state = "SDL_EventState"(type : EventType, state : Int16) : UInt8
  fun register_events = "SDL_RegisterEvents"(numevents : Int16) : UInt16
  fun get_base_path = "SDL_GetBasePath" : UInt8*
  fun get_pref_path = "SDL_GetPrefPath"(org : UInt8*, app : UInt8*) : UInt8*
  fun num_haptics = "SDL_NumHaptics" : Int16
  fun haptic_name = "SDL_HapticName"(device_index : Int16) : UInt8*
  fun haptic_open = "SDL_HapticOpen"(device_index : Int16) : SDLHaptic*
  fun haptic_opened = "SDL_HapticOpened"(device_index : Int16) : Int16
  fun haptic_index = "SDL_HapticIndex"(haptic : SDLHaptic*) : Int16
  fun mouse_is_haptic = "SDL_MouseIsHaptic" : Int16
  fun haptic_open_from_mouse = "SDL_HapticOpenFromMouse" : SDLHaptic*
  fun joystick_is_haptic = "SDL_JoystickIsHaptic"(joystick : SDLJoystick*) : Int16
  fun haptic_open_from_joystick = "SDL_HapticOpenFromJoystick"(joystick : SDLJoystick*) : SDLHaptic*
  fun haptic_close = "SDL_HapticClose"(haptic : SDLHaptic*) : Void
  fun haptic_num_effects = "SDL_HapticNumEffects"(haptic : SDLHaptic*) : Int16
  fun haptic_num_effects_playing = "SDL_HapticNumEffectsPlaying"(haptic : SDLHaptic*) : Int16
  fun haptic_query = "SDL_HapticQuery"(haptic : SDLHaptic*) : UInt16
  fun haptic_num_axes = "SDL_HapticNumAxes"(haptic : SDLHaptic*) : Int16
  fun haptic_effect_supported = "SDL_HapticEffectSupported"(haptic : SDLHaptic*, effect : HapticEffect*) : Int16
  fun haptic_new_effect = "SDL_HapticNewEffect"(haptic : SDLHaptic*, effect : HapticEffect*) : Int16
  fun haptic_update_effect = "SDL_HapticUpdateEffect"(haptic : SDLHaptic*, effect : Int16, data : HapticEffect*) : Int16
  fun haptic_run_effect = "SDL_HapticRunEffect"(haptic : SDLHaptic*, effect : Int16, iterations : UInt16) : Int16
  fun haptic_stop_effect = "SDL_HapticStopEffect"(haptic : SDLHaptic*, effect : Int16) : Int16
  fun haptic_destroy_effect = "SDL_HapticDestroyEffect"(haptic : SDLHaptic*, effect : Int16) : Void
  fun haptic_get_effect_status = "SDL_HapticGetEffectStatus"(haptic : SDLHaptic*, effect : Int16) : Int16
  fun haptic_set_gain = "SDL_HapticSetGain"(haptic : SDLHaptic*, gain : Int16) : Int16
  fun haptic_set_autocenter = "SDL_HapticSetAutocenter"(haptic : SDLHaptic*, autocenter : Int16) : Int16
  fun haptic_pause = "SDL_HapticPause"(haptic : SDLHaptic*) : Int16
  fun haptic_unpause = "SDL_HapticUnpause"(haptic : SDLHaptic*) : Int16
  fun haptic_stop_all = "SDL_HapticStopAll"(haptic : SDLHaptic*) : Int16
  fun haptic_rumble_supported = "SDL_HapticRumbleSupported"(haptic : SDLHaptic*) : Int16
  fun haptic_rumble_init = "SDL_HapticRumbleInit"(haptic : SDLHaptic*) : Int16
  fun haptic_rumble_play = "SDL_HapticRumblePlay"(haptic : SDLHaptic*, strength : Float32, length : UInt16) : Int16
  fun haptic_rumble_stop = "SDL_HapticRumbleStop"(haptic : SDLHaptic*) : Int16
  fun set_hint_with_priority = "SDL_SetHintWithPriority"(name : UInt8*, value : UInt8*, priority : HintPriority) : Bool
  fun set_hint = "SDL_SetHint"(name : UInt8*, value : UInt8*) : Bool
  fun get_hint = "SDL_GetHint"(name : UInt8*) : UInt8*
  fun hint_callback = "SDL_HintCallback"(name : UInt8*, old_value : UInt8*, new_value : UInt8*) : Void*
  fun add_hint_callback = "SDL_AddHintCallback"(name : UInt8*, callback : Void*, userdata : Void*) : Void
  fun del_hint_callback = "SDL_DelHintCallback"(name : UInt8*, callback : Void*, userdata : Void*) : Void
  fun clear_hints = "SDL_ClearHints" : Void
  fun load_object = "SDL_LoadObject"(sofile : UInt8*) : Void*
  fun load_function = "SDL_LoadFunction"(handle : Void*, name : UInt8*) : Void*
  fun unload_object = "SDL_UnloadObject"(handle : Void*) : Void
  fun log_set_all_priority = "SDL_LogSetAllPriority"(priority : LogPriority) : Void
  fun log_set_priority = "SDL_LogSetPriority"(category : Int16, priority : LogPriority) : Void
  fun log_get_priority = "SDL_LogGetPriority"(category : Int16) : LogPriority
  fun log_reset_priorities = "SDL_LogResetPriorities" : Void
  fun log = "SDL_Log"(fmt : UInt8*) : Void
  fun log_verbose = "SDL_LogVerbose"(category : Int16, fmt : UInt8*) : Void
  fun log_debug = "SDL_LogDebug"(category : Int16, fmt : UInt8*) : Void
  fun log_info = "SDL_LogInfo"(category : Int16, fmt : UInt8*) : Void
  fun log_warn = "SDL_LogWarn"(category : Int16, fmt : UInt8*) : Void
  fun log_error = "SDL_LogError"(category : Int16, fmt : UInt8*) : Void
  fun log_critical = "SDL_LogCritical"(category : Int16, fmt : UInt8*) : Void
  fun log_message = "SDL_LogMessage"(category : Int16, priority : LogPriority, fmt : UInt8*) : Void
  fun log_message_v = "SDL_LogMessageV"(category : Int16, priority : LogPriority, fmt : UInt8*, ap : StaticArray(Int32, 1)) : Void
  fun log_output_function = "SDL_LogOutputFunction"(category : Int16, priority : LogPriority, message : UInt8*) : Void*
  fun log_get_output_function = "SDL_LogGetOutputFunction"(callback : LogOutputFunction*, userdata : Void**) : Void
  fun log_set_output_function = "SDL_LogSetOutputFunction"(callback : Void*, userdata : Void*) : Void
  fun show_message_box = "SDL_ShowMessageBox"(messageboxdata : MessageBoxData*, buttonid : Void*) : Int16
  fun show_simple_message_box = "SDL_ShowSimpleMessageBox"(flags : UInt16, title : UInt8*, message : UInt8*, window : Window*) : Int16
  fun get_power_info = "SDL_GetPowerInfo"(secs : Void*, pct : Void*) : PowerState
  fun get_num_render_drivers = "SDL_GetNumRenderDrivers" : Int16
  fun get_render_driver_info = "SDL_GetRenderDriverInfo"(index : Int16, info : RendererInfo*) : Int16
  fun create_window_and_renderer = "SDL_CreateWindowAndRenderer"(width : Int16, height : Int16, window_flags : UInt16, window : Void**, renderer : Void**) : Int16
  fun create_renderer = "SDL_CreateRenderer"(window : Window*, index : Int16, flags : UInt16) : Renderer*
  fun create_software_renderer = "SDL_CreateSoftwareRenderer"(surface : Void*) : Renderer*
  fun get_renderer = "SDL_GetRenderer"(window : Window*) : Renderer*
  fun get_renderer_info = "SDL_GetRendererInfo"(renderer : Renderer*, info : RendererInfo*) : Int16
  fun get_renderer_output_size = "SDL_GetRendererOutputSize"(renderer : Renderer*, w : Void*, h : Void*) : Int16
  fun create_texture = "SDL_CreateTexture"(renderer : Renderer*, format : UInt16, access : Int16, w : Int16, h : Int16) : Texture*
  fun create_texture_from_surface = "SDL_CreateTextureFromSurface"(renderer : Renderer*, surface : Void*) : Texture*
  fun query_texture = "SDL_QueryTexture"(texture : Texture*, format : Void*, access : Void*, w : Void*, h : Void*) : Int16
  fun set_texture_color_mod = "SDL_SetTextureColorMod"(texture : Texture*, r : UInt8, g : UInt8, b : UInt8) : Int16
  fun get_texture_color_mod = "SDL_GetTextureColorMod"(texture : Texture*, r : Void*, g : Void*, b : Void*) : Int16
  fun set_texture_alpha_mod = "SDL_SetTextureAlphaMod"(texture : Texture*, alpha : UInt8) : Int16
  fun get_texture_alpha_mod = "SDL_GetTextureAlphaMod"(texture : Texture*, alpha : Void*) : Int16
  fun set_texture_blend_mode = "SDL_SetTextureBlendMode"(texture : Texture*, blend_mode : Int32) : Int16
  fun get_texture_blend_mode = "SDL_GetTextureBlendMode"(texture : Texture*, blend_mode : Void*) : Int16
  fun update_texture = "SDL_UpdateTexture"(texture : Texture*, rect : Void*, pixels : Void*, pitch : Int16) : Int16
  fun update_yuv_texture = "SDL_UpdateYUVTexture"(texture : Texture*, rect : Void*, yplane : Void*, ypitch : Int16, uplane : Void*, upitch : Int16, vplane : Void*, vpitch : Int16) : Int16
  fun lock_texture = "SDL_LockTexture"(texture : Texture*, rect : Void*, pixels : Void**, pitch : Void*) : Int16
  fun unlock_texture = "SDL_UnlockTexture"(texture : Texture*) : Void
  fun render_target_supported = "SDL_RenderTargetSupported"(renderer : Renderer*) : Bool
  fun set_render_target = "SDL_SetRenderTarget"(renderer : Renderer*, texture : Texture*) : Int16
  fun get_render_target = "SDL_GetRenderTarget"(renderer : Renderer*) : Texture*
  fun render_set_logical_size = "SDL_RenderSetLogicalSize"(renderer : Renderer*, w : Int16, h : Int16) : Int16
  fun render_get_logical_size = "SDL_RenderGetLogicalSize"(renderer : Renderer*, w : Void*, h : Void*) : Void
  fun render_set_viewport = "SDL_RenderSetViewport"(renderer : Renderer*, rect : Void*) : Int16
  fun render_get_viewport = "SDL_RenderGetViewport"(renderer : Renderer*, rect : Void*) : Void
  fun render_set_clip_rect = "SDL_RenderSetClipRect"(renderer : Renderer*, rect : Void*) : Int16
  fun render_get_clip_rect = "SDL_RenderGetClipRect"(renderer : Renderer*, rect : Void*) : Void
  fun render_set_scale = "SDL_RenderSetScale"(renderer : Renderer*, scale_x : Float32, scale_y : Float32) : Int16
  fun render_get_scale = "SDL_RenderGetScale"(renderer : Renderer*, scale_x : Void*, scale_y : Void*) : Void
  fun set_render_draw_color = "SDL_SetRenderDrawColor"(renderer : Renderer*, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : Int16
  fun get_render_draw_color = "SDL_GetRenderDrawColor"(renderer : Renderer*, r : Void*, g : Void*, b : Void*, a : Void*) : Int16
  fun set_render_draw_blend_mode = "SDL_SetRenderDrawBlendMode"(renderer : Renderer*, blend_mode : Int32) : Int16
  fun get_render_draw_blend_mode = "SDL_GetRenderDrawBlendMode"(renderer : Renderer*, blend_mode : Void*) : Int16
  fun render_clear = "SDL_RenderClear"(renderer : Renderer*) : Int16
  fun render_draw_point = "SDL_RenderDrawPoint"(renderer : Renderer*, x : Int16, y : Int16) : Int16
  fun render_draw_points = "SDL_RenderDrawPoints"(renderer : Renderer*, points : Void*, count : Int16) : Int16
  fun render_draw_line = "SDL_RenderDrawLine"(renderer : Renderer*, x1 : Int16, y1 : Int16, x2 : Int16, y2 : Int16) : Int16
  fun render_draw_lines = "SDL_RenderDrawLines"(renderer : Renderer*, points : Void*, count : Int16) : Int16
  fun render_draw_rect = "SDL_RenderDrawRect"(renderer : Renderer*, rect : Void*) : Int16
  fun render_draw_rects = "SDL_RenderDrawRects"(renderer : Renderer*, rects : Void*, count : Int16) : Int16
  fun render_fill_rect = "SDL_RenderFillRect"(renderer : Renderer*, rect : Void*) : Int16
  fun render_fill_rects = "SDL_RenderFillRects"(renderer : Renderer*, rects : Void*, count : Int16) : Int16
  fun render_copy = "SDL_RenderCopy"(renderer : Renderer*, texture : Texture*, srcrect : Void*, dstrect : Void*) : Int16
  fun render_copy_ex = "SDL_RenderCopyEx"(renderer : Renderer*, texture : Texture*, srcrect : Void*, dstrect : Void*, angle : Float64, center : Void*, flip : Int32) : Int16
  fun render_read_pixels = "SDL_RenderReadPixels"(renderer : Renderer*, rect : Void*, format : UInt16, pixels : Void*, pitch : Int16) : Int16
  fun render_present = "SDL_RenderPresent"(renderer : Renderer*) : Void
  fun destroy_texture = "SDL_DestroyTexture"(texture : Texture*) : Void
  fun destroy_renderer = "SDL_DestroyRenderer"(renderer : Renderer*) : Void
  fun gl_bind_texture = "SDL_GL_BindTexture"(texture : Texture*, texw : Void*, texh : Void*) : Int16
  fun gl_unbind_texture = "SDL_GL_UnbindTexture"(texture : Texture*) : Int16
  fun get_ticks = "SDL_GetTicks" : UInt16
  fun get_performance_counter = "SDL_GetPerformanceCounter" : UInt32
  fun get_performance_frequency = "SDL_GetPerformanceFrequency" : UInt32
  fun delay = "SDL_Delay"(ms : UInt16) : Void
  fun timer_callback = "SDL_TimerCallback"(interval : UInt16, param : Void*) : UInt16
  fun add_timer = "SDL_AddTimer"(interval : UInt16, callback : Void*, param : Void*) : Int16
  fun remove_timer = "SDL_RemoveTimer"(id : Int16) : Bool
  fun get_version = "SDL_GetVersion"(ver : Version*) : Void
  fun get_revision = "SDL_GetRevision" : UInt8*
  fun get_revision_number = "SDL_GetRevisionNumber" : Int16
  fun init = "SDL_Init"(flags : UInt16) : Int16
  fun init_sub_system = "SDL_InitSubSystem"(flags : UInt16) : Int16
  fun quit_sub_system = "SDL_QuitSubSystem"(flags : UInt16) : Void
  fun was_init = "SDL_WasInit"(flags : UInt16) : UInt16
  fun quit = "SDL_Quit" : Void
end

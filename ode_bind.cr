@[Include(
    "ode/collision.h",
    "ode/collision_space.h",
    "ode/collision_trimesh.h",
    "ode/common.h",
    "ode/compatibility.h",
    "ode/contact.h",
    "ode/error.h",
    "ode/export-dif.h",
    "ode/mass.h",
    "ode/matrix.h",
    "ode/memory.h",
    "ode/misc.h",
    "ode/objects.h",
    "ode/odeconfig.h",
    "ode/ode.h",
    "ode/odeinit.h",
    "ode/odemath.h",
    "ode/rotation.h",
    "ode/timer.h",
    flags: "-DdDOUBLE -I/usr/lib/llvm-3.8/lib/clang/3.8.0/include/",
    prefix: %w(d)
)]
@[Link("ode")]
lib ODE
end

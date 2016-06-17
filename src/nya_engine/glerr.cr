require "../gl"

module Nya
  enum GLError
    NO_ERROR = GL::NO_ERROR
    INVALID_ENUM = GL::INVALID_ENUM
    INVALID_VALUE = GL::INVALID_VALUE
    OUT_OF_MEMORY = GL::OUT_OF_MEMORY
    STACK_OVERFLOW = GL::STACK_OVERFLOW
    STACK_UNDERFLOW = GL::STACK_UNDERFLOW
    INVALID_OPERATION = GL::INVALID_OPERATION
    INVALID_FRAMEBUFFER_OPERATION = GL::INVALID_FRAMEBUFFER_OPERATION
  end
  def gl_error
    err = GLError.new GL::get_error
    err.to_s
  end

  def gl_error?
    err = GLError.new GL::get_error
    err == GLError::NO_ERROR ? nil : err.to_s
  end
end

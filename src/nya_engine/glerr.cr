require "./bindings/gl"

module Nya
  enum GLError
    NO_ERROR = LibGL::NO_ERROR
    INVALID_ENUM = LibGL::INVALID_ENUM
    INVALID_VALUE = LibGL::INVALID_VALUE
    OUT_OF_MEMORY = LibGL::OUT_OF_MEMORY
    STACK_OVERFLOW = LibGL::STACK_OVERFLOW
    STACK_UNDERFLOW = LibGL::STACK_UNDERFLOW
    INVALID_OPERATION = LibGL::INVALID_OPERATION
    #INVALID_FRAMEBUFFER_OPERATION = LibGL::INVALID_FRAMEBUFFER_OPERATION
  end
  def self.gl_error
    err = GLError.from_value LibGL.get_error
    err.to_s
  end

  def self.gl_error?
    err = GLError.from_value LibGL.get_error
    err == GLError::NO_ERROR ? nil : err.to_s
  end
end

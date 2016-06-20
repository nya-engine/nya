require "../gl"

module Nya
  alias Matrix = -> Void

  def set_matrix(&m : Matrix)
    m.call
  end

  def pop_matrix
    GL.pop_matrix
  end

  def push_matrix
    GL.push_matrix
  end

  def push_matrix(&m : Matrix)
    push_matrix
    set_matrix &m
  end
end

module Nya
  alias Matrix = -> _

  @matrix : Array(Matrix)
  @current_matrix : Matrix

  def set_matrix(&m : Matrix)
    @current_matrix = m
    m.call
  end

  def pop_matrix
    set_matrix @matrix.pop
  end

  def push_matrix(&m : Matrix)
    @matrix.push @current_matrix
    set_matrix m
  end
end

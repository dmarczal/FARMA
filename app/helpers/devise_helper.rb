module DeviseHelper
  def minimum_placeholder
     ("#{@minimum_password_length} caracteres no mínimo" if @minimum_password_length)
  end
end

defmodule Test do

  # Compute the double of a number.
  def double(n) do
    2*n
  end

  # Fahrenheit to Celsius
  def f2c(n) do
    (n-32)/1.8
  end

  # Rectangle area
  def rect_area(b,h) do
    b*h
  end

  # Square area
  def sqr_area(n) do
    rect_area(n,n)
  end

  # Circle area
  def circle_area(r) do
    :math.pi()*:math.pow(r,2)
  end

end

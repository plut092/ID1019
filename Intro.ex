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

  # Product of m,n
  def product(m,n) do
    if m == 0 do
      0
    else
      n + product(m-1,n)
    end
  end

  # Product with Cases
  def product_case(m,n) do
    case m do
      0 ->
        0
      _ ->
        n + product_case(m-1,n)
    end
  end

  def product_cond(m,n) do
    cond do
      m == 0 ->
        0
      true ->
        n + product_cond(m-1,n)
    end
  end

  def product_clausese(0, _) do 0 end
  def product_clausese(_,0) do 0 end
  def product_clausese(m,n) do
    product_clausese(m-1, n) + n
  end

  def exp(x,n) do
    case n do
      1 ->
        x
      _ ->
        product(x, exp(x, n-1))
    end
  end

  def expi(x,n) do
    case n do
      0 ->
        1
      1 ->
        x
      _ ->
        case rem(n,2) do
          0 ->
            expi(x, div(n,2)) * expi(x, div(n,2))
          1 ->
            expi(x, n-1) * x
        end
    end
  end

  # Find the nth element in a list
  def nth(0, [h | _]) do h end
  def nth(n, [_ | t]) do nth(n-1, t) end

  def len([_ | t]) do 1 + len(t) end
  def len([]) do 0 end

  def sum([]) do 0 end
  def sum([h | t]) do h + sum(t) end

  def duplicate([]) do [] end
  def duplicate([h | t]) do [h, h | duplicate(t)] end

  def add(x, []) do [x] end
  def add(x, [x | t]) do [x | t] end
  def add(x , [h | t]) do [h | add(x, t)] end

  def remove(_, []) do [] end
  def remove(x, [x | t]) do t end
  def remove(x, [h | t]) do [h | remove(x, t)] end

  def unique()
  def unique([h | t]) do [h | unique(t)] end

end

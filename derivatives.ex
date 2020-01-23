# Johan Engström
# 2020-01-22 22:01:09

defmodule Calc do

    @type literal() :: {:const, number()}
        | {:const, atom()}
        | {:var, atom()}

    @type expr() :: {:add, expr(), expr()}
        | {:mul, expr(), expr()}
        | literal()

    def eval_test1() do
        eval({:var, :x}, [{:bind, :x, 5}])
    end
    def eval_test2() do 
        eval({:add, {:var, :x}, {:var, :y}}, 
        [{:bind, :x, 5}, {:bind, :y, 2}])
    end

    def eval({:int, n}), do: n
    def eval({:var, x}), do: x
    def eval({:add, a, b}), do: eval(a) + eval(b)
    def eval({:mul, a, b}), do: eval(a) * eval(b)
    def eval({:sub, a, b}), do: eval(a) - eval(b)
    def eval({:var, name}, bindings), do: lookup(name, bindings)
    def eval({var, {_, a}, {_, b}}, bindings), do: 
        eval({var, 
            {:var, lookup(a, bindings)}, 
            {:var, lookup(b, bindings)}})
    
    # {:var, :x} , bindings -> :x = 5
    def lookup(var, [{:bind, var, value} | _]), do: value
    def lookup(var, [_ | rest]), do: lookup(var, rest)

    def deriv({:const, _}, _), do: {:const, 0}
    def deriv({:var, v}, v), do: {:const, 1}
    def deriv({:var, _y}, _), do: {:const, 0}
    def deriv({:mul, e1, e2}, v), do:
        {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
    def deriv({:add, e1, e2}, v), do: {:add, deriv(e1, v), deriv(e2, v)}

end

#2x^2+3x+5
#fx =    {:add, 
#            {:add, 
#                {:add,
#                    {:mul,
#                        {:int, 2},
#                        {:mul,
#                            {:var, :x},
#                            {:var, :x}
#                        }
#                    }
#                },
#                {:add,
#                    {:mul,
#                        {:int, 3},
#                        {:var, :x}
#                    }
#                }   
#            },
#            {:int, 5}
#        }
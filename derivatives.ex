defmodule Test do

    @type literal() :: {:const, number()}
        | {:const, atom()}
        | {:var, atom()}

    @type expr() :: {:add, expr(), expr()}
        | {:mul, expr(), expr()}
        | literal()

    def eval({:int, n}), do: n
    def eval({:var, x}), do: x
    def eval({:add, a, b}), do: eval(a) + eval(b)
    def eval({:mul, a, b}), do: eval(a) * eval(b)
    def eval({:sub, a, b}), do: eval(a) - eval(b)
    def eval({:var, name}, bindings), do: 
        eval(lookup({:var, name}, bindings))

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
defmodule Calc do
    def eval({:int, n}), do: n
    def eval({:var, x}), do: x
    def eval({:add, a, b}), do: eval(a) + eval(b)
    def eval({:mul, a, b}), do: eval(a) * eval(b)
    def eval({:sub, a, b}), do: eval(a) - eval(b)
    def eval({:var, name}, bindings), do: lookup(name, bindings)

    def lookup(var, [{:bind, var, value} | _]), do: {var, value}
    def lookup(var, [_ | rest]), do: lookup(var, rest)

    
end
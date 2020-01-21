defmodule Test do

    def member(_, :nil) do :no end
    def member(e, {:leaf, e}) do :yes end
    def member(_, {:leaf, _}) do :no end
    
    def member(e, {:node, e, _, _}) do :yes end
    def member(e, {:node, v, left, _}) when e < v do
        member(e, left)        
    end
    def member(e, {:node, _, _, right}) do
        member(e, right)        
    end

    def insert(e, :nil) do {:leaf, e} end
    def insert(e, {:leaf, v}) when e < v  do 
        {:node, v, {:leaf, e}, :nil} end
    def insert(e, {:leaf, v}) do 
        {:node, v, :nil, {:right, e}} end
    def insert(e, {:node, v, left, right }) when e < v do
        {:node, v, insert(e, left), right} 
    end
    def insert(e, {:node, v, left, right })  do
        {:node, v, left, insert(e, right)}
    end
end

# :nil                            # the empty tree
# {:leaf, value}                  # a leaf
# {:node, value, left, right}     # node
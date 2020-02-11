#<sequence> ::= <expression>
#    <match> ';' <sequence>
#
#<match> ::= <pattern> '=' <expression> 
#
#<expression> ::= <atom>
#    <variable>
#    '{' <expression> ',' <expression> '}'
#
#<pattern> ::= <atom>
#    <variable>
#    '_'  
#    '{' <pattern> ',' <pattern> '}'

defmodule Env do
    def new(), do: []
    def add(id, str, env), do: [{id, str} | env]
    def lookup(id, env) do
        case env[id] do
            nil ->
                nil
            str ->
                {id, str}
        end
#        case Enum.find(env, fn {x, _} -> x == id end) do
#            nil ->
#                nil
#            {id, str} ->
#                {id, str}               
#        end
    end

    def remove([id | restOfIds], env) do 
        remove(restOfIds, Enum.filter(env, fn {x, _} -> x != id end))
    end
    def remove([], env), do: env
end

defmodule Eager do

    def eval_expr({:atm, id}, _), do: {:ok, id}
    def eval_expr({:var, id}, env) do
        case Env.lookup(id, env) do
            nil ->
                :error
            {_, str} ->
                {:ok, str}
        end
    end
    def eval_expr({:cons, a, b}, env) do
        case eval_expr(a, env) do
            :error ->
                :error
            {:ok, str1} ->
                case eval_expr(b, env) do
                    :error ->
                        :error
                    {:ok, str2} ->
                        {:ok, {str1, str2}}
                end
        end
    end

    def eval_match(:ignore, _, env) do
        {:ok, env}
    end

    def eval_match({:atm, id}, id, env) do
        {:ok, env}
    end
    def eval_match({:atm, id}, exp, env) do
        :fail
    end

    def eval_match({:var, id}, str, env) do
        case Env.lookup(id, env) do
            nil ->
                {:ok, Env.add(id, str, env)}
            {_, ^str} ->
                {:ok, env}
            {_, _} ->
                :fail
        end
    end

    def eval_match({:cons, hp, tp}, {:cons, hx, tx}, env) do
        case eval_match(hp, hx, env) do
            :fail ->
                :fail
            {_, new_env} ->
                eval_match(tp, tx, new_env)
        end
    end
    def eval_match(_, _, _) do
        :fail
    end

#####################################################################    
# NOT WORKING
    #def extract_vars({_, str}), do: [str] 
    #def extract_vars({_, str1}, {_, str2}), do: [str1, str2]   
    def extract_vars(pattern) do
        extract_vars(pattern, [])
    end

    def extract_vars({:atm, _}, vars) do vars end
    def extract_vars(:ignore, vars) do vars end
    def extract_vars({:var, var}, vars) do
        [var | vars]
    end
    def extract_vars({:cons, head, tail}, vars) do
        extract_vars(tail, extract_vars(head, vars))
    end

    def eval_seq([], env), do: env
    def eval_seq([exp], env) do
        eval_expr(exp, env)
    end
    def eval_seq([{:match, ap, bx} | restOfExp], env) do
        case eval_expr(bx, env) do
            :error ->
                :error
            {:ok, str} ->
                vars = extract_vars(str)
                env = Env.remove(vars, env)

                case eval_match(ap, str, env) do
                    :fail ->
                        :error
                    {:ok, env} ->
                        eval_seq(restOfExp, env)
                end
        end
    end

    def eval(seq) do
        case eval_seq(seq, []) do
            :error ->
                :error
            str ->
                {:ok, str}
        end
    end
end

# seq = [{:match, {:var, :x}, {:atm, :a}}, {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},{:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},{:var, z}]
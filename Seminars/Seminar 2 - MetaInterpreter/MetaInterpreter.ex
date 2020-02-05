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
    def new(), do: %{}
    def add(id, str, env), do: Map.put(env, id, str)
    def lookup(id, env) do 
        case Map.get(env, id) do
            nil ->
                nil
            _ ->
                {id, Map.get(env, id)}               
        end
    end

    def remove(env, [id | restOfIds]), do: remove(Map.delete(env, id), restOfIds)
    def remove(env, id), do: Map.delete(env, id)
end
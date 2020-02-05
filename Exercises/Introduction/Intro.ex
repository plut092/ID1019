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

    def unique([]) do [] end
    def unique([h | t]) do [h | unique(remove(h, t))] end

    def pack([]) do [] end
    def pack([x | t]) do 
        {all_x, rest} = all_same(x, t, [x], [])
        [all_x | pack(rest)]
    end

    def all_same(_, [], all_x, rest) do {all_x, rest} end
    def all_same(x, [x | t], all_x, rest) do
        all_same(x, t, [x | all_x], rest)
    end
    def all_same(x, [h | t], all_x, rest) do 
        all_same(x, t, all_x, [h | rest])
    end

    def nreverse([]) do [] end
    def nreverse([h | t]) do nreverse(t) ++ [h] end

    # Improved reverse()
    def reverse(l) do reverse(l, []) end
    def reverse([], rev) do rev end
    def reverse([h |t], rev) do reverse(t, [h | rev]) end

    def insert(element, []) do [element] end
    def insert(element, [h | t]) do
        cond do
            element < h ->
                [element | [h | t]]
            element >= h ->
                [h | insert(element, t)]
        end
    end

    def isort(l) do isort(l, []) end
    def isort(l, sorted) do 
        case l do
            [] ->
                sorted
            [h | t] ->
                isort(t, insert(h, sorted))
        end
    end

    def msort(l) do
        case l do
            [] ->
                []
            [x] ->
                [x]
            _ ->
                {l1, l2} = msplit(l, [], [])
                merge(msort(l1), msort(l2))
        end
    end
    def merge(x, []) do x end
    def merge([], x) do x end
    def merge([h1|t1], [h2|t2]) do
        if h1 <= h2 do
            [h1 | merge(t1, [h2 | t2])]
        else
            [h2 | merge([h1 | t1], t2)]
        end
    end
    def msplit(list, l1, l2) do
        case list do
            [] ->
                {l1, l2}
            [h | t] ->
                msplit(t, [h | l2], l1)
        end
    end

    def qsort([]) do [] end
    def qsort([x]) do [x] end
    def qsort([p | l]) do
        {l1, l2} = qsplit(p, l, [], [])
        small = qsort(l1)
        large = qsort(l2)
        append(small, [p | large])
    end
    def qsplit(_, [], small, large) do {small, large} end
    def qsplit(p, [h | t], small, large) do
        if h <= p do
            qsplit(p, t, [h | small], large)
        else
            qsplit(p, t, small, [h | large])
        end
    end
    def append(small, large) do
        case small do
            [] -> large
            [h | t] -> [h | append(t, large)]
        end
    end

    def bench() do
        ls = [16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]
        n = 100
        # bench is a closure: a function with an environment.
        bench = fn(l) ->
            seq = Enum.to_list(1..l)
            tn = time(n, fn -> nreverse(seq) end)
            tr = time(n, fn -> reverse(seq) end)
            :io.format("length: ~10w nrev: ~8w us rev: ~8w us~n", [l, tn, tr])
        end
        # We use the library function Enum.each that will call
        # bench(l) for each element l in ls
        Enum.each(ls, bench)
    end
    # Time the execution time of the a function.
    def time(n, fun) do
        start = System.monotonic_time(:milliseconds)
        loop(n, fun)
        stop = System.monotonic_time(:milliseconds)
        stop - start
    end
    # Apply the function n times.
    def loop(n, fun) do
        if n == 0 do
            :ok
        else
            fun.()
            loop(n - 1, fun)
        end
    end

    def to_binary(0) do [] end
    def to_binary(n) do
        append(to_binary(div(n,2)), [rem(n,2)])
    end

    def to_better(0) do [] end
    def to_better(n) do to_better(n, []) end
    def to_better(0, b) do b end
    def to_better(n, b) do
        to_better(div(n, 2), [rem(n, 2) | b])
    end

    def to_integer(x) do to_integer(x, 0) end
    def to_integer([], n) do n end
    def to_integer([0], n) do n end
    def to_integer([x | r], n) do
        to_integer(r, n + :math.pow(x*2, length(r)))
    end

    def fib(0) do 0 end
    def fib(1) do 1 end
    def fib(n) do fib(n-1) + fib(n-2) end

end

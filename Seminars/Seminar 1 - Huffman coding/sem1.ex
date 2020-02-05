defmodule Huffman do
    def sample do
        'the quick brown fox jumps over the lazy dog
        this is a sample text that we will use when we build
        up a table we will only handle lower case letters and
        no punctuation symbols the frequency will of course not
        represent english but it is probably not that far off'
    end
    def text() do
        'this is something that we should encode'
    end
    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        #decode = decode_table(tree)
        #text = text()
        #seq = encode(text, encode)
        #decode(seq, decode)
    end
    #  create a Huffman tree given a sample text
    def tree(sample) do
        
        freq = freq(sample)
        huffman(freq)
    end
    # Building the Huffman tree from freq list:
    # Take the two least frequent elements and make a node until 
    # the list has one node
    def huffman([{tree, _}]), do: tree
    def huffman([{e1, f1}, {e2, f2} | t]) do
        huffman(insert({{e1, e2}, f1+f2}, t))
    end

    #  create an encoding table containing the mapping from characters
    #  to codes given a Huffman tree
    def encode_table(tree), do: encode_table(tree, [], [])
    def encode_table({}, table, _), do: table
    def encode_table({left, right}, table, code) do
        encode_table(right, (encode_table(left, table, [0|code])), [1|code])
    end
    def encode_table(char, table, code), do: [{char, reverse(code)} | table]


    #  create an decoding table containing the mapping
    #  from codes to characters given a Huffman tree.
    def decode_table(tree) do
    # To implement...
    end
    #  encode the text using the mapping in the table, return a 
    #  sequence of bits.
    def encode([], _), do: []
    def encode([char | t], table) do
        append(getcode(char, table), encode(t, table))
    end

    def getcode(char, [{char, code} | t]), do: code
    def getcode(char, [{_, code} | t]), do: getcode(char, t)
    #  decode the bit sequence using the mapping in table, return a
    #  text.
    def decode([], _), do: []
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char | decode(rest, table)]
    end
    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            ... ->
            ...;
            nil ->
                decode_char(..., ..., table)
        end
    end


    # creating a list with the frequency of the chars
    def freq(sample) do
        freq(sample, [])
    end
    # freq list is completed when sample is []
    def freq([], freq), do: isort(freq)
    # iterating through the sample and update frequency of chars
    def freq([char | rest], freq) do
        freq(rest, update(char, freq))
    end

    # HELPING FUNCTION - freq()
    # if freq list is empty, add a tuple with the char and freq=1
    def update(char, []), do: [{char, 1}]
    # the tuple {char, char_freq}was found and updated
    def update(char, [{char, char_freq} | t]) do
        [{char, 1 + char_freq} | t]
    end
    # searching freq list for tuple corresponding to char
    def update(char, [h | t]) do
        [h | update(char, t)]
    end

    #HELPING FUNCTION - freq()
    def remove(_, []), do: []
    def remove(x, [x | t]), do: t
    def remove(x, [h | t]), do: [h | remove(x, t)]

    #HELPING FUNCTION - encode_table()
    def reverse(l) do reverse(l, []) end
    def reverse([], rev) do rev end
    def reverse([h |t], rev) do reverse(t, [h | rev]) end

    #HELPING FUNCTION - encode()
    def append(left, right) do
        case left do
            [] -> right
            [h | t] -> [h | append(t, right)]
        end
    end

    #   {c, f} []
    def insert(e, []) do [e] end
    #   {e1, f1} & {e2, f2} compared
    def insert({e1, f1}, [{e2, f2} | t]) when f1 <= f2 do
        [{e1, f1} | [{e2, f2} | t]]
    end
    def insert({e1, f1}, [{e2, f2} | t]) do
        [{e2, f2} | insert({e1, f1}, t)]
    end

    # insertion sort
    def isort(l) do isort(l, []) end
    def isort([], sorted), do: sorted
    def isort([h | t], sorted) do
        isort(t, insert(h, sorted))
    end
end
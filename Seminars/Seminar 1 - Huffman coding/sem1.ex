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
        sample = text()
        tree = tree(sample)
        #encode = encode_table(tree)
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
        f = f1 + f2
        huffman(insert({{e1, e2}, f}, t))
    end

    #  create an encoding table containing the mapping from characters
    #  to codes given a Huffman tree
    def encode_table(tree) do
    # To implement...
    end
    #  create an decoding table containing the mapping
    #  from codes to characters given a Huffman tree.
    def decode_table(tree) do
    # To implement...
    end
    #  encode the text using the mapping in the table, return a 
    #  sequence of bits.
    def encode(text, table) do
    # To implement...
    end
    #  decode the bit sequence using the mapping in table, return a
    #  text.
    def decode(seq, tree) do
    # To implement...
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
{{},{}}
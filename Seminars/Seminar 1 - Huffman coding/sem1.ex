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
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end
    #  create a Huffman tree given a sample text
    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end
    # building the Huffman tree from freq list
    # make leafs of two most infreq chars and a node with added freqs
    def huffman(freq) do
        huffman(freq, {})
    end
    # freq list has been made into the tree
    def huffman([], tree)do
        tree
    end
    # the tree is empty and the first node is put in
    def huffman(freq, :nil) do
        huffman(remove(most_infreq(freq)), insert(most_infreq(freq)))
    end
    def huffman(freq, tree) do
        
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
    # freq list is completed
    def freq([], freq), do: freq
    # iterating through the sample and updating frequency of chars
    def freq([char | rest], freq) do
        freq(rest, update(char, freq))
    end

    # hELPING FUNCTION - freq()
    # if freq list is empty, add a tuple with frequency of that char
    def update(char, []), do: [{char, 1}]
    # found the tuple with char_freq for char and update
    def update(char, [{char, char_freq} | t]) do
        [{char, 1 + char_freq} | t]
    end
    # searching freq list for tuple corresponding to char
    def update(char, [h | t]) do
        [h | update(char, t)]
    end

    # BT insertion
    def insert(e, :nil) do {:leaf, e} end
    def insert(e, {:leaf, v}) when e < v  do 
        {:node, v, {:leaf, e}, :nil}
    end
    def insert(e, {:leaf, v}) do 
        {:node, v, :nil, {:leaf, e}} 
    end
    def insert(e, {:node, v, left, right }) when e < v do
        {:node, v, insert(e, left), right} 
    end
    def insert(e, {:node, v, left, right })  do
        {:node, v, left, insert(e, right)}
    end
end
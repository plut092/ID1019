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
    def huffman(freq), do: "huffman"
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

end
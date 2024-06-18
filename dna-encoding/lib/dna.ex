defmodule DNA do
  @_ 0b0000
  @a 0b0001
  @c 0b0010
  @g 0b0100
  @t 0b1000


  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> @_
      ?A -> @a
      ?C -> @c
      ?G -> @g
      ?T -> @t
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      @_ -> ?\s
      @a -> ?A
      @c -> ?C
      @g -> ?G
      @t -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna)
  end

  defp do_encode(dna, acc \\ <<>>)
  defp do_encode([], acc), do: acc
  defp do_encode([letter | rest], acc) do
    letter = encode_nucleotide(letter)
    do_encode(rest, <<acc::bitstring, letter::4>>)
  end

  def decode(dna) do
    do_decode(dna)
  end

  defp do_decode(dna, acc \\ ~c"")
  defp do_decode(<<>>, acc), do: acc
  defp do_decode(<<letter::4, rest::bitstring>>, acc) do
    decoded = decode_nucleotide(letter)
    do_decode(rest, acc ++ [decoded])
  end
end

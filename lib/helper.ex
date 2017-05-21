defmodule Autocompletex.Helper do
  def prefixes l do
    pre = case l do
      [h|r] -> 
        [(prefixes h) | (prefixes r)]
      [] ->
        []
      _ -> # binary string
        charlist = l |> String.graphemes
        Enum.scan(charlist, [], &([&1 | &2] ))
          |> Enum.map(fn l -> 
            l 
              |> Enum.reverse 
              |> Enum.join("")
            end)
    end

    pre |> List.flatten |> Enum.map(fn w -> 
      if Enum.member?(List.flatten([l]), w) do w <> "*" else w end 
    end)
  end
end
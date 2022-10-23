module Ai4EServer

using Pkg
using Genie
const up = Genie.up
export up, CommonJson

function main()
  Genie.genie(; context=@__MODULE__)
end

end

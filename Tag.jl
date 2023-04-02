struct Tag
    parameters::String
    negative::String
    otherss::Dict
end
  
function Tag(path)
    res=readchomp(`identify -verbose $path`)
    res=res[findfirst("parameters",res).start:findfirst("png:IHDR.bit-depth-orig:",res).start-1]

    negsp=findfirst("Negative prompt: ",res)

    steps=findfirst(r"Steps:[^,]+",res)
    Tag(replace(res[begin+12:negsp.start-1], "\n" => ""),
        replace(res[negsp.start+17:steps.start-1], "\n" => ""),
            Dict((
            (i)->((a,b)=split(i,": ");
            a=>b)
            )(i) for i in split(
            replace(
                res[steps.start:end], "\n" => "")
            ,", "))  
            )
    # strend=findfirst(r"Eta: .+",res)
  # sampler=findfirst(r"Sampler:[^,]+",res)
  # scale=findfirst(r"CFG scale:[^,]+",res)
  # seed=findfirst(r"Seed[^,]+",res)
  # size=findfirst(r"Size[^,]+",res)
  # modhash=findfirst(r"Model[^,]+",res)
  # etas=findfirst(r"Eta[^,]+",res)
end
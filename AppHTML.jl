include("Tag.jl")

using Electron
using JSON3

app = Application()
win = Window(app, URI("file://$(abspath("index2.html"))");options=Dict("width"=>1920,"height"=>1080,"webPreferences" => Dict("webSecurity" => false))
)
# ;Electron.toggle_devtools(win)
ch = msgchannel(win)
while true
    try
        a=take!(ch) 
    catch
        break
    end
    		try
    		a= Tag(a)
    		catch
    		continue
    		end
    a=JSON3.write(a)
    run(win,"""pri($a)""")
end
exit()

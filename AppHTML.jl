include("Tag.jl")

using Electron
using JSON3

app = Application()
const asset_path=abspath(joinpath("dist","index.html"))
win = Window(app, URI("file://$asset_path");options=Dict("width"=>1920,"height"=>1080,"webPreferences" => Dict("webSecurity" => false))
)

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
run(app,"electron.app.quit()")
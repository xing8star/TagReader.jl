include("Tag.jl")

using Gtk
function autonewline(s::String)
    words=split(s,",")
    maxlen=10
    if length(words)>maxlen
        words=Iterators.partition(words,maxlen)
        words=map(words) do x
            join(x,",")
        end
        words=join(words,"\n")
    else
        s
    end
end


ls = GtkListStore(String, String)
push!(ls,("parameters",))
push!(ls,("negative",))
push!(ls,("Seed",))
push!(ls,("Model hash",))
push!(ls,("Steps",))
push!(ls,("Sampler",))
push!(ls,("CFG scale",))
push!(ls,("Size",))

tv = GtkTreeView(GtkTreeModel(ls))

rTxt = GtkCellRendererText()
rTog = GtkCellRendererToggle()

c1 = GtkTreeViewColumn("Field", rTxt, Dict([("text",0)]))
c2 = GtkTreeViewColumn("Value", rTxt, Dict([("text",1)]))
set_gtk_property!(c2, :resizable, 100)
push!(tv, c1, c2)

b1=GtkButton("Select a pic")

title="Select a picture"

signal_connect(b1, "clicked") do widget
    file=open_dialog_native(title, GtkNullContainer(), String[])
    global a=Tag(file)
    set_gtk_property!(picture, :file, file)
    b=collect(keys(a.otherss))
    ls[1,2] = autonewline(a.parameters)
    ls[2,2] = autonewline(a.negative)
    ls[3,2] = a.otherss[b[1]]
    ls[4,2] = a.otherss[b[2]]
    ls[5,2] = a.otherss[b[3]]
    ls[6,2] = a.otherss[b[4]]
    ls[7,2] = a.otherss[b[5]]
    ls[8,2] = a.otherss[b[6]]
    vbox=GtkButtonBox(:v)
    g[3,3]=vbox
    foreach([:parameters,:negative]) do x
        t=GtkButton("Copy")
        signal_connect(t, "clicked") do widget
            clipboard(getproperty(eval(:a),x))
        end
        push!(vbox, t)
    end
    showall(win)
end

# set_gtk_property!(vbox, :hexpand, true)
# set_gtk_property!(vbox, :vexpand, true)
# set_gtk_property!(vbox, :homogeneous, true)
# t=GtkButton("Copy")
# signal_connect(t, "clicked") do widget
#     clipboard(a.parameters)
# end
# push!(vbox, t)

g = GtkGrid()
set_gtk_property!(g, :margin, 100)
set_gtk_property!(g, :column_homogeneous, true)
set_gtk_property!(g, :column_spacing, 1000)
set_gtk_property!(g, :hexpand, true)
set_gtk_property!(g, :vexpand, true)
picture=GtkImage()
g[1:2,1]=picture
g[1:2,2]=b1
g[1:2,3]=tv

win = GtkWindow(g,"Tag Reader",1280,720)
# set_gtk_property!(win, :resizable, false)
showall(win)

if !isinteractive()
    @async Gtk.gtk_main()
    Gtk.waitforsignal(win,:destroy)
end

include("Tag.jl")

using JSServe, Observables
using JSServe: @js_str, App
using Electron

win = JSServe.use_electron_display()
win=win.window
# result = run(win, "sendMessageToJulia('foo')")

tag=Observable("001.png")
on(tag) do x
  app = App() do
    emp=Tag(x)
    global win
    li1=(DOM.li(String(i)*" :"*getproperty(emp,i)) for i in first(fieldnames(Tag),2))
    li2=(DOM.li(i*" :"*emp.otherss[i]) for i in eachindex(emp.otherss))
    img=JSServe.Asset(joinpath(@__DIR__,x))
    chan=msgchannel(win)
    inputbox=DOM.input(type="file",id="avatar",name="avatar",accept="image/png, image/jpeg",onchange=js"""
                  function handlefile(event){
                    const file=event.target.files[0]
                    sendMessageToJulia(file.path);
                  }""")
    return DOM.body(
      DOM.h1("Tag Reader",style="text-align: center;"),
      DOM.div(
      DOM.img(src=img,style="width: 200px; object-fit:contain;"),style="margin:0 auto;align-items:center;justify-content:center;"),
      DOM.ul(
        li1,
        li2
        ),
        inputbox,
      DOM.button(tag, onclick=js"e=> $(tag).notify( $(basename(take!(chan))) )")
    )
  end
  display(app)
end
run(win, "sendMessageToJulia('$(tag[])')")
tag[]="001.png"
# Electron.toggle_devtools(win)
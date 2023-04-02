ENV["JULIA_PKG_SERVER"] = "https://mirrors.ustc.edu.cn/julia"
using Pkg
Pkg.activate(".")
Pkg.resolve()

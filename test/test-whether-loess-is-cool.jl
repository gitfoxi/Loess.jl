
using Loess
using DataArrays
using Base.Test

xf=linspace(0,100,100)
yf=linspace(0,100,100)
xfa=DataArray(xf)
yfa=DataArray(yf)
xfa[1] = NA
yfa[2] = NA
xi=[1:100]
yi=[1:100]
xia=DataArray(xf)
yia=DataArray(yf)
xia[1] = NA
yia[2] = NA

for x in (xf,xfa,xi,xia)
    for y in (yf, yfa, yi, yia)
        lm = loess(x, y)
        @test_approx_eq predict(lm, 1.5) 1.5
        @test_approx_eq predict(lm, 2) 2.0
    end
end

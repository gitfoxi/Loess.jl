
using Loess
using DataArrays
using Base.Test
using Datetime

xf=linspace(0,100,101)
yf=linspace(0,100,101)
xfa=DataArray(xf)
yfa=DataArray(yf)
xfa[2] = NA
yfa[3] = NA
xi=[0:100]
yi=[0:100]
xia=DataArray(xf)
yia=DataArray(yf)
xia[2] = NA
yia[3] = NA
xdt=[convert(DateTime, x) for x in 0:100]
ydt=DataArray(xdt)
ydt[10] = NA

xrm, yrm = Loess.removeNA(xfa, yfa)
@test length(xrm) == length(xfa) - 2
@test length(yrm) == length(yfa) - 2
for i in [xrm, yrm]
    @test isna(i) == false
end


for x in (xf,xfa,xi,xia)
    for y in (yf, yfa, yi, yia)
        lm = loess(x, y)
        @test abs(predict(lm, 1.5) - 1.5) < 0.0001
        @test abs(predict(lm, 2) - 2.0) < 0.0001
    end
end

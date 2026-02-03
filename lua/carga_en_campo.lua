-- local ejes = require('lua.3d_octante')
require('lua.3d_octante')

-- collectgarbage('collect')

local k,alpha = 0.5, 45
local g = graph3d:new {
    window = {-2,5, -2,5},
    -- viewdir={-90,0},
    viewdir=perspective('yz',k,alpha),
    size = {6,6},
    margin = {0,0,0,0},
    -- bg='red'
}
g:Linejoin('round'); g:Linewidth(6)

g:Doctante(4.5 ,3 ,3)



local q1 = M(1,2,1.5)
g:Dpolyline3d(
    {
        {Origin, q1},
        {q1, q1+vecJ}
    },
    false,
    '-latex,line width=0.8pt'
)
g:Dlabel3d(
    '$q$', q1, {pos='NW', dist=0},
    '$\\vect{r}$', q1/2, {pos='NW'},
    '$\\vect{F}(\\vect{r})$', q1+vecJ, {pos='E'}
)
g:Ddots3d({q1})

-- g:Lineoptions('dotted', 'gray', nil)
local field = function()
    local result = {}
    for x = -1, 1 do
        for z = -1, 2 do
            local entry = {M( x, -3, z ), M( x, 5, z )}
            table.insert(result, entry)
        end
    end
    return result
end

g:Dpolyline3d(
    field(),
    false,
    'dotted, -stealth, gray, line width=1pt, opacity = 0.4'
    -- there is "fill opacity" too
)
g:Dlabel3d(
    '$\\vect{E}(\\vect{r})$', M(0, 2.5, 2.5), {pos='N', node_options='color=gray'}
)

g:Show()

require('lua.3d_octante')

local k,alpha = 0.5, 45
local g = graph3d:new {
    window = {-2,5, -2,5},
    viewdir=perspective('yz',k,alpha),
    -- viewdir={-30,2},
    size = {6,6},
    margin = {0,0,0,0},
    -- bg="red"
}
g:Linejoin('round'); g:Linewidth(6)

g:Doctante(4.5 ,3 ,3)

local q1 = M(1,2,3)
local q2 = M(1,4,1.5)

g:Dpolyline3d(
    {
        {Origin, q1},
        {Origin, q2},
        -- {q1, q2}
    },
    false,
    '-latex,line width=0.8pt'
)
g:Dlabel3d(
    '$q_1$', q1, {pos='N', dist=0},
    '$q_2$', q2, {pos='E', dist=0}
)

g:Dlabel3d(
    '$\\vect{r}_1$', q1/2, {pos='W'},
    '$\\vect{r}_2$', q2/2, {pos='N'}
)

g:Ddots3d({q1,q2})

g:Lineoptions('solid', 'gray', nil)
g:Dpolyline3d(
    { {q1,q2} },
    false,
    '-latex,line width=0.8pt'
)

g:Dlabel3d(
    '$\\vect{r}_2 - \\vect{r}_1$',
    q1 + (q2-q1)/2,
    {
        pos='N',
        dir={q2-q1, q1, q2-q1},
        node_options = 'color=gray'
    }
)

g:Show()

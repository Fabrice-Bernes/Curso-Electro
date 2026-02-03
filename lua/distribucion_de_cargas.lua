require('lua.3d_octante')
require('luadraw_spherical')
arrowBstyle = '-stealth, gray'

-- local k,alpha = 0.5, 45
local g = graph3d:new {
    window = {-2,5, -2,5},
    -- viewdir=perspective('yz',k,alpha),
    viewdir={20,70},
    size = {6,6},
    margin = {0,0,0,0},
    -- bg="red"
}
g:Linejoin('round'); g:Linewidth(6)

g:Doctante(4.5 ,3 ,3)

g:Define_sphere(
    {
        center = M(-1,-1.5,2.5),
        radius = 0.8,
        color = 'gray',
        opacity = 0.1,
        -- mode = mGrid,
        mode = mWireframe,
        edgecolor = 'black',
        edgewidth = 1,
        hiddenstyle = 'solid'
    }
)

local r_prima = M(-1,-1.8,2.5)
local r_campo = M(-1,2,1)
local valor_campo = 0.6*vecK + 0.2*vecJ

g:DSpolyline(
    { {Origin, r_prima}, },
    { hidden = true, arrows = 1 }
)

g:DSpolyline(
    { {r_prima, r_campo} },
    { hidden = true, color = 'gray', arrows = 1 }
)

-- Elemento de volumen
g:DSpolyline(
    facetedges( parallelep( r_prima, -0.1*vecI, -0.1*vecJ, 0.1*vecK ) ),
    {width = 3, hidden=false}
)

g:Dspherical()

g:Dpolyline3d(
    {
        {Origin, r_campo},
        {r_campo, r_campo+valor_campo}
    },
    false,
    '-stealth'
)

g:Dlabel3d(
    "$\\vect{r}'$", r_prima / 2, {pos='W'},
    "$\\vect{r}$", r_campo / 2, {pos='N'},
    "$\\vect{r} - \\vect{r}'$",  r_prima + (r_campo - r_prima)/2,
    {
        pos='NE',
        dir={r_campo - r_prima, vecK, r_campo - r_prima},
        node_options = 'color=gray'
    },
    "$\\rho(\\vect{r})$", M(-1,-1.5,2.5) + 0.8*vecK, {pos='NE'},
    "\\small $\\ds{\\vect{r}'}^3$", r_prima,
    {
        pos='N',
        node_options='color=black'
    },
    "$\\vect{E}(\\vect{r})$", r_campo+valor_campo, {pos='E'}
)

g:Show()

require('lua.3d_octante')
local patata, _ = read_obj_file('lua/patata.obj')

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

local r_prima = M(-1,-1.8,2.5)
local r_campo = M(-1,2,1)
local valor_campo = 0.6*vecK + 0.2*vecJ

g:Dpolyline3d(
    {
        {Origin, r_campo},
        {r_campo, r_campo+valor_campo}
    },
    false,
    '-stealth'
)

g:Dscene3d(
    g:addPolyline(
        {Origin, r_prima},
        { hidden=true, hiddenstyle='dashed', arrows=1 }
    ),
    g:addPolyline(
        {r_prima, r_campo},
        { hidden=true, color = 'gray', hiddenstyle='dashed', arrows=1 }
    ),
    g:addPoly(
        ftransform3d(
            scale3d(patata, 10, Origin),
            function(point)
                return M(point.x - 1, point.y - 1.8, point.z + 2.9)
            end
        ),
        {
            mode     = mShadedOnly,
            contrast = 0.5,
            opacity  = 1
        }
    )
)

-- Elemento de volumen
g:Dpolyline3d(
    facetedges( parallelep( r_prima, -0.1*vecI, -0.1*vecJ, 0.1*vecK ) )
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

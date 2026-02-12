local azimuth = 20
local g = graph3d:new {
    window = {-5,5, -5,5},
    viewdir={azimuth,70},
    size = {8,8},
    margin = {0,0,0,0},
}
g:Linejoin('round'); g:Linewidth(6)

-- Cola de E2 y cabeza de E1
-- Para sentido físico. Si el de abajo es x, y, z1, entonces
-- el de arriba tiene que ser -x, -y, z2
local E2, E1 = M(-2,2,4), M(2,-2,-1.5)

g:Dpolyline3d(
    {
        { E1, Origin },
        { Origin, E2 },
    },
    '-latex,black'
)

g:Dplane( {Origin, vecK}, vecI, 7.5, 7.5, all, 'gray' )

g:Lineoptions('solid', 'black', 6)

-- TODO esto se podía hacer con g:Dplane y ya, pero tal vez es útil conocer las esquinas
--      E_2
--   B-C
--   | |
--   A-D
-- E1
local dl = pt3d.normalize( M( (E2-E1).x, (E2-E1).y, 0 ) )
local A = 0.5*E1 - 0.3*dl
local B = M( A.x, A.y, -A.z )
local C = B + (5* M(pt3d.normalize(E2-E1).x, pt3d.normalize(E2-E1).y, 0))
-- local D = C - 2*vecK
local D = M(C.x, C.y, -C.z)
g:Dpolyline3d( { A, B, C, D }, true, 'solid, gray')
g:Dpolyline3d( { M(A.x, A.y, 0), M(C.x, C.y, 0) }, false, 'dotted, gray')
g:Dpolyline3d(
    {
        {B + dl, B + 1.5*dl},
        {D - dl, D - 1.5*dl}
    },
    false,
    '-latex,black'
)

-- Carga
g:Dcircle3d(M(0.5, 0.5, 0), 1, vecK, 'pattern=crosshatch, opacity=0.3')

-- Lineas para la altura del rectángulo
g:Dpolyline3d( {C + 0.5*dl, D + 0.5*dl}, '<->')
-- g:Dpolyline3d(
--     {
--         { C,  C + 0.5*dl },
--         { D , D + 0.5*dl }
--     },
--     'dashed'
-- )


g:Dlabel3d(
    '$\\sigma$', M(0.5, 0.5, 0), {pos='E'},
    '$\\vect{E}_1$', E1, {pos='W'},
    '$\\vect{E}_2$', E2, {pos='E'},
    '$h$', M( (C + 0.5*dl).x, (C + 0.5*dl).y, 0 ), {pos='E'}
)


g:Dpolyline3d( {C + 0.5*dl, D + 0.5*dl}, '<->')

g:Show()

local azimuth = 20
local g = graph3d:new {
    window = {-5,5, -5,5},
    viewdir={azimuth,70},
    size = {8,8},
    margin = {0,0,0,0},
}
g:Linejoin('round'); g:Linewidth(6)

-- radio y semialtura
local r, h= 2, 2

-- Cola de E2 y cabeza de E1
-- Para sentido físico. Si el de abajo es x, y, z1, entonces
-- el de arriba tiene que ser -x, -y, z2
local E2, E1 = M(-2,2,4), M(2,-2,-1.5)

-- Sería simplemente esto si no usáramos Dscene3d
-- g:Dcylinder(M(0,0,-2), radio_cilindro, Origin, {mode=0, color='gray', hiddenstyle='noline'})
-- g:Dplane( {Origin, vecK}, vecJ, 7, 7, all, 'fill=gray,fill opacity=0.2' )
-- g:Dcylinder(Origin, radio_cilindro, M(0,0,2), {mode=0, color='gray', hiddenstyle='dashed'})

local a_radian = function(deg)
    return (deg*math.pi)/180
end
-- Parece que rotate3d sólo acepta facetas o vértices individuales
local rotar_linea = function(linea, phi)
    local resultado = {}
    for _,punto in ipairs(linea) do
        local x, y = punto.x, punto.y
        local x_prima = x*math.cos(phi) + y*math.sin(phi)
        local y_prima = y*math.cos(phi) - x*math.sin(phi)
        table.insert(resultado,  M(x_prima, y_prima, punto.z) )
        -- table.insert( resultado, rotate3d(punto, phi, vecK) )
    end
    return resultado
end

g:Lineoptions('solid', 'gray', 6)
g:Dscene3d(
    -- Normales de las tapas del cilindro
    g:addPolyline(
        {M(0,0,-h), M(0,0,-(h+1))},
        {hidden=true, hiddenstyle='dashed', color='black', arrows=1}
    ),
    g:addPolyline(
        {M(0,0,h), M(0,0,h+1)},
        {hidden=false, color='black', arrows=1}
    ),

    -- Cilindro y contorno de sus bases
    g:addPoly(
        cylinder( M(0,0,-h), r, M(0,0,h), 60, false ),
        {contrast=0.25, color='WhiteSmoke'}
    ),

    g:addCircle( M(0,0,-h), r, -vecK, {hidden=true, hiddenstyle='dashed'}),     -- Inferior
    g:addCircle( M(0,0,h), r, vecK, {hidden=false} ),                           -- Superior
    g:addCircle( Origin, r, vecK, {hidden=true, hiddenstyle='dashed'} ),        -- Corte del plano

    -- Plano
    g:addPlane( {Origin, vecK}, {opacity=0, edge=true} ),

    -- Resaltar las caras laterales del cilindro, rotadas según el ángulo de la cámara
    g:addPolyline( -- TODO excesivo?
        rotar_linea( { M(0, r, -h), M(0, r, h) }, a_radian(-azimuth) ),
        {hidden=true, hiddenstyle='solid', color='gray'}
    ),
    g:addPolyline( -- TODO excesivo?
        rotar_linea( { M(0, -r, -h), M(0, -r, h) }, a_radian(-azimuth) ),
        {hidden=true, hiddenstyle='solid', color='gray'}
    ),

    -- Vectores de E.
    g:addPolyline( -- A este habrá que agregarle el conito a mano
        { E1, Origin },
        {color='black', arrows=1, hidden=true, hiddenstyle='dashed'}
    ),
    g:addPolyline(
        { Origin, E2 },
        {color='black', arrows=1, hidden=true, hiddenstyle='dashed'}
    )
)

g:Lineoptions('solid', 'black', 6)

-- Punta de flecha en E_1
-- TODO. Convertir en módulo
-- g:Dcone(0.1*M(2, -2, -1.5), 0.1, Origin, {mode=mWireframe, color='black'})
g:Dpoly(
    regular_pyramid(10, 0.05, 0.03, false, 0.07*M(2, -2, -1.5), -M(2,-2, -1.5)),
    {color='black'}
)

-- Carga
g:Dcircle3d(M(0.5, 0.5, 0), 1, vecK, 'pattern=crosshatch, opacity=0.3')

-- https://math.stackexchange.com/questions/4642098/
-- g:Dparametric3d(
--     function(t)
--         return 0.5 * M(math.cos(t) - 1/(1 + 15 * t^2), math.sin(t), 0)
--     end,
--     { t = {-math.pi, math.pi}, draw_options='draw=black,fill=black,opacity=1' }
-- )

g:Dcrossdots3d({M(0,0,-h), -vecK}, 'black', 0.75)
g:Dcrossdots3d({M(0,0,h), -vecK}, 'black', 0.75)


-- Lineas para la altura del cilindro
g:Dpolyline3d( {M(0, r + 1, h), M(0, r + 1, -h)}, '<->')
g:Dpolyline3d(
    {
        {M(0, r + 1, h), M(0, r, h)},
        {M(0, r + 1, -h), M(0, r, -h)}
    },
    'dashed'
)


g:Dlabel3d(
    '$\\sigma$', M(0.5, 0.5, 0), {pos='E'},
    '$\\vect{E}_1$', E1, {pos='W'},
    '$\\vect{E}_2$', E2, {pos='E'},
    '$\\hatvect{n}_2$', M(0,0,h+1), {pos='E'},
    '$\\hatvect{n}_1$', M(0,0,-(h+1)), {pos='E'},
    '$h$', M(0, r+1, 0), {pos='E'}
)

g:Show()

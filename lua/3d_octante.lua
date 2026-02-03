function graph:Doctante(xlen,ylen,zlen)
    self:Dpolyline3d(
        {
            {Origin, xlen*vecI},
            {Origin, ylen*vecJ},
            {Origin, zlen*vecK}
        },
        false,
        '->,line width=0.5pt'
    )
    self:Dlabel3d(
        "$x$", xlen*vecI, {pos='SW'},
        "$y$", ylen*vecJ, {pos='E'},
        "$z$", zlen*vecK, {pos='N'}
    )
end

-- local Doctante = function(self, xlen,ylen,zlen)
--     self:Dpolyline3d(
--         {
--             {Origin, xlen*vecI},
--             {Origin, ylen*vecJ},
--             {Origin, zlen*vecK}
--         },
--         false,
--         '->,line width=0.5pt'
--     )
--     self:Dlabel3d(
--         "$x$", xlen*vecI, {pos='SW'},
--         "$y$", ylen*vecJ, {pos='E'},
--         "$z$", zlen*vecK, {pos='N'}
--     )
-- end
--
-- return Doctante

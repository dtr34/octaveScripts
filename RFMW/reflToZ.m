function Zs = reflToZ(refl, Zref)
Zs = Zref * (1 + refl) / (1 - refl);
endfunction
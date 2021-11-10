!> These are constants used by the material properties module. 
!! Currently there's only dry air but in the future we can include properties for other fluids and solids

module material_parameters
    implicit none
    include "config.f90"
    INTEGER(Kind=I_Kind), PARAMETER :: DryAir_Cp_pOrder =  4 !quadratic polynomial
    INTEGER(Kind=I_Kind), PARAMETER :: DryAir_Cp_nIntv  = 19

end module material_parameters
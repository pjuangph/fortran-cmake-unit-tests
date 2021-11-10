!> Comment guide https://www.doxygen.nl/manual/docblocks.html#fortranblocks


module moist_air
    use material_parameters, only : DryAir_Cp_nIntv,DryAir_Cp_pOrder
    implicit none
    include "config.f90"
    
    real(Kind=R_Kind), dimension(4,19), parameter :: &
    DryAir_Cp_Coeff = RESHAPE( &
    (/1.157096138402E+03,-2.074718253302E+00, 9.709780080412E-03,-1.545867191660E-05,    &
    1.033823323739E+03,-2.311978350176E-01, 5.050053930708E-04,-1.309655390625E-07,    &
    1.035992077413E+03,-2.372492988383E-01, 4.778778575327E-04,-5.328077380407E-08,    &
    1.067393328139E+03,-4.638071186451E-01, 1.023749677364E-03,-4.924714042051E-07,    &
    1.072279375353E+03,-4.959888726203E-01, 1.093446555589E-03,-5.422379254511E-07,    &
    1.032943132356E+03,-3.071919653622E-01, 7.911563771803E-04,-3.807692558993E-07,    &
    9.676831217129E+02,-3.501584785520E-02, 4.125160995731E-04,-2.050675081335E-07,    &
    9.003600623884E+02, 2.121189201383E-01, 1.099567837708E-04,-8.153216782484E-08,    &
    8.457516500327E+02, 3.909660579819E-01,-8.536936482581E-05,-1.039572073476E-08,    &
    8.089301528632E+02, 4.998328881717E-01,-1.926958757409E-04, 2.488466947339E-08,    &
    7.893518533856E+02, 5.526589578495E-01,-2.402184033234E-04, 3.913832520373E-08,    &
    7.835354086083E+02, 5.671941597178E-01,-2.523266072064E-04, 4.250058303445E-08,    &
    7.884226450377E+02, 5.562100037524E-01,-2.440971490888E-04, 4.044526818698E-08,    &
    8.008177210067E+02, 5.300950602264E-01,-2.257533902578E-04, 3.614943365379E-08,    &
    8.174633156976E+02, 4.972631307703E-01,-2.041644453566E-04, 3.141678305972E-08,    &
    8.381243363767E+02, 4.590228631718E-01,-1.805684557365E-04, 2.656273944797E-08,    &
    8.590331876630E+02, 4.225729392574E-01,-1.593854889695E-04, 2.245880224807E-08,    &
    8.811066801690E+02, 3.861895455940E-01,-1.393933623741E-04, 1.879663302759E-08,    &
    9.005246039995E+02, 3.557843193484E-01,-1.235224783379E-04, 1.603503008192E-08 /), &
    (/4,19/))

    real(Kind=R_Kind), dimension(20), parameter :: DryAir_Cp_T0intv= (/ &
    120.0,  220.0,  320.0,  420.0,  520.0,  620.0,  720.0,  820.0,  920.0, 1020.0, &
    1120.0, 1220.0, 1320.0, 1420.0, 1520.0, 1620.0, 1720.0, 1820.0, 1920.0, 2000.0/)

    contains

    !> Calculates the Coefficient of Pressure at a particular temperature (K) for dry air
    !! This is not a real function. Only used for testing purposes
    !! function
    !! @param T Temperature in Kelvin
    function MoistAirCp(T) result(Cp)
        real(kind=R_Kind), intent (in)  :: T !< Temperature (K)
        real(kind=R_Kind)               :: Cp !< Cp (J/Kg)

        ! iterators 
        integer(kind=I_Kind)            :: i 
        integer(kind=I_Kind)            :: j
        !$acc seq
        do i = 1, 20 ! Loop through 
            if(T.lt.DryAir_Cp_T0intv(i)) exit
        end do 
        i=i-1
        
        !$acc seq
        Cp=DryAir_Cp_Coeff(4,i)
        do j = 3, 1,-1
            Cp=Cp*T+DryAir_Cp_Coeff(j,i)
        enddo
        Cp = Cp*2
        return
    end function

end module moist_air
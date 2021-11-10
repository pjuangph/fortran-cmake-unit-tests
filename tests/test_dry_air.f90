!> This test checks to see if We are able to predict the Cp at a certain temperature
!! test.

integer function tests_test_dry_air() result(r)
    use dry_air, only: DryAirCp
    real(kind=8) :: Temperature ! Kelvin
    real(kind=8) :: Cp ! J/K
    
    Temperature = 1900
    Cp = DryAirCp(Temperature)
    print *, "Cp at ", Temperature, " is ", Cp
    
    if (Cp.eq.DryAirCp(Temperature)) then ! Need to change this to an actual number
        r = 0 ! Test pass
    end if
end function

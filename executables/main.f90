!> Main Program

program executable1
    use dry_air, only: DryAirCp
    include "config.f90"

    real(kind=R_Kind) :: Cp
    Cp = DryAirCp(real(1900,8))
    print *, "Cp at ", real(1900,8), " is ", Cp
    
end program executable1
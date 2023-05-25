BEGIN
        read R1;
        R9 := R1;

        read R2;
        if R2 > R9 then
                R9 := R2;
        else
                skip;
        fi;

        read R3;
        if R3 > R9 then
                R9 := R3;
        else
                skip;
        fi;


        write R9;
END
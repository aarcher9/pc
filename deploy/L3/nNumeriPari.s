BEGIN
        R2 := 0;
        read R1;
        R3 := R1 - 1;

        write R2;

        while R2 < R3 do
                R2 := R2 + 2;
                write R2;
        done;
END
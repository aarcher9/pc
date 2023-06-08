BEGIN
        // Alcuni vecchi test
        R1 := 6;
        write R1;

        // Il nuovo if/else
        if 0 < 1 then
                write 7; 
        fi;

        // Quello già implementato
        if 0 < 1 then
                write 8;
        else
                skip;
        fi;


        // Test and con le operazioni AND
        // 0 expected
        write true && false;
        write false && true;
        write false && false;

        // 1 expected
        write true && true;

        write 9;

        R2 := false && false;
        write R2;

        R3 := true;
        R4 := true;
        write R4 && R3;

        write 10;

        // Duale
        R5 R6 DUAL 8;
        write R5;
        write R6;
END
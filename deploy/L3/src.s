BEGIN

        R1 := 6;
        write true || true;
        write R1;

        if 0 < 1 then
                write 999; 
        fi;

        // else
        //        skip;
        // fi;

        // R1 := true;
        // R2 := false;
        // R3 := false;
        // R4 := true;
        // R5 := true;

        // Pure booleans AND test
        // 0 expected
        // write true && false;
        // write false && true;
        // write false && false;

        // 1 expected
        // write true && true;


        // Pure booleans OR test
        // 0 expected
        // write false || false;

        // 1 expected
        // write true || false;
        // write false || true;

        // 1 expected
        // write true || true;
END
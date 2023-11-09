codeunit 60001 "CLIP GetMin"
{
    procedure GetMin(A: Integer; B: Integer): Integer
    begin
        // if A < B then
        //     exit(A)
        // else
        //     exit(B);

        if A < B then
            exit(A);
        exit(B);
    end;
}
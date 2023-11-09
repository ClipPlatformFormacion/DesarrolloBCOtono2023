codeunit 60000 "CLIP Courses - Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    begin

    end;

    [Test]
    procedure Test002()
    begin
        Error('Un error');
    end;

    local procedure FuncionAuxiliar()
    begin

    end;
}
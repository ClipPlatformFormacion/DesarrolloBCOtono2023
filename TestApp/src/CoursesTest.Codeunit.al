codeunit 60000 "CLIP Courses - Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    var
        GetMinCodeunit: Codeunit "CLIP GetMin";
        ValueA, ValueB : Integer;
        Result: Integer;
    begin
        // [Scenario] Una función llamada GetMin devuelve el mínimo de 2 valores numéricos

        // [Given] 2 valores numéricos (ValorA: 1, ValorB: 2)
        ValueA := 1;
        ValueB := 2;

        // [When] se realiza la llamada a la función
        Result := GetMinCodeunit.GetMin(ValueA, ValueB);

        // [Then] el resultado tiene que ser ValorA
        if Result <> ValueA then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure Test002()
    var
        GetMinCodeunit: Codeunit "CLIP GetMin";
        ValueA, ValueB : Integer;
        Result: Integer;
    begin
        // [Scenario] Una función llamada GetMin devuelve el mínimo de 2 valores numéricos

        // [Given] 2 valores numéricos (ValorA: 1, ValorB: 2)
        ValueA := 2;
        ValueB := 1;

        // [When] se realiza la llamada a la función
        Result := GetMinCodeunit.GetMin(ValueA, ValueB);

        // [Then] el resultado tiene que ser ValorB
        if Result <> ValueB then
            Error('El resultado no es correcto');
    end;
}
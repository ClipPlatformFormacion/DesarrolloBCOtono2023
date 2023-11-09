codeunit 60000 "CLIP Courses - Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

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

    [Test]
    procedure SelectingACourseOnASalesLineP001()
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
    begin
        // [Scenario] Cuando se selecciona un curso en una línea de venta, el sistema rellena la información relacionada

        // [Given]  Un curso con Descripción, Grupos Contable y Precio
        //          Un documento de venta con una línea de venta
        LibraryCourse.CreateCourse(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] Se selecciona el curso en la línea de venta
        SalesLine.Validate(Type, SalesLine.Type::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");

        // [Then] La línea de venta tiene la Descripción, Grupos Contables y Precio correctos
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La línea de venta no tiene la descripción correcta');
        // TODO: Comprobaciones de grupos contables y precio
    end;
}
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
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'La línea de venta no tiene el precio correcto');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'Grupo contable incorrecto');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'Grupo de IVA incorrecto');
    end;

    [Test]
    procedure CourseSalesPostingP002()
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
        PostedDocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta para un curso y edición, la edición se guarda en los documentos registrados

        // [Given]  Un curso con Descripción, Grupos Contable y Precio
        //          Una edición para el curso
        //          Un documento de venta con una línea de venta, para el curso y edición
        LibraryCourse.CreateCourse(Course);
        CourseEdition := LibraryCourse.CreateEdition(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, SalesLine.Type::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 5);
        SalesLine.Modify(true);

        // [When] Se registra el documento de venta
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] La edición se ha guardado en los documentos registrados
        SalesInvoiceLine.SetRange("Document No.", PostedDocumentNo);
        SalesInvoiceLine.FindFirst();
        LibraryAssert.AreEqual(CourseEdition.Edition, SalesInvoiceLine."CLIP Course Edition", 'La edición en la factura es incorrecta');
    end;

    [Test]
    procedure CourseSalesPostingP003()
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
        PostedDocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta para un curso y edición, se crean los movimientos de curso adecuados

        // [Given]  Un curso con Descripción, Grupos Contable y Precio
        //          Una edición para el curso
        //          Un documento de venta con una línea de venta, para el curso y edición
        LibraryCourse.CreateCourse(Course);
        CourseEdition := LibraryCourse.CreateEdition(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, SalesLine.Type::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 5);
        SalesLine.Modify(true);

        // [When] Se registra el documento de venta
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] La edición se ha guardado en los documentos registrados
        CourseLedgerEntry.SetRange("Document No.", PostedDocumentNo);
        LibraryAssert.AreEqual(1, CourseLedgerEntry.Count(), 'El Nº de movimientos no es correcto');

        CourseLedgerEntry.FindFirst();
        LibraryAssert.AreEqual(SalesHeader."Posting Date", CourseLedgerEntry."Posting Date", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."No.", CourseLedgerEntry."Course No.", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."CLIP Course Edition", CourseLedgerEntry."Course Edition", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine.Description, CourseLedgerEntry.Description, 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."Qty. to Invoice", CourseLedgerEntry.Quantity, 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."Unit Price", CourseLedgerEntry."Unit Price", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."Qty. to Invoice" * SalesLine."Unit Price", CourseLedgerEntry."Total Price", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesHeader."Document Date", CourseLedgerEntry."Document Date", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesHeader."External Document No.", CourseLedgerEntry."External Document No.", 'Dato incorrecto');
    end;

    [Test]
    [HandlerFunctions('CourseEditionMaxStudentsMessage')]
    procedure SelectingAnEditionOnASalesLineP004()
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
    begin
        // [Scenario] Si una edición de un curso está llena (se ha vendido tanta cantidad como número máximo de alumnos)
        //              y el usuario pretende realizar una nueva venta, el sistema debe mostrarle una notificación

        // [Given] Un curso y una edición con 5 alumnos como máximo
        LibraryCourse.CreateCourse(Course);
        CourseEdition := LibraryCourse.CreateEdition(Course);
        CourseEdition."Max. Students" := 5;
        CourseEdition.Modify();
        //          Facturas del curso y edición para 4 alumnos
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, SalesLine.Type::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);
        LibrarySales.PostSalesDocument(SalesHeader, true, true);

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, SalesLine.Type::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 3);
        SalesLine.Modify(true);
        LibrarySales.PostSalesDocument(SalesHeader, true, true);

        //          Un pedido de venta para el curso y edición
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, SalesLine.Type::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);

        // [When] Se selecciona cantidad 2 en el pedido de venta
        SalesLine.Validate(Quantity, 2);
        SalesLine.Modify(true);

        // [Then] Se le muestra notificación al usuario
    end;

    [MessageHandler]
    procedure CourseEditionMaxStudentsMessage(Message: Text[1024])
    begin

    end;

    [Test]
    procedure SelectingAnEditionOnASalesLineP005()
    begin
        // [Scenario] Si una edición de un curso no está llena (se ha vendido tanta cantidad como número máximo de alumnos)
        //              y el usuario pretende realizar una nueva venta, el sistema no debe mostrarle una notificación

        // [Given] Un curso y una edición con 5 alumnos como máximo
        //          Facturas del curso y edición para 4 alumnos
        //          Un pedido de venta para el curso y edición

        // [When] Se selecciona cantidad 1 en el pedido de venta

        // [Then] No se le muestra notificación al usuario
    end;
}
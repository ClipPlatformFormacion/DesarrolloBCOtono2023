codeunit 50100 "CLIP Course Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", OnBeforeIncludeOption, '', false, false)]
    local procedure OnBeforeIncludeOption_IncludeCourse(OptionLookupBuffer: Record "Option Lookup Buffer" temporary; LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean; RecRef: RecordRef);
    begin
        if Option <> "Sales Line Type"::"CLIP Course".AsInteger() then
            exit;

        Result := true;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignFieldsForNo', '', false, false)]
    local procedure OnAfterAssignFieldsForNo_CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record "CLIP Course";
    begin
        if SalesLine.Type <> SalesLine.Type::"CLIP Course" then
            exit;

        Course.Get(SalesLine."No.");
        Course.TestField("Gen. Prod. Posting Group");
        SalesLine.Description := Course.Name;
        SalesLine."Description 2" := '';
        SalesLine."Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";
        SalesLine."VAT Prod. Posting Group" := Course."VAT Prod. Posting Group";
        SalesLine."Allow Item Charge Assignment" := false;
        SalesLine."Unit Price" := Course.Price;
        OnAfterAssignCourseValues(SalesLine, Course, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record "CLIP Course"; SalesHeader: Record "Sales Header")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostSalesLineOnBeforePostSalesLine, '', false, false)]
    local procedure OnPostSalesLineOnBeforePostSalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line");
    begin
        if SalesLine.Type <> SalesLine.Type::"CLIP Course" then
            exit;

        PostCourseJournalLine(SalesHeader, SalesLine, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
    end;

    local procedure PostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10])
    var
        CourseJournalLine: Record "CLIP Course Journal Line";
        CourseJournalPostLine: Codeunit "CLIP Course Journal-Post Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJournalLine(SalesHeader, SalesLine, IsHandled, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, CourseJournalPostLine);
        if IsHandled then
            exit;

        if SalesLine."Qty. to Invoice" = 0 then
            exit;

        CourseJournalLine.Init();
        CourseJournalLine.CopyFromSalesHeader(SalesHeader);
        CourseJournalLine.CopyDocumentFields(GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, SalesHeader."Posting No. Series");
        CourseJournalLine.CopyFromSalesLine(SalesLine);
        OnPostCourseJournalLineOnAfterInit(CourseJournalLine, SalesLine);

        CourseJournalPostLine.RunWithCheck(CourseJournalLine);

        OnAfterPostCourseJournalLine(SalesHeader, SalesLine, CourseJournalLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; var CourseJournalPostLine: Codeunit "CLIP Course Journal-Post Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostCourseJournalLineOnAfterInit(var CourseJournalLine: Record "CLIP Course Journal Line"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterValidateEvent, Quantity, false, false)]
    local procedure OnAfterValidate_Quantity_SalesLine_CheckMaxStudents(var Rec: Record "Sales Line")
    var
        CourseEdition: Record "CLIP Course Edition";
        // MaxStudentsMessage: TextConst ENU = 'With this sale.....', ESP = 'Con esta venta se superará el número máximo de alumnos permitido para este curso';
        MaxStudentsMsg: Label 'With this sale (%1) %2.....', Comment = 'ESP="Con esta venta se superará el número máximo de alumnos permitido (%1) para este curso (ventas previas: %2)"';
    begin
        if Rec.Type <> Rec.Type::"CLIP Course" then
            exit;
        if Rec."No." = '' then
            exit;
        if Rec."CLIP Course Edition" = '' then
            exit;
        if Rec.Quantity = 0 then
            exit;

        CourseEdition.SetLoadFields("Max. Students");
        CourseEdition.Get(Rec."No.", Rec."CLIP Course Edition");
        CourseEdition.CalcFields("Sales (Qty.)");

        if (CourseEdition."Sales (Qty.)" + Rec.Quantity) > CourseEdition."Max. Students" then
            Message(MaxStudentsMsg, CourseEdition."Max. Students", CourseEdition."Sales (Qty.)");
    end;
}
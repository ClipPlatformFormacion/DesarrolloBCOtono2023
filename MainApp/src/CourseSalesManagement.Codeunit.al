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
        ResJnlPostLine: Codeunit "CLIP Course Journal-Post Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJournalLine(SalesHeader, SalesLine, IsHandled, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, ResJnlPostLine);
        if IsHandled then
            exit;

        if SalesLine."Qty. to Invoice" = 0 then
            exit;

        with CourseJournalLine do begin
            Init();
            CopyFromSalesHeader(SalesHeader);
            CopyDocumentFields(GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, SalesHeader."Posting No. Series");
            CopyFromSalesLine(SalesLine);
            OnPostCourseJournalLineOnAfterInit(CourseJournalLine, SalesLine);

            ResJnlPostLine.RunWithCheck(CourseJournalLine);
        end;

        OnAfterPostCourseJournalLine(SalesHeader, SalesLine, CourseJournalLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; var ResJnlPostLine: Codeunit "CLIP Course Journal-Post Line")
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
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        CourseEdition: Record "CLIP Course Edition";
        PreviousSales: Decimal;
        // MaxStudentsMessage: TextConst ENU = 'With this sale.....', ESP = 'Con esta venta se superará el número máximo de alumnos permitido para este curso';
        MaxStudentsMsg: Label 'With this sale.....', Comment = 'ESP="Con esta venta se superará el número máximo de alumnos permitido para este curso"';
    begin
        if Rec.Type <> Rec.Type::"CLIP Course" then
            exit;
        if Rec."No." = '' then
            exit;
        if Rec."CLIP Course Edition" = '' then
            exit;
        if Rec.Quantity = 0 then
            exit;

        if CourseLedgerEntry.FindSet() then
            repeat
                if (CourseLedgerEntry."Course No." = Rec."No.") and (CourseLedgerEntry."Course Edition" = Rec."CLIP Course Edition") then
                    PreviousSales := PreviousSales + CourseLedgerEntry.Quantity;
            until CourseLedgerEntry.Next() = 0;

        CourseEdition.Get(Rec."No.", Rec."CLIP Course Edition");

        if (PreviousSales + Rec.Quantity) > CourseEdition."Max. Students" then
            Message(MaxStudentsMsg);
    end;
}
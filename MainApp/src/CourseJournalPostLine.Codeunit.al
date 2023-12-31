codeunit 50101 "CLIP Course Journal-Post Line"
{
    Permissions = TableData "CLIP Course Ledger Entry" = rimd;
    //   TableData "Resource Register" = rimd,
    TableNo = "CLIP Course Journal Line";

    trigger OnRun()
    begin
        GetGLSetup();
        RunWithCheck(Rec);
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CourseJournalLineGlobal: Record "CLIP Course Journal Line";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        // ResourceRegister: Record "Resource Register";
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    procedure RunWithCheck(var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
        CourseJournalLineGlobal.Copy(CourseJournalLine);
        Code();
        CourseJournalLine := CourseJournalLineGlobal;
    end;

    local procedure "Code"()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJournalLine(CourseJournalLineGlobal, IsHandled);
        if not IsHandled then
            if CourseJournalLineGlobal.EmptyLine() then
                exit;

        // ResJnlCheckLine.RunCheck(CourseJournalLineGlobal);
        // OnCodeOnAfterRunCheck(CourseJournalLineGlobal);

        if NextEntryNo = 0 then begin
            CourseLedgerEntry.LockTable();
            NextEntryNo := CourseLedgerEntry.GetLastEntryNo() + 1;
        end;

        if CourseJournalLineGlobal."Document Date" = 0D then
            CourseJournalLineGlobal."Document Date" := CourseJournalLineGlobal."Posting Date";

        // if ResourceRegister."No." = 0 then begin
        //     ResourceRegister.LockTable();
        //     if (not ResourceRegister.FindLast()) or (ResourceRegister."To Entry No." <> 0) then
        //         InsertRegister(CourseJournalLineGlobal);
        // end;
        // ResourceRegister."To Entry No." := NextEntryNo;
        // OnBeforeResourceRegisterModify(CourseJournalLineGlobal, ResourceRegister);
        // ResourceRegister.Modify();

        CourseLedgerEntry.Init();
        CourseLedgerEntry.CopyFromCourseJournalLine(CourseJournalLineGlobal);

        GetGLSetup();
        CourseLedgerEntry."Total Price" := Round(CourseLedgerEntry."Total Price");

        CourseLedgerEntry."Entry No." := NextEntryNo;

        OnBeforeCourseLedgerEntryInsert(CourseLedgerEntry, CourseJournalLineGlobal);

        CourseLedgerEntry.Insert(true);

        NextEntryNo := NextEntryNo + 1;

        OnAfterPostCourseJournalLine(CourseJournalLineGlobal, CourseLedgerEntry);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    // local procedure InsertRegister(var CourseJournalLine: Record "CLIP Course Journal Line")
    // begin
    //     ResourceRegister.Init();
    //     ResourceRegister."No." := ResourceRegister."No." + 1;
    //     ResourceRegister."From Entry No." := NextEntryNo;
    //     ResourceRegister."To Entry No." := NextEntryNo;
    //     ResourceRegister."Creation Date" := Today();
    //     ResourceRegister."Creation Time" := Time();
    //     ResourceRegister."Source Code" := CourseJournalLine."Source Code";
    //     ResourceRegister."Journal Batch Name" := CourseJournalLine."Journal Batch Name";
    //     ResourceRegister."User ID" := CopyStr(UserId(), 1, MaxStrLen(ResourceRegister."User ID"));
    //     OnBeforeResourceRegisterInsert(CourseJournalLine, ResourceRegister);
    //     ResourceRegister.Insert();
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var CourseLedgerEntry: Record "CLIP Course Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCourseLedgerEntryInsert(var CourseLedgerEntry: Record "CLIP Course Ledger Entry"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeResourceRegisterInsert(var CourseJournalLine: Record "CLIP Course Journal Line"; var ResourceRegister: Record "Resource Register")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeResourceRegisterModify(var CourseJournalLine: Record "CLIP Course Journal Line"; var ResourceRegister: Record "Resource Register")
    // begin
    // end;

    // [IntegrationEvent(true, false)]
    // local procedure OnCodeOnAfterRunCheck(var CourseJournalLine: Record "CLIP Course Journal Line")
    // begin
    // end;
}
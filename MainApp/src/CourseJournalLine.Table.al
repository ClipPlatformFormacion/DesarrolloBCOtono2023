table 50104 "CLIP Course Journal Line"
{
    Caption = 'Res. Journal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            // TableRelation = "Res. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        // field(3; "Entry Type"; Enum "Res. Journal Line Entry Type")
        // {
        //     Caption = 'Entry Type';
        // }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestField("Posting Date");
                Validate("Document Date", "Posting Date");
            end;
        }
        field(6; "Course No."; Code[20])
        {
            Caption = 'Course No.';
            TableRelation = "CLIP Course";

            // trigger OnValidate()
            // begin
            //     if "Resource No." = '' then begin
            //         CreateDimFromDefaultDim(Rec.FieldNo("Resource No."));
            //         exit;
            //     end;

            //     Res.Get("Resource No.");
            //     Res.CheckResourcePrivacyBlocked(false);
            //     Res.TestField(Blocked, false);
            //     OnValidateResourceNoOnAfterChecks(Res, Rec, xRec);

            //     Description := Res.Name;
            //     "Direct Unit Cost" := Res."Direct Unit Cost";
            //     "Unit Cost" := Res."Unit Cost";
            //     "Unit Price" := Res."Unit Price";
            //     "Resource Group No." := Res."Resource Group No.";
            //     "Work Type Code" := '';
            //     "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
            //     Validate("Unit of Measure Code", Res."Base Unit of Measure");

            //     if not "System-Created Entry" then
            //         if "Time Sheet No." = '' then
            //             Res.TestField("Use Time Sheet", false);

            //     CreateDimFromDefaultDim(Rec.FieldNo("Resource No."));
            // end;
        }
        field(7; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition';
            TableRelation = "CLIP Course Edition";
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(16; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Price" := Quantity * "Unit Price";
            end;
        }
        field(17; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetGLSetup();
                "Unit Price" := Round("Total Price" / Quantity, GLSetup."Unit-Amount Rounding Precision");
            end;
        }
        // field(18; "Shortcut Dimension 1 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,1';
        //     Caption = 'Shortcut Dimension 1 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
        //                                                   Blocked = CONST(false));

        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        //     end;
        // }
        // field(19; "Shortcut Dimension 2 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,2';
        //     Caption = 'Shortcut Dimension 2 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
        //                                                   Blocked = CONST(false));

        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        //     end;
        // }
        // field(21; "Source Code"; Code[10])
        // {
        //     Caption = 'Source Code';
        //     Editable = false;
        //     TableRelation = "Source Code";
        // }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            // TableRelation = "Res. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        // field(24; "Reason Code"; Code[10])
        // {
        //     Caption = 'Reason Code';
        //     TableRelation = "Reason Code";
        // }
        // field(25; "Recurring Method"; Option)
        // {
        //     BlankZero = true;
        //     Caption = 'Recurring Method';
        //     OptionCaption = ',Fixed,Variable';
        //     OptionMembers = ,"Fixed",Variable;
        // }
        // field(26; "Expiration Date"; Date)
        // {
        //     Caption = 'Expiration Date';
        // }
        // field(27; "Recurring Frequency"; DateFormula)
        // {
        //     Caption = 'Recurring Frequency';
        // }
        // field(28; "Gen. Bus. Posting Group"; Code[20])
        // {
        //     Caption = 'Gen. Bus. Posting Group';
        //     TableRelation = "Gen. Business Posting Group";
        // }
        // field(29; "Gen. Prod. Posting Group"; Code[20])
        // {
        //     Caption = 'Gen. Prod. Posting Group';
        //     TableRelation = "Gen. Product Posting Group";
        // }
        field(30; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(31; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        // field(33; "Source Type"; Enum "Res. Journal Line Source Type")
        // {
        //     Caption = 'Source Type';
        // }
        // field(34; "Source No."; Code[20])
        // {
        //     Caption = 'Source No.';
        //     TableRelation = IF ("Source Type" = CONST(Customer)) Customer."No.";
        // }
        // field(480; "Dimension Set ID"; Integer)
        // {
        //     Caption = 'Dimension Set ID';
        //     Editable = false;
        //     TableRelation = "Dimension Set Entry";

        //     trigger OnLookup()
        //     begin
        //         ShowDimensions();
        //     end;

        //     trigger OnValidate()
        //     begin
        //         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //     end;
        // }
        field(959; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        LockTable();
        // ResJnlTemplate.Get("Journal Template Name");
        // ResJnlBatch.Get("Journal Template Name", "Journal Batch Name");

        // ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        // ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
    end;

    var
        ResJnlTemplate: Record "Res. Journal Template";
        ResJnlBatch: Record "Res. Journal Batch";
        ResJnlLine: Record "Res. Journal Line";
        GLSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;

    procedure EmptyLine(): Boolean
    begin
        exit(("Course No." = '') and (Quantity = 0));
    end;

    // procedure SetUpNewLine(LastResJnlLine: Record "Res. Journal Line")
    // begin
    //     ResJnlTemplate.Get("Journal Template Name");
    //     ResJnlBatch.Get("Journal Template Name", "Journal Batch Name");
    //     ResJnlLine.SetRange("Journal Template Name", "Journal Template Name");
    //     ResJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
    //     if ResJnlLine.FindFirst() then begin
    //         "Posting Date" := LastResJnlLine."Posting Date";
    //         "Document Date" := LastResJnlLine."Posting Date";
    //         "Document No." := LastResJnlLine."Document No.";
    //     end else begin
    //         "Posting Date" := WorkDate();
    //         "Document Date" := WorkDate();
    //         if ResJnlBatch."No. Series" <> '' then begin
    //             Clear(NoSeriesMgt);
    //             "Document No." := NoSeriesMgt.TryGetNextNo(ResJnlBatch."No. Series", "Posting Date");
    //         end;
    //     end;
    //     "Recurring Method" := LastResJnlLine."Recurring Method";
    //     "Source Code" := ResJnlTemplate."Source Code";
    //     "Reason Code" := ResJnlBatch."Reason Code";
    //     "Posting No. Series" := ResJnlBatch."Posting No. Series";

    //     OnAfterSetUpNewLine(Rec, LastResJnlLine);
    // end;

#if not CLEAN20
    // [Obsolete('Replaced by CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])', '20.0')]
    // procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20])
    // var
    //     TableID: array[10] of Integer;
    //     No: array[10] of Code[20];
    // begin
    //     TableID[1] := Type1;
    //     No[1] := No1;
    //     TableID[2] := Type2;
    //     No[2] := No2;
    //     TableID[3] := Type3;
    //     No[3] := No3;
    //     OnAfterCreateDimTableIDs(Rec, CurrFieldNo, TableID, No);

    //     "Shortcut Dimension 1 Code" := '';
    //     "Shortcut Dimension 2 Code" := '';
    //     "Dimension Set ID" :=
    //       DimMgt.GetRecDefaultDimID(
    //         Rec, CurrFieldNo, TableID, No, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

    //     OnAfterCreateDim(Rec, CurrFieldNo, TableID, No);
    // end;
#endif

    //     procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    //     begin
    // #if not CLEAN20
    //         RunEventOnAfterCreateDimTableIDs(DefaultDimSource);
    // #endif
    //         "Shortcut Dimension 1 Code" := '';
    //         "Shortcut Dimension 2 Code" := '';
    //         "Dimension Set ID" :=
    //           DimMgt.GetRecDefaultDimID(
    //             Rec, CurrFieldNo, DefaultDimSource, "Source Code", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

    // #if not CLEAN20
    //         RunEventOnAfterCreateDim(DefaultDimSource);
    // #endif
    //         OnAfterCreateDimProcedure(Rec, CurrFieldNo, DefaultDimSource);
    //     end;

    // procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

    //     OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    // end;

    // procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    // end;

    // procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    // begin
    //     DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    // end;

    procedure CopyDocumentFields(DocNo: Code[20]; ExtDocNo: Text[35]; SourceCode: Code[10]; NoSeriesCode: Code[20])
    begin
        "Document No." := DocNo;
        "External Document No." := ExtDocNo;
        // "Source Code" := SourceCode;
    end;

    procedure CopyFromSalesHeader(SalesHeader: Record "Sales Header")
    begin
        "Posting Date" := SalesHeader."Posting Date";
        "Document Date" := SalesHeader."Document Date";
        // "Reason Code" := SalesHeader."Reason Code";

        OnAfterCopyCourseJournalLineFromSalesHeader(SalesHeader, Rec);
    end;

    procedure CopyFromSalesLine(SalesLine: Record "Sales Line")
    begin
        "Course No." := SalesLine."No.";
        Description := SalesLine.Description;
        "Course Edition" := SalesLine."CLIP Course Edition";
        // "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        // "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        // "Dimension Set ID" := SalesLine."Dimension Set ID";
        // "Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        // "Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        // "Entry Type" := "Entry Type"::Sale;
        Quantity := -SalesLine."Qty. to Invoice";
        "Unit Price" := SalesLine."Unit Price";
        "Total Price" := -SalesLine.Amount;

        OnAfterCopyCourseJournalLineFromSalesLine(SalesLine, Rec);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GLSetup.Get();
        GLSetupRead := true;
    end;

    // procedure ShowDimensions()
    // begin
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."));
    //     DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    //     OnAfterShowDimensions(Rec);
    // end;

    // procedure IsOpenedFromBatch(): Boolean
    // var
    //     ResJournalBatch: Record "Res. Journal Batch";
    //     TemplateFilter: Text;
    //     BatchFilter: Text;
    // begin
    //     BatchFilter := GetFilter("Journal Batch Name");
    //     if BatchFilter <> '' then begin
    //         TemplateFilter := GetFilter("Journal Template Name");
    //         if TemplateFilter <> '' then
    //             ResJournalBatch.SetFilter("Journal Template Name", TemplateFilter);
    //         ResJournalBatch.SetFilter(Name, BatchFilter);
    //         ResJournalBatch.FindFirst();
    //     end;

    //     exit((("Journal Batch Name" <> '') and ("Journal Template Name" = '')) or (BatchFilter <> ''));
    // end;

    // procedure SwitchLinesWithErrorsFilter(var ShowAllLinesEnabled: Boolean)
    // var
    //     TempErrorMessage: Record "Error Message" temporary;
    //     ResJournalErrorsMgt: Codeunit "Res. Journal Errors Mgt.";
    // begin
    //     if ShowAllLinesEnabled then begin
    //         MarkedOnly(false);
    //         ShowAllLinesEnabled := false;
    //     end else begin
    //         ResJournalErrorsMgt.GetErrorMessages(TempErrorMessage);
    //         if TempErrorMessage.FindSet() then
    //             repeat
    //                 if Rec.Get(TempErrorMessage."Context Record ID") then
    //                     Rec.Mark(true)
    //             until TempErrorMessage.Next() = 0;
    //         MarkedOnly(true);
    //         ShowAllLinesEnabled := true;
    //     end;
    // end;

    // procedure CreateDimFromDefaultDim(FieldNo: Integer)
    // var
    //     DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    // begin
    //     InitDefaultDimensionSources(DefaultDimSource, FieldNo);
    //     CreateDim(DefaultDimSource);
    // end;

    // local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    // begin
    //     DimMgt.AddDimSource(DefaultDimSource, Database::Resource, Rec."Resource No.", FieldNo = Rec.FieldNo("Resource No."));
    //     DimMgt.AddDimSource(DefaultDimSource, Database::"Resource Group", Rec."Resource Group No.", FieldNo = Rec.FieldNo("Resource Group No."));
    //     DimMgt.AddDimSource(DefaultDimSource, Database::Job, Rec."Job No.", FieldNo = Rec.FieldNo("Job No."));

    //     OnAfterInitDefaultDimensionSources(Rec, DefaultDimSource, FieldNo);
    // end;

    //     local procedure CreateDefaultDimSourcesFromDimArray(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; TableID: array[10] of Integer; No: array[10] of Code[20])
    //     var
    //         DimArrayConversionHelper: Codeunit "Dim. Array Conversion Helper";
    //     begin
    //         DimArrayConversionHelper.CreateDefaultDimSourcesFromDimArray(Database::"Res. Journal Line", DefaultDimSource, TableID, No);
    //     end;

    //     local procedure CreateDimTableIDs(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; var TableID: array[10] of Integer; var No: array[10] of Code[20])
    //     var
    //         DimArrayConversionHelper: Codeunit "Dim. Array Conversion Helper";
    //     begin
    //         DimArrayConversionHelper.CreateDimTableIDs(Database::"Res. Journal Line", DefaultDimSource, TableID, No);
    //     end;

    //     local procedure RunEventOnAfterCreateDimTableIDs(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    //     var
    //         DimArrayConversionHelper: Codeunit "Dim. Array Conversion Helper";
    //         TableID: array[10] of Integer;
    //         No: array[10] of Code[20];
    //     begin
    //         if not DimArrayConversionHelper.IsSubscriberExist(Database::"Res. Journal Line") then
    //             exit;

    //         CreateDimTableIDs(DefaultDimSource, TableID, No);
    //         OnAfterCreateDimTableIDs(Rec, CurrFieldNo, TableID, No);
    //         CreateDefaultDimSourcesFromDimArray(DefaultDimSource, TableID, No);
    //     end;

    //     local procedure RunEventOnAfterCreateDim(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    //     var
    //         TableID: array[10] of Integer;
    //         No: array[10] of Code[20];
    //     begin
    //         CreateDimTableIDs(DefaultDimSource, TableID, No);
    //         OnAfterCreateDim(Rec, CurrFieldNo, TableID, No);
    //     end;
    // #endif

    //     [IntegrationEvent(false, false)]
    //     local procedure OnAfterInitDefaultDimensionSources(var ResJournalLine: Record "Res. Journal Line"; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    //     begin
    //     end;

    //     [IntegrationEvent(false, false)]
    //     local procedure OnAfterCreateDimProcedure(var ResJournalLine: Record "Res. Journal Line"; CurrFieldNo: Integer; var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    //     begin
    //     end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesHeader(var SalesHeader: Record "Sales Header"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesLine(var SalesLine: Record "Sales Line"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterSetUpNewLine(var ResJournalLine: Record "Res. Journal Line"; LastResJournalLine: Record "Res. Journal Line")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterShowDimensions(var ResJnlLine: Record "Res. Journal Line")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterValidateShortcutDimCode(var ResJournalLine: Record "Res. Journal Line"; xResJournalLine: Record "Res. Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeValidateShortcutDimCode(var ResJournalLine: Record "Res. Journal Line"; xResJournalLine: Record "Res. Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnValidateResourceNoOnAfterChecks(var Resource: Record Resource; var ResJournalLine: Record "Res. Journal Line"; xResJournalLine: Record "Res. Journal Line")
    // begin
    // end;
}


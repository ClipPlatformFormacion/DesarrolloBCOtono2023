table 50100 "CLIP Course"
{
    Caption = 'Course', Comment = 'ESP="Curso"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';

            trigger OnValidate()
            var
                CoursesSetup: Record "CLIP Courses Setup";
                NoSeriesManagement: Codeunit NoSeriesManagement;
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if Rec."No." <> xRec."No." then begin
                    CoursesSetup.Get();
                    NoSeriesManagement.TestManual(CoursesSetup."Course Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
        }
        field(3; "Content Description"; Text[2048])
        {
            Caption = 'Content Description', Comment = 'ESP="Temario"';
        }
        field(4; "Duration (hours)"; Integer)
        {
            Caption = 'Duration (hours)', Comment = 'ESP="Duración (horas)"';
        }
        field(5; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
        }
        field(6; "Type Option"; Option)
        {
            Caption = 'Type Option', Comment = 'ESP="Tipo opción"';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaption = ' ,Instructor-Lead,Video Tutorial', Comment = 'ESP=" ,Guiado por profesor,Vídeo tutorial"';
        }
        field(7; Type; Enum "CLIP Course Type")
        {
            Caption = 'Type', Comment = 'ESP="Tipo"';
        }
        field(8; "Language Code"; Code[10])
        {
            Caption = 'Language Code', Comment = 'ESP="Cód. idioma"';
            TableRelation = Language;
        }
        field(56; "No. Series"; Code[20])
        {
            Caption = 'No. Series', Comment = 'ESP="Nº Serie"';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(51; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', Comment = 'ESP="Grupo contable prod. gen."';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProductPostingGroup: Record "Gen. Product Posting Group";
            begin
                if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                    if GenProductPostingGroup.ValidateVatProdPostingGroup(GenProductPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", GenProductPostingGroup."Def. VAT Prod. Posting Group");
            end;
        }
        field(58; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group', Comment = 'ESP="Grupo contable IVA prod."';
            TableRelation = "VAT Product Posting Group";
        }
    }

    keys
    {
        key(PK; "No.") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, Type, "Duration (hours)", "Language Code") { }
        fieldgroup(Brick; "No.", Name, Price) { }
    }

    trigger OnInsert()
    var
        CoursesSetup: Record "CLIP Courses Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeOnInsert(Rec, IsHandled, xRec);
        if IsHandled then
            exit;

        if Rec."No." = '' then begin
            CoursesSetup.Get();
            CoursesSetup.TestField("Course Nos.");
            NoSeriesManagement.InitSeries(CoursesSetup."Course Nos.", xRec."No. Series", 0D, Rec."No.", Rec."No. Series");
        end;
    end;

    procedure AssistEdit(OldCourses: Record "CLIP Course") Result: Boolean
    var
        Courses: Record "CLIP Course";
        CoursesSetup: Record "CLIP Courses Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeAssistEdit(Rec, OldCourses, IsHandled, Result);
        if IsHandled then
            exit;

        Courses := Rec;
        CoursesSetup.Get();
        CoursesSetup.TestField("Course Nos.");
        if NoSeriesManagement.SelectSeries(CoursesSetup."Course Nos.", OldCourses."No. Series", Courses."No. Series") then begin
            CoursesSetup.Get();
            CoursesSetup.TestField("Course Nos.");
            NoSeriesManagement.SetSeries(Courses."No.");
            Rec := Courses;
            exit(true);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAssistEdit(var Courses: Record "CLIP Course"; xOldCourses: Record "CLIP Course"; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Courses: Record "CLIP Course"; xCourses: Record "CLIP Course"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Courses: Record "CLIP Course"; var IsHandled: Boolean; var xCourses: Record "CLIP Course")
    begin
    end;
}
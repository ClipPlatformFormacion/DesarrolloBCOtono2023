table 50100 Courses
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', ESP = 'Nº';

            trigger OnValidate()
            var
                CoursesSetup: Record "Courses Setup";
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
            CaptionML = ENU = 'Name', ESP = 'Nombre';
        }
        field(3; "Content Description"; Text[2048])
        {
            CaptionML = ENU = 'Content Description', ESP = 'Temario';
        }
        field(4; "Duration (hours)"; Integer)
        {
            CaptionML = ENU = 'Duration (hours)', ESP = 'Duración (horas)';
        }
        field(5; Price; Decimal)
        {
            CaptionML = ENU = 'Price', ESP = 'Precio';
        }
        field(6; "Type Option"; Option)
        {
            CaptionML = ENU = 'Type Option', ESP = 'Tipo opción';
            OptionMembers = " ","Instructor-Lead","Video Tutorial";
            OptionCaptionML = ENU = ' ,Instructor-Lead,Video Tutorial', ESP = ' ,Guiado por profesor,Vídeo tutorial';
        }
        field(7; Type; Enum "Course Type")
        {
            CaptionML = ENU = 'Type', ESP = 'Tipo';
        }
        field(8; "Language Code"; Code[10])
        {
            CaptionML = ENU = 'Language Code', ESP = 'Cód. idioma';
            TableRelation = Language;
        }
        field(56; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series', ESP = 'Nº Serie';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.") { }
    }

    trigger OnInsert()
    var
        CoursesSetup: Record "Courses Setup";
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

    procedure AssistEdit(OldCourses: Record Courses) Result: Boolean
    var
        Courses: Record Courses;
        CoursesSetup: Record "Courses Setup";
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
    local procedure OnBeforeAssistEdit(var Courses: Record Courses; xOldCourses: Record Courses; var IsHandled: Boolean; var Result: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateNo(var Courses: Record Courses; xCourses: Record Courses; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Courses: Record Courses; var IsHandled: Boolean; var xCourses: Record Courses)
    begin
    end;
}
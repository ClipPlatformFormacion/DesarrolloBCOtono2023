page 50102 "CLIP Courses Setup"
{
    AccessByPermission = TableData "CLIP Course" = R;
    ApplicationArea = All;
    Caption = 'Courses Setup', Comment = 'ESP="Config. cursos"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "CLIP Courses Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering', Comment = 'ESP="Numeración"';
                field("Course Nos."; Rec."Course Nos.")
                {
                    ToolTip = 'Specifies the number series code you can use to assign numbers to courses.', Comment = 'ESP="Especifica el código de serie numérica que se puede utilizar para asignar números a los cursos."';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}


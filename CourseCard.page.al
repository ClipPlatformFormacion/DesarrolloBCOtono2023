page 50101 "Course Card"
{
    // Caption = 'Course Card', Comment = 'ESP="Ficha curso"';
    Caption = 'Course Card', Comment = 'ESP="Ficha curso"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Courses;

    layout
    {
        area(Content)
        {
            group(Course)
            {
                Caption = 'Course', Comment = 'ESP="Curso"';
                field("No."; Rec."No.")
                {
                    ToolTip = 'The tooltip text', Comment = 'ESP="El texto del tooltip"';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name) { }
            }
            part(EditionsFactbox; "Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
            }

            group(TrainingDetails)
            {
                Caption = 'Training Details', Comment = 'ESP="Detalles formativos"';
                field("Content Description"; Rec."Content Description") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Type; Rec.Type) { }
                field("Language Code"; Rec."Language Code") { }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing', Comment = 'ESP="Facturación"';
                field(Price; Rec.Price) { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Editions)
            {
                Caption = 'Editions', Comment = 'ESP="Ediciones"';
                RunObject = page "Course Editions";
                RunPageLink = "Course No." = field("No.");
                Image = ShowList;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }
        }
    }
}
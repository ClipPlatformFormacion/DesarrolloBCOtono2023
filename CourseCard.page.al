page 50101 "Course Card"
{
    CaptionML = ENU = 'Course Card', ESP = 'Ficha curso';
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
                CaptionML = ENU = 'Course', ESP = 'Curso';
                field("No."; Rec."No.")
                {
                    ToolTipML = ENU = 'The tooltip text', ESP = 'El texto del tooltip';
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
                CaptionML = ENU = 'Training Details', ESP = 'Detalles formativos';
                field("Content Description"; Rec."Content Description") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Type; Rec.Type) { }
                field("Language Code"; Rec."Language Code") { }
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
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
                CaptionML = ENU = 'Editions', ESP = 'Ediciones';
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
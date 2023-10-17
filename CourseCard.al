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
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Name; Rec.Name) { }
            }
            group(TrainingDetails)
            {
                field("Content Description"; Rec."Content Description") { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Type; Rec.Type) { }
                field("Language Code"; Rec."Language Code") { }
            }
            group(Invoicing)
            {
                field(Price; Rec.Price) { }
            }
        }
    }
}
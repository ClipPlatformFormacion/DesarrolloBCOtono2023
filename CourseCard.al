page 50101 "Course Card"
{
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
                field("No."; Rec."No.") { }
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
page 50100 "CLIP Courses List"
{
    Caption = 'Courses', Comment = 'ESP="Cursos"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    Editable = false;
    CardPageId = "CLIP Course Card";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { }
                field(Name; Rec.Name) { }
                field("Duration (hours)"; Rec."Duration (hours)") { }
                field(Type; Rec.Type) { }
                field("Type Option"; Rec."Type Option") { }
                field("Language Code"; Rec."Language Code") { }
                field(Price; Rec.Price) { }
            }
        }
        area(FactBoxes)
        {
            part(EditionsFactbox; "CLIP Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
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
                RunObject = page "CLIP Course Editions";
                RunPageLink = "Course No." = field("No.");
                Image = ShowList;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }
        }
        area(Navigation)
        {
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger E&ntries', Comment = 'ESP="Movimientos"';
                    Image = ResourceLedger;
                    RunObject = Page "CLIP Course Ledger Entries";
                    RunPageLink = "Course No." = FIELD("No.");
                    RunPageView = sorting("Course No.")
                                  order(descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
        }
    }
}
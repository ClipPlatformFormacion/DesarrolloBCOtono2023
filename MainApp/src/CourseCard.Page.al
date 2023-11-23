page 50101 "CLIP Course Card"
{
    // Caption = 'Course Card', Comment = 'ESP="Ficha curso"';
    Caption = 'Course Card', Comment = 'ESP="Ficha curso"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "CLIP Course";

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
            part(EditionsFactbox; "CLIP Course Editions Factbox")
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
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group") { }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group") { }
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
#pragma warning disable AL0254
                    RunPageView = sorting("Course No.")
                                  order(descending);
#pragma warning restore
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
        }
    }
}
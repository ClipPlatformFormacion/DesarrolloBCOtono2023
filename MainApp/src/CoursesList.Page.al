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
        area(Reporting)
        {
            action(CourseList)
            {
                Caption = 'Course List', comment = 'ESP="Lista cursos"';
                RunObject = report "CLIP Course List";
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Report;
            }
        }
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
            action(UpdatePrices)
            {
                Caption = 'Update prices', comment = 'ESP="Actualizar precios"';
                RunObject = report "CLIP Update Course Price";
                Image = UpdateUnitCost;
            }
            action(ExecuteQuery)
            {
                Caption = 'Execute Query', comment = 'ESP="Ejecutar Query"';
                Image = ExecuteBatch;

                trigger OnAction()
                var
                    CourseQuery: Query "CLIP Courses";
                    TotalSalesQty: Decimal;
                begin
                    // CourseQuery.SetRange(No_, Rec."No.");
                    CourseQuery.SetFilter(Language_Code, '<>%1', '');
                    CourseQuery.Open();

                    while CourseQuery.Read() do
                        TotalSalesQty += CourseQuery.Sales__Qty__;

                    CourseQuery.Close();
                    Message(Format(TotalSalesQty));
                end;
            }
            action(ExecuteXMLPort)
            {
                RunObject = xmlport "CLIP Sales Orders";
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
#pragma warning restore
                                  order(descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
            }
        }
    }
}
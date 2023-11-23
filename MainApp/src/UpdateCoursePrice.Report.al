report 50100 "CLIP Update Course Price"
{
    Caption = 'Update Course Price', comment = 'ESP="Actualizar precio cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            RequestFilterFields = "No.", Type;

            trigger OnPreDataItem()
            begin
                // Message('OnPreDataItem');
            end;

            trigger OnAfterGetRecord()
            begin
                Counter += 1;
                // Message(Course."No.");
                Course.Price := Course.Price + (Course.Price * Percentage / 100);
                Course.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                // Message('OnPostDataItem %1', Counter);

                Message('Se ha actualizado el precio de %1 cursos en un %2%', Counter, Percentage);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', comment = 'ESP="Opciones"';
                    field(PercentageControl; Percentage)
                    {
                        Caption = 'Price increase %', comment = 'ESP="% incremento precio"';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            Percentage := 10;
        end;
    }

    trigger OnPreReport()
    begin
        if Percentage = 0 then
            Error('Hay que establecer un porcentaje');

        if Course.GetFilters() = '' then
            Error('Hay que establecer algún filtro');
    end;

    var
        Counter: Integer;
        Percentage: Decimal;
}
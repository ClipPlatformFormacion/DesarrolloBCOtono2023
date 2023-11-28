report 50101 "CLIP Course List"
{
    Caption = 'Course List', comment = 'ESP="Lista cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ExcelLayout;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            PrintOnlyIfDetail = true;
#pragma warning disable AL0254 
            DataItemTableView = sorting("Duration (hours)") order(descending);
#pragma warning restore
            column(ReportCaption; ReportCaptionLbl) { }
            column(CompanyName; COMPANYPROPERTY.DisplayName()) { }
            column(ReportFilters; Course.TableCaption() + ': ' + CourseFilter) { }
            column(CourseNo; "No.") { IncludeCaption = true; }
            column(CourseName; Name) { IncludeCaption = true; }
            column(CourseLanguageCode; "Language Code") { IncludeCaption = true; }

            dataitem(CourseEdition; "CLIP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");

                column(CourseEditionCode; Edition) { IncludeCaption = true; }
                column(EditionMaxStudents; "Max. Students") { IncludeCaption = true; }
                column(EditionSalesQty; "Sales (Qty.)") { IncludeCaption = true; }
            }
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }
    // }

    rendering
    {
        layout(MiLayoutPorDefecto)
        {
            Type = RDLC;
            LayoutFile = './src/CourseList.MiLayoutPorDefecto.rdl';
        }
        layout(ExcelLayout)
        {
            Type = Excel;
            LayoutFile = './src/CourseList.ExcelLayout.xlsx';
        }
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        CourseFilter := FormatDocument.GetRecordFiltersWithCaptions(Course);
    end;

    var
        ReportCaptionLbl: Label 'Course Edition List', Comment = 'ESP="Lista Ediciones curso"';
        CourseFilter: Text;
}
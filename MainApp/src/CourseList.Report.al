report 50101 "CLIP Course List"
{
    Caption = 'Course List', comment = 'ESP="Lista cursos"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = MiLayoutPorDefecto;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            column(CourseNo; "No.") { }
            column(CourseName; Name) { }
            column(CourseLanguageCode; "Language Code") { }

            dataitem(CourseEdition; "CLIP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");

                column(CourseEditionCode; Edition) { }
                column(EditionMaxStudents; "Max. Students") { }
                column(EditionSalesQty; "Sales (Qty.)") { }
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
    }
}
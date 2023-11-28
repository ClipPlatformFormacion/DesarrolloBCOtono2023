query 50100 "CLIP Courses"
{
    QueryType = Normal;

    elements
    {
        dataitem(Course; "CLIP Course")
        {
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Price; Price) { }
            filter(Language_Code; "Language Code") { }
            dataitem(CourseEdition; "CLIP Course Edition")
            {
                DataItemLink = "Course No." = Course."No.";
                SqlJoinType = InnerJoin;
                column(Edition; Edition) { }
                column(Sales__Qty__; "Sales (Qty.)") { }
            }
        }
    }
}
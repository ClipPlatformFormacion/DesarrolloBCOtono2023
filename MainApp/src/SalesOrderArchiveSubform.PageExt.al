pageextension 50109 "CLIP SalesOrderArchive Subform" extends "Sales Order Archive Subform"
{
    layout
    {
        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition")
            {
                ApplicationArea = All;
            }
        }
    }
}
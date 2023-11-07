pageextension 50110 "CLIP SalesQuoteArchive Subform" extends "Sales Quote Archive Subform"
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
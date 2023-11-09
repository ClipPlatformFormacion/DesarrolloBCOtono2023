pageextension 50102 "CLIP PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform"
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
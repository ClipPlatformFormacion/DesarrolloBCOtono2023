pageextension 50105 "CLIP PostedSalesCr.MemoSubform" extends "Posted Sales Cr. Memo Subform"
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
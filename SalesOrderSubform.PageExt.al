pageextension 50100 "CLIP Sales Order Subform" extends "Sales Order Subform"
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
        // modify("Item Reference No.")
        // {
        //     Visible = false;
        // }
        // movefirst(Control1; "Reserved Quantity")
        // moveafter("Reserved Quantity"; "Qty. to Assemble to Order")
    }
}
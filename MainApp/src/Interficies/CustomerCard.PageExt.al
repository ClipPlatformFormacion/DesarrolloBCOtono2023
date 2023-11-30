pageextension 50111 "CLIP Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("CLIP Level"; Rec."CLIP Level") { ApplicationArea = All; }
            field("CLIP Discount"; Rec."CLIP Discount") { ApplicationArea = All; }
        }
    }
}
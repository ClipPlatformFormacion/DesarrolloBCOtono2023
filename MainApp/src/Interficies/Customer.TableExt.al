tableextension 50107 "CLIP Customer" extends Customer
{
    fields
    {
        field(50100; "CLIP Discount"; Decimal)
        {
            Caption = 'Discount', comment = 'ESP="Descuento"';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50101; "CLIP Level"; Enum "CLIP Customer Level")
        {
            Caption = 'Level', comment = 'ESP="Nivel"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CustomerLevel: Interface "CLIP Customer Level";
            begin
                CustomerLevel := Rec."CLIP Level";
                Rec.Validate("CLIP Discount", CustomerLevel.GetDiscount());
            end;
        }
    }
}
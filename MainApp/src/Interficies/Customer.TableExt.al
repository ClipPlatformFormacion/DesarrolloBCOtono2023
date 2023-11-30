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
                UnknownLevelLbl: Label 'Unknown Level %1', Comment = 'ESP="Nivel desconodico %1"';
            begin
                case Rec."CLIP Level" of
                    "CLIP Customer Level"::" ":
                        Rec.Validate("CLIP Discount", 0);
                    "CLIP Customer Level"::Bronze:
                        Rec.Validate("CLIP Discount", 5);
                    "CLIP Customer Level"::Silver:
                        Rec.Validate("CLIP Discount", 10);
                    else
                        Error(UnknownLevelLbl, Rec."CLIP Level");
                end;
            end;
        }
    }
}
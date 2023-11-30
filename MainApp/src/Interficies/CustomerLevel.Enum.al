enum 50101 "CLIP Customer Level" implements "CLIP Customer Level"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', comment = 'ESP=" "';
        Implementation = "CLIP Customer Level" = "CLIP Blank Customer Level";
    }
    value(1; Bronze)
    {
        Caption = 'Bronze', comment = 'ESP="Bronce"';
        Implementation = "CLIP Customer Level" = "CLIP Bronze Customer Level";
    }
    value(2; Silver)
    {
        Caption = 'Silver', comment = 'ESP="Plata"';
        Implementation = "CLIP Customer Level" = "CLIP Silver Customer Level";
    }
}
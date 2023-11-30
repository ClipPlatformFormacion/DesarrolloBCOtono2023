enumextension 60000 "CLIP CLIP Customer Level" extends "CLIP Customer Level"
{
    value(60000; "CLIP Gold")
    {
        Caption = 'Gold', comment = 'ESP="Oro"';
        Implementation = "CLIP Customer Level" = "CLIP Gold Customer Level";
    }
}
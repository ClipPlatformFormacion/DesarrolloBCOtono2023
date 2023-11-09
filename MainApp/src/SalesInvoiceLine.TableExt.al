tableextension 50103 "CLIP Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "CLIP Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            DataClassification = CustomerContent;
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("No."));
        }
        modify("No.")
        {
            TableRelation = if (Type = const("CLIP Course")) "CLIP Course";
        }
    }
}
page 50105 "CLIP Application Area Setup"
{
    //TODO: Borrar esta página!!!
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Application Area Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Advanced; Rec.Advanced) { }
                field(Manufacturing; Rec.Manufacturing) { }
            }
        }

    }
}
namespace ClipPlatform.Sales;

table 50105 Language
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; MyField; Integer)
        {
        }
    }

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }
}
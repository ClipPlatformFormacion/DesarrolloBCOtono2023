codeunit 60002 "CLIP Library - Course"
{
    procedure CreateCourse(var Course: Record "CLIP Course")
    var
        GeneralPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        LibraryERM: Codeunit "Library - ERM";
        LibraryRandom: Codeunit "Library - Random";
    begin
        CourseNoSeriesSetup();
        LibraryERM.FindGeneralPostingSetupInvtFull(GeneralPostingSetup);
        LibraryERM.FindVATPostingSetupInvt(VATPostingSetup);

        Clear(Course);
        Course.Insert(true);
        Course.Validate(Name, Course."No.");  // Validate Name as No. because value is not important.
        Course.Validate(Price, LibraryRandom.RandDec(1000, 2));  // Required field - value is not important.
        Course.Validate("Gen. Prod. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");
        Course.Validate("VAT Prod. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
        Course.Modify(true);
    end;

    internal procedure CreateEdition(Course: Record "CLIP Course") CourseEdition: Record "CLIP Course Edition"
    var
        LibraryRandom: Codeunit "Library - Random";
    begin
        CourseEdition.Init();
        CourseEdition.Validate("Course No.", Course."No.");
        CourseEdition.Validate(Edition, LibraryRandom.RandText(MaxStrLen(CourseEdition.Edition)));
        CourseEdition.Validate("Start Date", LibraryRandom.RandDateFrom(Today(), 90));
        CourseEdition.Validate("Max. Students", LibraryRandom.RandIntInRange(10, 20));
        CourseEdition.Insert(true);
    end;

    local procedure CourseNoSeriesSetup()
    var
        CoursesSetup: Record "CLIP Courses Setup";
        LibraryUtility: Codeunit "Library - Utility";
        NoSeriesCode: Code[20];
    begin
        if not CoursesSetup.Get() then
            CoursesSetup.Insert();
        NoSeriesCode := LibraryUtility.GetGlobalNoSeriesCode();
        if NoSeriesCode <> CoursesSetup."Course Nos." then begin
            CoursesSetup.Validate("Course Nos.", LibraryUtility.GetGlobalNoSeriesCode());
            CoursesSetup.Modify(true);
        end;
    end;
}
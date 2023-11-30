namespace ClipPlatform.Permission;

using ClipPlatform.Course;
using ClipPlatform.Sales;

permissionset 50100 "CLIP Courses - All"
{
    Caption = 'Courses - All permissions', Comment = 'ESP="Cursos - Todos los permisos"';
    Assignable = true;
    Permissions =
        tabledata "CLIP Courses Setup" = RIMD,
        tabledata "CLIP Course" = RIMD,
        tabledata "CLIP Course Edition" = RIMD,
        table "CLIP Course Edition" = X,
        table "CLIP Course" = X,
        table "CLIP Courses Setup" = X,
        page "CLIP Course Card" = X,
        page "CLIP Course Editions" = X,
        page "CLIP Course Editions Factbox" = X,
        page "CLIP Courses List" = X,
        page "CLIP Courses Setup" = X,
        table "CLIP Course Ledger Entry" = X,
        tabledata "CLIP Course Ledger Entry" = RMID,
        codeunit "CLIP Course Sales Management" = X,
        table "CLIP Course Journal Line" = X,
        tabledata "CLIP Course Journal Line" = RMID,
        page "CLIP Course Ledger Entries" = X,
        table Language = X,
        tabledata Language = RMID,
        codeunit "CLIP Blank Customer Level" = X,
        codeunit "CLIP Bronze Customer Level" = X,
        codeunit "CLIP Course Journal-Post Line" = X,
        codeunit "CLIP Silver Customer Level" = X,
        query "CLIP Courses" = X,
        report "CLIP Course List" = X,
        report "CLIP Update Course Price" = X,
        xmlport "CLIP Sales Orders" = X;
}
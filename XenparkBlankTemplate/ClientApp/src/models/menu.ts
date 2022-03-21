export interface IMenuItem {
    Id: string;
    Title: string;
    Type: string;
    URL?: string;
    Icon?: string;
    Badge?: MenuBadge;
    Target?: boolean;
    Breadcrumbs?: boolean;
    Classes?: string;
    External?: boolean;
    Children?: IMenuItem[]
}

export interface MenuBadge {
    title: string;
    type: string;
}
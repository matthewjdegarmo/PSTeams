﻿function New-AdaptiveAction {
    [cmdletBinding()]
    param(
        [scriptblock] $Body,
        [scriptblock] $Actions,
        [ValidateSet('Action.ShowCard', 'Action.Submit')][string] $Type = 'Action.ShowCard',
        [string] $Title
    )
    $TeamObject = [ordered] @{
        type  = $Type
        title = $Title
        card  = [ordered]@{}
    }
    if ($Body -or $Actions) {
        $TeamObject['card']['type'] = 'AdaptiveCard'
        if ($Body) {
            $TeamObject['card']['body'] = & $Body
        }
        if ($Actions) {
            $TeamObject['card']['actions'] = & $Actions
        }
    }
    Remove-EmptyValue -Hashtable $TeamObject
    $TeamObject
}
$begin = Get-Date -Date 'dd/mm/yyyy'
$end = Get-Date -Date 'dd/mm/yyyy'
 
If ($begin -gt $end) {Write-Warning "Дата конца периода $($end.ToShortDateString()) должна быть позже даты начала $($begin.ToShortDateString())!" -WarningAction Stop}
 
$group = 'GROUP_NAME'
$members = Get-ADGroupMember -Identity $group -Recursive
 
ForEach ($member in $members) {
    if ((Get-ADUser $member -Property MemberOf | select -ExpandProperty MemberOf) -match 'PSO-домашний') {
        #Write-Host $member.Name, '- PSO-домашний'
    } else {
        [datetime]$passchange = Get-ADUser $member -Properties PasswordLastSet | select -ExpandProperty PasswordLastSet
        if ($passchange.AddDays(180) -ge $begin -and $passchange.AddDays(180) -le $end) {
            Write-Host $member.Name -ForegroundColor Red -NoNewline
            Write-Host ' - ', $passchange.AddDays(180) -ForegroundColor Red
        }
    }
}
(Get-ADGroupMember $group -Recursive).count

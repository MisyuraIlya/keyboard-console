﻿Param(
    [String]$Att,
    [String]$Subj,
    [String]$Body
)

Function Send-EMail {
    Param (
        [Parameter(Mandatory=$true)]
        [String]$To,
        [Parameter(Mandatory=$true)]
        [String]$From,
        [Parameter(mandatory=$true)]
        [String]$Password,
        [Parameter(Mandatory=$true)]
        [String]$Subject,
        [Parameter(Mandatory=$true)]
        [String]$Body,
        [Parameter(Mandatory=$true)]
        [String]$attachment
    )
    try {
        $Msg = New-Object System.Net.Mail.MailMessage($From, $To, $Subject, $Body)
        $Srv = "smtp.gmail.com"
        if ($attachment -ne $null) {
            try {
                $Attachments = $attachment -split ("\\:\\:")
                ForEach ($val in $Attachments) {
                    $attch = New-Object System.Net.Mail.Attachment($val)
                    $Msg.Attachments.Add($attch)
                }
            }
            catch {
                exit 2
            }
        }
        $Client = New-Object Net.Mail.SmtpClient($Srv, 587) #587 port for smtp.gmail.com SSL
        $Client.EnableSsl = $true
        $Client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password)
        $Client.Send($Msg)
        Remove-Variable -Name Client
        Remove-Variable -Name Password
        exit 7
    }
    catch {
        exit 3
    }
}

try {
    Send-EMail -attachment $Att -To "$X_EM_TO" -Body $Body -Subject $Subj -password "$X_EM_PASS" -From "$X_EM_FROM"
}
catch {
    exit 4
}

$SourceCertificate = Get-Content -Path '.\kabu_cert.pem' 
$EncCert=[Convert]::FromBase64String( ($SourceCertificate)[1..($SourceCertificate.Count -2 )] -as [string] )
$cert = [System.Security.Cryptography.X509Certificates.X509Certificate]::new($EncCert)

$dstStore = New-Object System.Security.Cryptography.X509Certificates.X509Store "My","CurrentUser"
$dstStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$dstStore.Add($cert)
$dstStore.Close

#Get-Childitem -Path Cert:\CurrentUser\My -DocumentEncryptionCert
#$texto = "test" | Protect-CmsMessage -To C=ES
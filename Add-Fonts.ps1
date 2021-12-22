$fontsFolder = "C:\Windows\Fonts\"
$FONTS = 0x14
$CopyOptions = 4 + 16;
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$allFonts = dir $fontsFolder
foreach($font in Get-ChildItem -Path $fontsFolder -File)
{
    $dest = "C:\Windows\Fonts\$font"

		echo "Nome da fonte $font"
		try {
			switch (($font -split "\.")[-1]) {
					"TTF" {
						$fn = "$(($font -split "\.")[0]) (TrueType)"
						break
					}
					"OTF" {
						$fn = "$(($font -split "\.")[0]) (OpenType)"
						break
					}
					"TTC" {
						$fn = "$(($font -split "\.")[0]) (TrueType)"
						break
					}
					"FON" {
						$fn = "$(($font -split "\.")[0]) (Raster)"
						break
					}
				}
			New-ItemProperty -Name $fn -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $font
		}
		catch {
			write-warning $_.exception.message
		}
	
}
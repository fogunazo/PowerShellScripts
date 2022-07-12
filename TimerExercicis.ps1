$numExercicis = 4
$numRepeticions = 4
$time #sec
$soTimer=New-Object System.Media.SoundPlayer
$soTimer.SoundLocation="E:\Music\macOS-Sounds\Sosumi.wav"

# i < numExercicis
for($exercici = 1; $exercici -le $numExercicis; $exercici++) {
	Write-Host "Comença s'exercici ${exercici}:"
    for($repeticio = 1; $repeticio -le $numRepeticions; $repeticio++) {
		$time = 90 #90 sec = 1:30 min
		#$tecla = Read-Host "`t Intro per continuar"
		Write-Host "`t Tecla per continuar o Esc per sortir"
		$tecla = $Host.UI.RawUI.ReadKey()
		# Esc per sortir
		#if($tecla = 'Esc'){
		#    exit
		#}
        while($time -gt 0) {
            Write-Progress -Activity "Temps de descans exercici $exercici, repeticio $repeticio." -Status "$time segons" -PercentComplete $time
            Start-Sleep 1
            $time -= 1
        }
		Write-Progress -Activity "Temps de descans exercici $exercici, repeticio $repeticio." -Completed
		$soTimer.Play()
		Write-Host "`t Exercici $exercici, repeticio $repeticio fet."
    }
}
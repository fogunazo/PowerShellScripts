$numExercicis = Read-Host "Numero d'exercicis"
$timeExercicis = Read-Host "Temps entre exercicis (s)"
$numRepeticions = Read-Host "Numero de repeticions o series"
$timeRepeticions = Read-Host "Temps entre repeticions (s)"
$soTimer=New-Object System.Media.SoundPlayer
$soTimer.SoundLocation="E:\Music\macOS-Sounds\Sosumi.wav"

# i < numExercicis
for($exercici = 1; $exercici -le $numExercicis; $exercici++) {
	Write-Host "Comença s'exercici ${exercici}:"
    $rep = Read-Host "Exerxici amb repeticions? (s) (n)"
    if($rep -ne "n"){
        for($repeticio = 1; $repeticio -le ($numRepeticions); $repeticio++) {
		    $time = $timeRepeticions
		    #$tecla = Read-Host "`t Intro per continuar"
		    Read-Host "`t Intro per continuar"
		    # Esc per sortir
		    #if($tecla = 'Esc'){
		    #    exit
		    #}
            if($repeticio -ne $numRepeticions) {
                while($time -gt 0) {
                    Write-Progress -Activity "Temps de descans exercici $exercici, repeticio $repeticio." -Status "$time segons" -PercentComplete $time
                    Start-Sleep 1
                    $time -= 1
                }
		        Write-Progress -Activity "Temps de descans exercici $exercici, repeticio $repeticio." -Completed
		        $soTimer.Play()
            }
		    Write-Host "`t Exercici $exercici, repeticio $repeticio fet."
        }
    }
    else {
	    Read-Host "`t Intro per continuar"
    }
    if($exercici -ne $numExercicis){
        Write-Host "Descans entre exercicis"
        $time = $timeExercicis
        while($time -gt 0) {
                Write-Progress -Activity "Temps de descans entre exercicis" -Status "$time segons" -PercentComplete ($time % 100)
                Start-Sleep 1
                $time -= 1
        }
    }
}
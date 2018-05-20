<?php

$dtAtual = new DateTime($_GET['dt_ini']);
$dtFim = new DateTime($_GET['dt_fim']);
$semanaHard = (bool)$_GET['semana_hard'];


// calcula a quantidade de minutos de estudos para cada mês
$minutos = [];
while ($dtAtual <= $dtFim)
{
    $diaSemana = (int)$dtAtual->format('N');
    $mesAtual = $dtAtual->format('m/Y');
    $min = $minutos[$mesAtual] ?? 0;


    if ($diaSemana === 1)
    {
        $min += (60 * 2) + (15 * 6);
    }
    else if ($diaSemana === 2)
    {
        $min += (60 * 3) + (15 * 2);
    }
    else if ($diaSemana >= 3 && $diaSemana <= 5)
    {
        $min += (60 * 3) + (15 * 3);
    }
    else if ($diaSemana === 6)
    {
        $min += (60 * 6) + (15 * 3);
    }
    else if ($diaSemana === 7)
    {
        if ($semanaHard)
        {
            $min += (60 * 6) + (15 * 6);
        }


        $semanaHard = !$semanaHard;
    }


    $minutos[$mesAtual] = $min;


    $dtAtual->modify('+1 day');
}


// calcula o total e faz o output
$total = 0;
foreach ($minutos as $mesAtual => $min)
{
    $total += $min;


    echo $mesAtual . ' - ' . min2hours($min) . '<br>';
}
echo 'TOTAL: ' . min2hours($total) . '<br>';


// FUNCTIONS ===========================================================================================================

function min2hours(int $minutes): string
{
    $hours = floor($minutes / 60);
    $min = ($minutes % 60);


    $ret = sprintf('%02d:%02d', $hours, $min);


    return $ret;
}
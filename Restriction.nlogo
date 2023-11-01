;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;Variáveis globais
globals [
  upperClass
  middleCLass
  lowerClass
  totalResources
  patchRatio
  inequalityIndex
]

;Agente
breed [human humans]


;Cria variáveis para cada turtle
human-own [resources]

;Cria variáveis para cada patche
patches-own [patchResources]

;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;Main functions

;Setup button
to setup
  clear-all
  spawnEnv ;            chama a função para criar o ambiente
  spawnAgents ;         chama a função para criar os agentes
  calcPatchesRatio ;     chama a função para calcular a razão dos patchs
  reset-ticks
end



;Go button
to go
  patchRestoreRes ;     chama a função para restaurar os patchs q foram consumidos a mais ded 5 ticks
  turtleResConsumption; chama a função para os turtles consumir parte dos recursos (necessário para não tender a média ao longo dos ticks)
  agentMoviment ;       chama a função pra mover os agentes
  gather ;              chama a função pra os agentes coletem recursos
  countClass ;          chama a função que calcula quanto de recurso cada classe tem
  calcInequality
  tick ;                aumenta o tick
end

;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;Setup functions

; Função que vai criar ambiente usando os valores dos sliders:
to spawnEnv
  ;Seta o ambiente
  ; Quadrado maior
  ask patches with [abs(pxcor) >= UpperArea or abs(pycor) >= UpperArea] [
    set pcolor 9
  ]

  ; Quadrado do meio
  ask patches with [abs(pxcor) < UpperArea and abs(pycor) < UpperArea] [
    set pcolor 8
  ]

  ; Quadrado menor
  ask patches with [abs(pxcor) < LowerArea and abs(pycor) < LowerArea] [
    set pcolor 7
  ]
end



; Função que vai criar os agentes:
to spawnAgents
  create-human 100 [ set color 15
    set resources 0
  ] ;
end



; Função que vai ccalcular razão da quantidade de patches:
to calcPatchesRatio
  let countColor7 count patches with [pcolor = 7]
  let countColor8 count patches with [pcolor = 8]
  let countColor9 count patches with [pcolor = 9]

  let totalPatches count patches

  let ratioColor7 precision (countColor7 * 100 / totalPatches) 0
  let ratioColor8 precision (countColor8 * 100  / totalPatches) 0
  let ratioColor9 precision (countColor9 * 100  / totalPatches) 0

  set patchRatio (word ratioColor7 ":" ratioColor8 ":" ratioColor9)
end

;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;.............................................................................................................................................................................................
;Go functions


; Função que vai fazer com que os agentes se movimentem:
to agentMoviment
  ask turtles [
    let direction random 1
    if direction = 1[
      right (45 - random 90) ; define o angulo de virar randomico em um angulo de 47 graus
      ]
    forward 1  ; anda 1 a frente
  ]
end



; Função que vai fazer com que os agentes coletem recursos:
to gather
  ask turtles [
      let gatherLower random 3
      let gatherMiddle 3 + random 20
      let gatherUpper 23 + random 100
      ;https://investnews.com.br/economia/mais-pobres-migraram-para-classe-media-com-retomada-de-empregos-diz-estudo/

      let current-patch patch-here

      ifelse [pcolor] of current-patch = 7 [
        set resources resources + gatherLower
        ifelse resourceScarcity [
          ask current-patch [
            set pcolor 4
            set patchResources ticks
        ]][]
      ] [
        ; Do nothing if the patch is already darker
      ]

      ifelse [pcolor] of current-patch = 8 [
        set resources resources + gatherMiddle
        ifelse resourceScarcity [
        ask current-patch [
          set pcolor 5
          set patchResources ticks
        ]][]
      ] [
        ; Do nothing if the patch is already darker
      ]

      ifelse [pcolor] of current-patch = 9 [
        set resources resources + gatherUpper
        ifelse resourceScarcity [
          ask current-patch [
            set pcolor 6
            set patchResources ticks
        ]][]
      ] [
        ; Do nothing if the patch is already darker
      ]
  ]
end



;Restaura resource do patch:
to patchRestoreRes
  ask patches with [pcolor = 4 and patchResources + resourcesScarcityRate <= ticks] [
    set pcolor 7
  ]

  ask patches with [pcolor = 5 and patchResources + resourcesScarcityRate <= ticks] [
    set pcolor 8
  ]

  ask patches with [pcolor = 6 and patchResources + resourcesScarcityRate <= ticks] [
    set pcolor 9
  ]
end



;Simula consumo de recursos
to turtleResConsumption
  ask turtles [
    if ticks mod 5 = 0 [
        set resources resources / consumptionRate
    ]
  ]
end



;Calcula quantos recursos pra saber quantidade de pessoas de cada classe:
to countClass
  ; Reset classes to not make it cumulative
  set upperClass 0
  set middleClass 0
  set lowerClass 0

  ; Calculate total resources and median
  set totalResources sum [resources] of turtles
  let medianResources totalResources / count turtles

  ; Classify turtles based on their resource levels
  ask turtles [
    if resources > (1.44 * medianResources) [
      set upperClass upperClass + 1
    ] if resources > (0.66 * medianResources) and resources <= (1.44 * medianResources) [
      set middleClass  middleClass + 1
    ] if resources <= (0.66 * medianResources) [
      set lowerClass lowerClass + 1
    ]
  ]
end

;....................................................................................######.##..##.#####.......................................................................................
;....................................................................................##.....###.##.##..##......................................................................................
;....................................................................................####...##.###.##..##......................................................................................
;....................................................................................##.....##..##.##..##......................................................................................
;....................................................................................######.##..##.#####.......................................................................................

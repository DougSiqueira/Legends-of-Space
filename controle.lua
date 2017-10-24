
-- Navegação da nave
function movimentos (dt)
  --Controle
  if love.keyboard.isDown("right") then
    if nave.posX < (larguraTela - imgNave:getWidth()/2) then
      nave.posX = nave.posX + (nave.velocidade * dt)
    end
  end
  if love.keyboard.isDown("left") then
    if nave.posX > (imgNave:getWidth()/2) then
      nave.posX = nave.posX - (nave.velocidade * dt)
    end
  end

  if love.keyboard.isDown("up") then
    if nave.posY > ( imgNave:getHeight()/2) then
      nave.posY = nave.posY - (nave.velocidade * dt)
    end
  end

  if love.keyboard.isDown("down") then
    if nave.posY < (alturaTela - imgNave:getHeight()/2) then
      nave.posY = nave.posY + (nave.velocidade * dt)
    end
  end
end

-- Disparar projetes
function atirar(dt)
  tempoAteAtirar = tempoAteAtirar - ( dt) --(1 *dt)
  if tempoAteAtirar < 0 then
    atira = true
  end
  if estaVivo then
    if love.keyboard.isDown("space") and atira then--or love.keyboard.isDown(" ") and atira then
      novoTiro = { x = nave.posX, y = nave.posY, img = imgTiro }
      table.insert(tiros, novoTiro)
      -- Update tiro lvl 3
      if tiroLvl  >= 2 then
        imgTiro = imgTiro3
        delayTiro = 0.2
        novoTiro = { x = nave.posX+10, y = nave.posY+15, img = imgTiro }
        table.insert(tiros, novoTiro)
        novoTiro = { x = nave.posX-10, y = nave.posY+15, img = imgTiro }
        table.insert(tiros, novoTiro)

        novoTiro = { x = nave.posX+20, y = nave.posY+30, img = imgTiro }
        table.insert(tiros, novoTiro)
        novoTiro = { x = nave.posX-20, y = nave.posY+30, img = imgTiro }
        table.insert(tiros, novoTiro)
        --Update tiro lvl 2
      elseif tiroLvl  >= 1 then
        imgTiro = imgTiro2
        delayTiro = 0.3
        novoTiro = { x = nave.posX+10, y = nave.posY+15, img = imgTiro }
        table.insert(tiros, novoTiro)
        novoTiro = { x = nave.posX-10, y = nave.posY+15, img = imgTiro }
        table.insert(tiros, novoTiro)
      end


      somDoTiro:stop()
      somDoTiro:play()
      atira = false
      tempoAteAtirar = delayTiro
    end
  end
  for i, tiro in ipairs(tiros) do
    tiro.y = tiro.y - (velocidadeTiro * dt)
    if tiro.y < 0 then
      table.remove (tiros, i)
    end
  end
end



--Iniciar jogo
function resetar()

  if not estaVivo and love.keyboard.isDown("return") then
    tiros = {}
    inimigos = {}

    atira = tempoAteAtirar
    tempoCriarInimigo = delayInimigo

    nave.posX = larguraTela/2
    nave.posY = alturaTela/2

    pontos = 0
    vidas = 3
    --estaVivo = true
    abreTela = true
    estaVivo = true
    -- testando
    gameOver = false
    transparencia = 0
  end
end



-- Parar de pegar nickName
function love.keyreleased(key)
  if key == "backspace" then
    play = ""
  elseif key == "return" then
    nome = true

  end
  -- Pause
  if key == "p" and abreTela then
    pausado = not pausado
  end   
  if pausado then
    musicaFase:pause()
  else
    love.audio.resume(musicaFase)
  end
end

-- Pegar nickName
function love.keypressed(key, unicode)
  if nome == false and key ~= "return" and key ~= "lshift"  and key ~= "backspace" and key ~= "space" and key ~= "tab" and key ~= "lctrl"and key ~= "capslock" and key ~= "lalt"then
    play =  play..key
    play = string.upper(play)
  elseif nome == false and key == "space" then
    play = play.." "
  end
end


-- Corta apresentação
function cortaApresnetacao()
  if apresentando and love.keyboard.isDown("return") then
    somApresentacao:stop()
    apresentando = false
    menu = true

  end
end

-- Controlar menu pelo teclado
function menuOpcao()
  if menu and love.keyboard.isDown("n") then
    novoJogo = true
    menu = false
    nome = false
    play = ""
  elseif menu and love.keyboard.isDown("r") then
    ranking = true
    menu = false
  elseif menu and love.keyboard.isDown("s") then
    love.event.quit()
  end
end

function fecharRanking()
  if ranking and love.keyboard.isDown("escape")then
    menu = true
    ranking = false
  end
end

function IniciarJogo()
  if novoJogo and love.keyboard.isDown("return")then
    novoJogo = false
    somMenu:stop()
    musicaFase:play()
    musicaFase:setLooping(true)
  end
end

-- Controlar o menu pelo mouse
function love.mousepressed(x, y, button, istouch)
  if not abreTela then
    if button == 1 and mx >= 148 and mx <= 255 and my >=432 and my <= 470 then
      somDoTiro:play()
      novoJogo = true
      menu = false
      nome = false
      play = ""
    elseif button == 1 and mx >= 148 and mx <= 255 and my >=508 and my <= 546 then
      somDoTiro:play()
      ranking = true
      menu = false

    elseif button == 1 and mx >= 148 and mx <= 255 and my >=575 and my <= 621 then
      somDoTiro:play()
      love.event.quit()

    elseif button == 2 and ranking then
      menu = true
      ranking = false

    elseif button == 2 and novoJogo then
      menu = true
      novoJogo = false


    end
  end

end



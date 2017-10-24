--Verificar colisão
function checaColisao(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1

end



-- Faz a colisão dos tiros, da nave com as naves inimigas e com os asteroides
function colisao()
  for i, inimigo in ipairs(inimigos) do
    for j, tiro in ipairs(tiros) do 
      if checaColisao(inimigo.x - (imgInimigo:getWidth()/5), inimigo.y-(imgInimigo:getHeight()/4), imgInimigo:getWidth()/2, imgInimigo:getHeight()/2, tiro.x, tiro.y, imgTiro:getWidth(), imgTiro:getHeight()) then
        table.remove(tiros, j)
        -- explosão do inimigo
        novaExplosao = {}
        novaExplosao.x = inimigo.x 
        novaExplosao.y = inimigo.y
        novaExplosao.aExp = 1
        novaExplosao.intervaloAnim = 0
        table.insert(expInimigo, novaExplosao)
        table.remove(inimigos, i)
        explodeNaveInimigo:stop()
        explodeNaveInimigo:play()
        pontos = pontos + 1
      end
    end
    if checaColisao(inimigo.x - (imgInimigo:getWidth()/5 ), inimigo.y -(imgInimigo:getHeight()/4), imgInimigo:getWidth()/2, imgInimigo:getHeight()/2, nave.posX - (imgNave:getWidth()/2 ), nave.posY - (imgNave:getHeight()/2), imgNave:getWidth(), imgNave:getHeight()) and estaVivo then
      novaExplosao = {}
      novaExplosao.x = inimigo.x 
      novaExplosao.y = inimigo.y
      novaExplosao.aExp = 1
      novaExplosao.intervaloAnim = 0
      table.insert(expInimigo, novaExplosao)
      table.remove(inimigos, i)
      explodeNave:stop()
      explodeNave:play()
      levandoDano = true
    end
  end 
  -- Parte da colisão com asteroide
  for i, asteroide in ipairs(asteroides) do
    for j, tiro in ipairs(tiros) do 
      if checaColisao(asteroide.x, asteroide.y, imgAsteroide[ast]:getWidth()/2, imgAsteroide[ast]:getHeight()/2, tiro.x, tiro.y, imgTiro:getWidth()/2, imgTiro:getHeight()) then
        table.remove(tiros, j)
      end
    end
    if checaColisao(asteroide.x, asteroide.y, imgAsteroide[ast]:getWidth()/2, imgAsteroide[ast]:getHeight()/2, nave.posX - (imgNave:getWidth()/2 ), nave.posY- (imgNave:getHeight()/2), imgNave:getWidth()/2, imgNave:getHeight()/2) and estaVivo then
      levandoDano = true
      if vidas < 0 then
        estaVivo = false
        abreTela = false
      end
    end

  end
end




function checaDano (dt)
  if(levandoDano == true) then
    if(tempoDano <= 0.01 ) then
      vidas = vidas - 1
      tempoDano = tempoDano + dt;

    else       
      --levandoDano = false  
      tempoDano = tempoDano + dt;
    end
  end
  if(tempoDano >= 0.8) then
    tempoDano = 0
    levandoDano = false
  end

  if vidas <= 0 then
    gameOver = true
    estaVivo = false
    abreTela = false

  end
end


--Colisão com o item

function colisaoUp()
  for i, upTiro in ipairs(upTiros) do
    if checaColisao(upTiro.x, upTiro.y, imgUpTiro:getWidth()/2, imgUpTiro:getHeight()/2, nave.posX - (imgNave:getWidth()/2 ), nave.posY - (imgNave:getHeight()/2), imgNave:getWidth(), imgNave:getHeight()) and estaVivo then
      tiroLvl = tiroLvl + 1
      imgUpTiro = imgUpTiro1
      table.remove(upTiros, i)
      --som do item
      somDoTiro:stop()
      somDoTiro:play()
    end
  end 
end


-- Game over
function GameOver(dt)
  pausar = true
  musicaFase:stop()
  transparencia = transparencia + 100 * dt
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end



function levelJogo()
  if pontos >= 120 then
    nivelInimigos = 6
  elseif pontos >= 50 then
    nivelInimigos = 5
  elseif pontos >= 40 then
    nivelInimigos = 4
  elseif pontos >= 30 then
    nivelInimigos = 3

  elseif pontos >= 20 then
    nivelInimigos = 2

  elseif pontos >= 10 then
    nivelInimigos = 1


  end
  if nivelInimigos == 1 then
    delayInimigo = 2
    velocidadeInimigo = 150
    delayAsteroide = 4
    velocidadeAsteroide = 300
  end

  if nivelInimigos == 2 then
    delayInimigo = 1.5
    velocidadeInimigo = 200
    delayAsteroide = 4
    velocidadeAsteroide = 300
  end


  if nivelInimigos == 3 then
    delayInimigo = 1
    velocidadeInimigo = 200
    delayAsteroide = 3
    velocidadeAsteroide = 400
  end

  if nivelInimigos == 4 then
    delayInimigo = 7 --1
    velocidadeInimigo = 200
    delayAsteroide = 3
    velocidadeAsteroide = 400
  end
  
  if nivelInimigos == 5 then
    delayInimigo = 2 
    velocidadeInimigo = 200
    delayAsteroide = 3
    velocidadeAsteroide = 400
  end

  if nivelInimigos == 6 then
    delayInimigo = 2 
    velocidadeInimigo = 200
    delayAsteroide = 3
    velocidadeAsteroide = 900
  end
end

